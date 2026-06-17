import '../entities/leaderboard_filter.dart';
import '../entities/leaderboard_user.dart';
import '../repositories/leaderboard_repository.dart';

class GetLeaderboardData {
  final LeaderboardRepository repository;

  GetLeaderboardData(this.repository);

  Future<List<LeaderboardUser>> execute(LeaderboardFilter filter) async {
    return await repository.getLeaderboard(filter);
  }
}
