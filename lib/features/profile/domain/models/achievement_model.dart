class AchievementModel {
  final int currentLevel;
  final int nextLevel;
  final double progressPercentage;
  final String currentRank;
  final int totalScore;
  final int dailyStreak;
  final List<String> unlockedRanks;

  AchievementModel({
    required this.currentLevel,
    required this.nextLevel,
    required this.progressPercentage,
    required this.currentRank,
    required this.totalScore,
    required this.dailyStreak,
    required this.unlockedRanks,
  });

  factory AchievementModel.fromJson(Map<String, dynamic> json) {
    return AchievementModel(
      currentLevel: json['current_level'] ?? 1,
      nextLevel: json['next_level'] ?? 2,
      progressPercentage: (json['progress_percentage'] ?? 0.0).toDouble(),
      currentRank: json['current_rank'] ?? 'Bronze',
      totalScore: json['total_score'] ?? 0,
      dailyStreak: json['daily_streak'] ?? 0,
      unlockedRanks: List<String>.from(json['unlocked_ranks'] ?? []),
    );
  }
}
