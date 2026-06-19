import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/achievement_model.dart';

// Mock repository logic for now
class AchievementRepository {
  Future<AchievementModel> fetchAchievements() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    return AchievementModel(
      currentLevel: 1,
      nextLevel: 2,
      progressPercentage: 50.0,
      currentRank: 'Bronze',
      totalScore: 100,
      dailyStreak: 10,
      unlockedRanks: ['Bronze'],
    );
  }
}

final achievementRepositoryProvider = Provider<AchievementRepository>((ref) {
  return AchievementRepository();
});

final achievementProvider = FutureProvider.autoDispose<AchievementModel>((ref) async {
  final repo = ref.read(achievementRepositoryProvider);
  return repo.fetchAchievements();
});
