import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/correction_task.dart';
import '../../domain/repositories/correction_quiz_repository.dart';
import '../../data/datasources/correction_quiz_remote_data_source.dart';
import '../../data/repositories/correction_quiz_repository_impl.dart';

// Dependency Injection
final correctionQuizDioProvider = Provider<Dio>((ref) => ref.watch(dioProvider));

final correctionQuizRemoteDataSourceProvider = Provider<CorrectionQuizRemoteDataSource>((ref) {
  return CorrectionQuizRemoteDataSourceImpl(dio: ref.watch(correctionQuizDioProvider));
});

final correctionQuizRepositoryProvider = Provider<CorrectionQuizRepository>((ref) {
  return CorrectionQuizRepositoryImpl(remoteDataSource: ref.watch(correctionQuizRemoteDataSourceProvider));
});

// State classes
class CorrectionTaskListState {
  final AsyncValue<List<CorrectionTask>> tasks;
  CorrectionTaskListState({this.tasks = const AsyncValue.loading()});

  CorrectionTaskListState copyWith({AsyncValue<List<CorrectionTask>>? tasks}) {
    return CorrectionTaskListState(tasks: tasks ?? this.tasks);
  }
}

class CorrectionTaskListNotifier extends StateNotifier<CorrectionTaskListState> {
  final CorrectionQuizRepository repository;

  CorrectionTaskListNotifier(this.repository) : super(CorrectionTaskListState()) {
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    state = state.copyWith(tasks: const AsyncValue.loading());
    try {
      final items = await repository.getAvailableCorrectionTasks();
      state = state.copyWith(tasks: AsyncValue.data(items));
    } catch (e, stack) {
      state = state.copyWith(tasks: AsyncValue.error(e, stack));
    }
  }
}

final correctionTaskListProvider = StateNotifierProvider<CorrectionTaskListNotifier, CorrectionTaskListState>((ref) {
  return CorrectionTaskListNotifier(ref.watch(correctionQuizRepositoryProvider));
});

// Task Details Provider
final correctionTaskDetailsProvider = FutureProvider.family<CorrectionTask, String>((ref, id) {
  final repo = ref.watch(correctionQuizRepositoryProvider);
  return repo.getCorrectionTaskDetails(id);
});
