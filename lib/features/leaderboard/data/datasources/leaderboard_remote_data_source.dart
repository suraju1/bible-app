import 'package:dio/dio.dart';
import '../../domain/entities/leaderboard_filter.dart';
import '../models/leaderboard_user_model.dart';

abstract class LeaderboardRemoteDataSource {
  Future<List<LeaderboardUserModel>> getLeaderboard(LeaderboardFilter filter);
}

class LeaderboardRemoteDataSourceImpl implements LeaderboardRemoteDataSource {
  final Dio dio;

  LeaderboardRemoteDataSourceImpl(this.dio);

  @override
  Future<List<LeaderboardUserModel>> getLeaderboard(LeaderboardFilter filter) async {
    // Mock network delay
    await Future.delayed(const Duration(seconds: 1));

    // In a real implementation:
    // final response = await dio.get('/api/leaderboard', queryParameters: {
    //   'timeframe': filter.timeframe.name,
    //   if (filter.languageId != null) 'language': filter.languageId,
    //   if (filter.bibleVersionId != null) 'version': filter.bibleVersionId,
    // });
    // return (response.data as List).map((x) => LeaderboardUserModel.fromJson(x)).toList();

    // Mock data
    return [
      const LeaderboardUserModel(
        id: '1',
        name: 'Sarah Jenkins',
        avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=150&q=80',
        rank: 1,
        score: 12450,
        level: 24,
      ),
      const LeaderboardUserModel(
        id: '2',
        name: 'Michael Chen',
        avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=150&q=80',
        rank: 2,
        score: 11200,
        level: 21,
      ),
      const LeaderboardUserModel(
        id: '3',
        name: 'Elena Rodriguez',
        avatarUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&w=150&q=80',
        rank: 3,
        score: 10850,
        level: 19,
      ),
      const LeaderboardUserModel(
        id: '4',
        name: 'David Kim',
        avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=150&q=80',
        rank: 4,
        score: 9500,
        level: 15,
      ),
      const LeaderboardUserModel(
        id: '5',
        name: 'Jessica Smith',
        avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=150&q=80',
        rank: 5,
        score: 8900,
        level: 14,
      ),
      const LeaderboardUserModel(
        id: 'user_123',
        name: 'Caroline Hugo',
        avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=150&q=80',
        rank: 892,
        score: 1450,
        level: 7,
        isCurrentUser: true,
      ),
      const LeaderboardUserModel(
        id: '7',
        name: 'Alex Johnson',
        avatarUrl: 'https://images.unsplash.com/photo-1527980965255-d3b416303d12?auto=format&fit=crop&w=150&q=80',
        rank: 893,
        score: 1430,
        level: 7,
      ),
      const LeaderboardUserModel(
        id: '8',
        name: 'Rachel Green',
        avatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=150&q=80',
        rank: 894,
        score: 1410,
        level: 7,
      ),
    ];
  }
}
