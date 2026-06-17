import 'challenge.dart';
import 'quiz_category.dart';

class DashboardData {
  final String userName;
  final String? userAvatarUrl;
  final int dailyStreak;
  final int rank;
  final int level;
  final double levelProgress; // 0.0 to 1.0
  final int points;
  final Challenge todayChallenge;
  final List<QuizCategory> categories;
  final int notificationBadgeCount;

  DashboardData({
    required this.userName,
    this.userAvatarUrl,
    required this.dailyStreak,
    required this.rank,
    required this.level,
    required this.levelProgress,
    required this.points,
    required this.todayChallenge,
    required this.categories,
    required this.notificationBadgeCount,
  });
}
