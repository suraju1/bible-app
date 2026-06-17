import 'package:freezed_annotation/freezed_annotation.dart';

part 'leaderboard_user.freezed.dart';

@freezed
class LeaderboardUser with _$LeaderboardUser {
  const factory LeaderboardUser({
    required String id,
    required String name,
    required String avatarUrl,
    required int rank,
    required int score,
    required int level,
    @Default(false) bool isCurrentUser,
  }) = _LeaderboardUser;
}
