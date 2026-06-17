import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/dashboard_data.dart';
import 'challenge_model.dart';
import 'quiz_category_model.dart';

part 'dashboard_data_model.freezed.dart';
part 'dashboard_data_model.g.dart';

@freezed
class DashboardDataModel with _$DashboardDataModel {
  const factory DashboardDataModel({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'user_name') required String userName,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'user_avatar_url') String? userAvatarUrl,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'daily_streak') required int dailyStreak,
    required int rank,
    required int level,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'level_progress') required double levelProgress,
    required int points,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'today_challenge') required ChallengeModel todayChallenge,
    required List<QuizCategoryModel> categories,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'notification_badge_count') required int notificationBadgeCount,
  }) = _DashboardDataModel;

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) => _$DashboardDataModelFromJson(json);
}

extension DashboardDataModelX on DashboardDataModel {
  DashboardData toEntity() {
    return DashboardData(
      userName: userName,
      userAvatarUrl: userAvatarUrl,
      dailyStreak: dailyStreak,
      rank: rank,
      level: level,
      levelProgress: levelProgress,
      points: points,
      todayChallenge: todayChallenge.toEntity(),
      categories: categories.map((c) => c.toEntity()).toList(),
      notificationBadgeCount: notificationBadgeCount,
    );
  }
}
