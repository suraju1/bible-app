import 'package:dio/dio.dart';
import '../models/challenge_model.dart';
import '../models/quiz_category_model.dart';
import '../models/dashboard_data_model.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardDataModel> getDashboardData();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final Dio dio;

  DashboardRemoteDataSourceImpl(this.dio);

  @override
  Future<DashboardDataModel> getDashboardData() async {
    // Mock API call to simulate network request
    await Future.delayed(const Duration(milliseconds: 800));

    return const DashboardDataModel(
      userName: 'Caroline Hugo',
      userAvatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=150&q=80',
      dailyStreak: 4,
      rank: 892,
      level: 7,
      levelProgress: 0.7, // e.g., 70% level completion progress
      points: 10,
      todayChallenge: ChallengeModel(
        title: 'Think Better.\nChoose Better.',
        description: 'Answer mindset-based questions and improve your daily thinking habits.',
        progress: 0.0,
      ),
      categories: [
        QuizCategoryModel(
          id: 'live_quiz_mode',
          title: 'Live Quiz\nMode',
          iconType: 'live_quiz',
        ),
        QuizCategoryModel(
          id: 'discipline_challenge',
          title: 'Discipline\nChallenge',
          iconType: 'discipline_challenge',
        ),
      ],
      notificationBadgeCount: 3,
    );
  }
}
