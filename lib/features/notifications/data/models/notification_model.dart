import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/notification_item.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String id,
    required String title,
    required String message,
    required DateTime timestamp,
    @Default(false) bool isRead,
    required String type,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}

extension NotificationModelX on NotificationModel {
  NotificationItem toEntity() {
    return NotificationItem(
      id: id,
      title: title,
      message: message,
      timestamp: timestamp,
      isRead: isRead,
      type: type,
    );
  }
}
