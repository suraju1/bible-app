import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../providers/profile_provider.dart';
import '../providers/achievement_provider.dart';
import '../widgets/rank_badge_widget.dart';
import '../widgets/statistic_card_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievementAsync = ref.watch(achievementProvider);
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      body: achievementAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (achievement) {
          final profile = profileAsync.valueOrNull;

          return Stack(
            children: [
              // Gradient Background Header
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Gradient.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    // Top Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (context.canPop()) {
                                context.pop();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Center(
                              child: Text(
                                'Achievements',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 32), // Balance the back button
                        ],
                      ),
                    ),

                    // User Info Section
                    const SizedBox(height: 16),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.orange.shade200,
                      child: CircleAvatar(
                        radius: 38,
                        backgroundImage: profile != null
                            ? NetworkImage(profile.imageUrl)
                            : null,
                        child: profile == null
                            ? const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      profile?.name ?? 'User',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Main Content Container
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              children: [
                                // Large Level Badge
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      _getRankAsset(achievement.currentRank),
                                      width: 100,
                                      height: 100,
                                    ),
                                    Text(
                                      achievement.currentLevel.toString(),
                                      style: const TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Level',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2C3E50),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Progress Bar
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      achievement.currentLevel.toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          height: 14,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey.shade400,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: LinearProgressIndicator(
                                            value:
                                                achievement.progressPercentage /
                                                100,

                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  AppColors.primary,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      achievement.nextLevel.toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),

                                // Ranks Title
                                const Text(
                                  'Rank',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2C3E50),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Ranks Grid
                                Wrap(
                                  spacing: 12,
                                  runSpacing: 20,
                                  alignment: WrapAlignment.center,
                                  children: _buildRankBadges(
                                    achievement.currentLevel,
                                    achievement.currentRank,
                                  ),
                                ),

                                const SizedBox(height: 40),

                                // Statistics Cards
                                Row(
                                  children: [
                                    Expanded(
                                      child: StatisticCardWidget(
                                        icon: Icons.star,
                                        iconColor: Colors.amber,
                                        value: achievement.totalScore,
                                        label: 'Total Score',
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: StatisticCardWidget(
                                        icon: Icons.edit,
                                        iconColor: Colors.deepOrange,
                                        value: achievement.dailyStreak,
                                        label: 'Daily Streak',
                                      ),
                                    ),
                                  ],
                                ),
                              ].animate(interval: 50.ms).fade(duration: 400.ms, curve: Curves.easeOutCubic).slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _getRankAsset(String currentRank) {
    switch (currentRank.toLowerCase()) {
      case 'bronze': return 'assets/images/bronze.png';
      case 'silver': return 'assets/images/silver.png';
      case 'gold': return 'assets/images/gold.png';
      case 'platinum': return 'assets/images/platinum.png';
      case 'diamond': return 'assets/images/dimond.png';
      case 'master': return 'assets/images/master.png';
      case 'grand master': return 'assets/images/grand_master.png';
      case 'elite': return 'assets/images/elite.png';
      case 'champion': return 'assets/images/champion.png';
      case 'legend': return 'assets/images/legend.png';
      default: return 'assets/images/bronze.png'; // default fallback
    }
  }

  List<Widget> _buildRankBadges(
    int currentLevel,
    String currentRank,
  ) {
    final List<Map<String, dynamic>> ranks = [
      {'name': 'Bronze', 'level': 5, 'asset': 'assets/images/bronze.png'},
      {'name': 'Silver', 'level': 10, 'asset': 'assets/images/silver.png'},
      {'name': 'Gold', 'level': 20, 'asset': 'assets/images/gold.png'},
      {'name': 'Platinum', 'level': 30, 'asset': 'assets/images/platinum.png'},
      {'name': 'Diamond', 'level': 40, 'asset': 'assets/images/dimond.png'},
      {'name': 'Master', 'level': 50, 'asset': 'assets/images/master.png'},
      {'name': 'Grand Master', 'level': 60, 'asset': 'assets/images/grand_master.png'},
      {'name': 'Elite', 'level': 70, 'asset': 'assets/images/elite.png'},
      {'name': 'Champion', 'level': 80, 'asset': 'assets/images/champion.png'},
      {'name': 'Legend', 'level': 100, 'asset': 'assets/images/legend.png'},
    ];

    return ranks.map((rank) {
      final isUnlocked = currentLevel >= rank['level'];
      final isCurrent = currentRank == rank['name'];

      return RankBadgeWidget(
        rankName: rank['name'] as String,
        assetPath: rank['asset'] as String,
        requiredLevel: rank['level'] as int,
        isUnlocked: isUnlocked,
        isCurrentRank: isCurrent,
      );
    }).toList();
  }
}
