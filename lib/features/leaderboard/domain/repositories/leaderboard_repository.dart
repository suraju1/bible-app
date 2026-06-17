import '../entities/leaderboard_filter.dart';
import '../entities/leaderboard_user.dart';

abstract class LeaderboardRepository {
  Future<List<LeaderboardUser>> getLeaderboard(LeaderboardFilter filter);
}
