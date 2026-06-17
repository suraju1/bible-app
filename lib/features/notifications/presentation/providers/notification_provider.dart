import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/notification_item.dart';
import '../../domain/repositories/notification_repository.dart';
import '../../data/datasources/notification_remote_data_source.dart';
import '../../data/repositories/notification_repository_impl.dart';

// Dependency Injection
final notificationDioProvider = Provider<Dio>((ref) {
  // Use the app-wide authenticated Dio client
  return ref.watch(dioProvider);
});

final notificationRemoteDataSourceProvider = Provider<NotificationRemoteDataSource>((ref) {
  return NotificationRemoteDataSourceImpl(dio: ref.watch(notificationDioProvider));
});

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepositoryImpl(remoteDataSource: ref.watch(notificationRemoteDataSourceProvider));
});

// State Management
class NotificationState {
  final AsyncValue<List<NotificationItem>> notifications;

  NotificationState({this.notifications = const AsyncValue.loading()});

  NotificationState copyWith({
    AsyncValue<List<NotificationItem>>? notifications,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
    );
  }
}

class NotificationNotifier extends StateNotifier<NotificationState> {
  final NotificationRepository repository;

  NotificationNotifier(this.repository) : super(NotificationState()) {
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    state = state.copyWith(notifications: const AsyncValue.loading());
    try {
      final items = await repository.getNotifications();
      state = state.copyWith(notifications: AsyncValue.data(items));
    } catch (e, stack) {
      state = state.copyWith(notifications: AsyncValue.error(e, stack));
    }
  }

  Future<void> markAsRead(String id) async {
    // Optimistic UI update
    if (state.notifications is AsyncData) {
      final currentList = state.notifications.value!;
      final index = currentList.indexWhere((n) => n.id == id);
      if (index != -1 && !currentList[index].isRead) {
        final updatedList = List<NotificationItem>.from(currentList);
        updatedList[index] = updatedList[index].copyWith(isRead: true);
        state = state.copyWith(notifications: AsyncValue.data(updatedList));

        // Background API update
        try {
          await repository.markAsRead(id);
        } catch (e) {
          // Revert on failure (optional)
          // state = state.copyWith(notifications: AsyncValue.data(currentList));
        }
      }
    }
  }
}

final notificationProvider = StateNotifierProvider<NotificationNotifier, NotificationState>((ref) {
  return NotificationNotifier(ref.watch(notificationRepositoryProvider));
});
