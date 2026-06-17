import '../../domain/entities/leaderboard_filter.dart';
import '../../domain/entities/leaderboard_user.dart';
import '../../domain/repositories/leaderboard_repository.dart';
import '../datasources/leaderboard_remote_data_source.dart';

class LeaderboardRepositoryImpl implements LeaderboardRepository {
  final LeaderboardRemoteDataSource remoteDataSource;

  LeaderboardRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<LeaderboardUser>> getLeaderboard(LeaderboardFilter filter) async {
    final models = await remoteDataSource.getLeaderboard(filter);
    return models.map((model) => model.toEntity()).toList();
  }
}
