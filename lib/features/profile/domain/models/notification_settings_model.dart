class NotificationSettingsModel {
  final bool notificationsEnabled;
  final bool soundEnabled;

  const NotificationSettingsModel({
    required this.notificationsEnabled,
    required this.soundEnabled,
  });

  NotificationSettingsModel copyWith({
    bool? notificationsEnabled,
    bool? soundEnabled,
  }) {
    return NotificationSettingsModel(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
    );
  }
}
