import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/leaderboard_user.dart';

part 'leaderboard_user_model.freezed.dart';
part 'leaderboard_user_model.g.dart';

@freezed
class LeaderboardUserModel with _$LeaderboardUserModel {
  const LeaderboardUserModel._();

  const factory LeaderboardUserModel({
    required String id,
    required String name,
    required String avatarUrl,
    required int rank,
    required int score,
    required int level,
    @Default(false) bool isCurrentUser,
  }) = _LeaderboardUserModel;

  factory LeaderboardUserModel.fromJson(Map<String, dynamic> json) => _$LeaderboardUserModelFromJson(json);

  LeaderboardUser toEntity() {
    return LeaderboardUser(
      id: id,
      name: name,
      avatarUrl: avatarUrl,
      rank: rank,
      score: score,
      level: level,
      isCurrentUser: isCurrentUser,
    );
  }
}
