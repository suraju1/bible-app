import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/notification_settings_model.dart';
import '../../data/repositories/notification_settings_repository.dart';

final notificationSettingsRepositoryProvider = Provider<NotificationSettingsRepository>((ref) {
  return NotificationSettingsRepository();
});

final notificationSettingsProvider = AsyncNotifierProvider<NotificationSettingsNotifier, NotificationSettingsModel>(() {
  return NotificationSettingsNotifier();
});

class NotificationSettingsNotifier extends AsyncNotifier<NotificationSettingsModel> {
  late final NotificationSettingsRepository _repository;

  @override
  Future<NotificationSettingsModel> build() async {
    _repository = ref.read(notificationSettingsRepositoryProvider);
    return _repository.getSettings();
  }

  Future<void> toggleNotifications(bool enabled) async {
    // Optimistic update
    final previousState = state.value;
    if (previousState == null) return;
    
    state = AsyncValue.data(
      previousState.copyWith(
        notificationsEnabled: enabled,
        soundEnabled: enabled ? previousState.soundEnabled : false,
      )
    );

    try {
      await _repository.updateNotificationsEnabled(enabled);
    } catch (e, st) {
      // Revert on error
      state = AsyncValue.data(previousState);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> toggleSound(bool enabled) async {
    final currentState = state.value;
    if (currentState == null || !currentState.notificationsEnabled) return; // Cannot toggle sound if notifications are off

    // Optimistic update
    state = AsyncValue.data(
      currentState.copyWith(soundEnabled: enabled)
    );

    try {
      await _repository.updateSoundEnabled(enabled);
    } catch (e, st) {
      // Revert on error
      state = AsyncValue.data(currentState);
      state = AsyncValue.error(e, st);
    }
  }
}
