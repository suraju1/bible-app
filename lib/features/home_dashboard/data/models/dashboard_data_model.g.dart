// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardDataModelImpl _$$DashboardDataModelImplFromJson(
  Map<String, dynamic> json,
) => _$DashboardDataModelImpl(
  userName: json['user_name'] as String,
  userAvatarUrl: json['user_avatar_url'] as String?,
  dailyStreak: (json['daily_streak'] as num).toInt(),
  rank: (json['rank'] as num).toInt(),
  level: (json['level'] as num).toInt(),
  levelProgress: (json['level_progress'] as num).toDouble(),
  points: (json['points'] as num).toInt(),
  todayChallenge: ChallengeModel.fromJson(
    json['today_challenge'] as Map<String, dynamic>,
  ),
  categories: (json['categories'] as List<dynamic>)
      .map((e) => QuizCategoryModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  notificationBadgeCount: (json['notification_badge_count'] as num).toInt(),
);

Map<String, dynamic> _$$DashboardDataModelImplToJson(
  _$DashboardDataModelImpl instance,
) => <String, dynamic>{
  'user_name': instance.userName,
  'user_avatar_url': instance.userAvatarUrl,
  'daily_streak': instance.dailyStreak,
  'rank': instance.rank,
  'level': instance.level,
  'level_progress': instance.levelProgress,
  'points': instance.points,
  'today_challenge': instance.todayChallenge,
  'categories': instance.categories,
  'notification_badge_count': instance.notificationBadgeCount,
};
