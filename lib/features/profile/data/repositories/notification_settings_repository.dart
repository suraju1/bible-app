import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/notification_settings_model.dart';

class NotificationSettingsRepository {
  static const String _notificationsEnabledKey = 'notifications_enabled';
  static const String _soundEnabledKey = 'notification_sound_enabled';

  Future<NotificationSettingsModel> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Default to true if not set
    final notificationsEnabled = prefs.getBool(_notificationsEnabledKey) ?? true;
    
    // Default to true if not set, but force false if notifications are disabled
    bool soundEnabled = prefs.getBool(_soundEnabledKey) ?? true;
    if (!notificationsEnabled) {
      soundEnabled = false;
    }

    return NotificationSettingsModel(
      notificationsEnabled: notificationsEnabled,
      soundEnabled: soundEnabled,
    );
  }

  Future<void> updateNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsEnabledKey, enabled);
    
    // If notifications are disabled, also disable sound
    if (!enabled) {
      await prefs.setBool(_soundEnabledKey, false);
    }
    
    // Mock API call to sync with backend and register/unregister FCM token
    await _syncWithBackend(enabled);
  }

  Future<void> updateSoundEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_soundEnabledKey, enabled);
  }

  Future<void> _syncWithBackend(bool notificationsEnabled) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    // In a real app, you would do something like:
    // if (notificationsEnabled) {
    //   final token = await FirebaseMessaging.instance.getToken();
    //   await api.registerFcmToken(token);
    // } else {
    //   await api.unregisterFcmToken();
    // }
  }
}
