import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../leaderboard/domain/entities/leaderboard_user.dart';
import '../../../leaderboard/presentation/widgets/leaderboard_podium.dart';
import '../../../leaderboard/presentation/widgets/user_rank_tile.dart';
import '../../../leaderboard/presentation/widgets/current_user_card.dart';
import '../providers/challenge_group_provider.dart';

class GroupLeaderboardScreen extends ConsumerWidget {
  final String groupId;

  const GroupLeaderboardScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupAsyncValue = ref.watch(groupDetailsProvider(groupId));

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8BB5F5), // Light sky blue
              Color(0xFF3A3B8B), // Deep purple/blue
            ],
          ),
        ),
        child: groupAsyncValue.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
          error: (err, stack) => Center(
            child: Text(
              'Error: $err',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          data: (group) {
            // Map group members to LeaderboardUser for podium compatibility
            // Adding dummy top 3 since the mock data only has 4 users with score 10
            final top3 = [
              LeaderboardUser(
                id: 'u1',
                name: 'Caroline',
                avatarUrl:
                    'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=100&q=80',
                rank: 1,
                score: 150,
                level: 1,
              ),
              LeaderboardUser(
                id: 'u2',
                name: 'Caroline',
                avatarUrl:
                    'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=100&q=80',
                rank: 2,
                score: 140,
                level: 1,
              ),
              LeaderboardUser(
                id: 'u3',
                name: 'Caroline',
                avatarUrl:
                    'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=100&q=80',
                rank: 3,
                score: 130,
                level: 1,
              ),
            ];

            final restUsers = group.members
                .map(
                  (m) => LeaderboardUser(
                    id: m.id,
                    name: m.name,
                    avatarUrl:
                        m.avatarUrl ??
                        'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=100&q=80',
                    rank: m.rank + 3, // offsetting rank for mock
                    score: 120 - (m.rank * 10), // mock descending scores
                    level: 1,
                    isCurrentUser: m.name == 'You',
                  ),
                )
                .toList();

            final currentUser = restUsers.firstWhere(
              (u) => u.isCurrentUser,
              orElse: () => restUsers.first,
            );

            return Column(
              children: [
                // Header
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.15),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () => context.pop(),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'Leader Board',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 48), // Spacer
                      ],
                    ),
                  ),
                ),

                // Main Content
                Expanded(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Podium
                      Positioned(
                        top: 40,
                        left: 0,
                        right: 0,
                        child: LeaderboardPodium(topUsers: top3),
                      ),

                      // White Container
                      Positioned.fill(
                        top: 240,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(32),
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 24),

                              // Sponsor / Rewards Tabs
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                ),
                                child: Row(
                                  children: [
                                    _buildTabButton('Sponsor', true),
                                    const SizedBox(width: 16),
                                    _buildTabButton('Rewards', false),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Filters (Language, English, Daily)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildFilterDropdown('Language'),
                                    _buildFilterDropdown('English'),
                                    _buildFilterDropdown('Daily'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),

                              // List View
                              Expanded(
                                child: ListView.builder(
                                  padding: const EdgeInsets.only(bottom: 100),
                                  itemCount: restUsers.length,
                                  itemBuilder: (context, index) {
                                    return UserRankTile(
                                      user: restUsers[index],
                                      onTap: () {},
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Pinned Current User
                      Positioned(
                        bottom: 8,
                        left: 16,
                        right: 16,
                        child: SafeArea(
                          top: false,
                          child: CurrentUserCard(
                            user: currentUser,
                            onTap: () {},
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
      ),
    );
  }

  Widget _buildTabButton(String title, bool isSelected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade300,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? const Color(0xFF2C3E50) : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterDropdown(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
