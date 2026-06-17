import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/datasources/leaderboard_remote_data_source.dart';
import '../../data/repositories/leaderboard_repository_impl.dart';
import '../../domain/entities/leaderboard_filter.dart';
import '../../domain/entities/leaderboard_user.dart';
import '../../domain/repositories/leaderboard_repository.dart';
import '../../domain/usecases/get_leaderboard_data.dart';

final leaderboardRemoteDataSourceProvider = Provider<LeaderboardRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return LeaderboardRemoteDataSourceImpl(dio);
});

final leaderboardRepositoryProvider = Provider<LeaderboardRepository>((ref) {
  final remoteDataSource = ref.watch(leaderboardRemoteDataSourceProvider);
  return LeaderboardRepositoryImpl(remoteDataSource);
});

final getLeaderboardDataUseCaseProvider = Provider<GetLeaderboardData>((ref) {
  final repository = ref.watch(leaderboardRepositoryProvider);
  return GetLeaderboardData(repository);
});

final leaderboardFilterProvider = StateProvider<LeaderboardFilter>((ref) {
  return const LeaderboardFilter();
});

final leaderboardDataProvider = FutureProvider.autoDispose<List<LeaderboardUser>>((ref) async {
  final filter = ref.watch(leaderboardFilterProvider);
  final useCase = ref.watch(getLeaderboardDataUseCaseProvider);
  return useCase.execute(filter);
});
