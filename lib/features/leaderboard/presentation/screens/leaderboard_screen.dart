import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/leaderboard_filter.dart';
import '../providers/leaderboard_provider.dart';
import '../widgets/leaderboard_podium.dart';
import '../widgets/leaderboard_list_item.dart';
import '../widgets/user_rank_details_popup.dart';

class LeaderboardScreen extends ConsumerWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderboardState = ref.watch(leaderboardDataProvider);
    final filter = ref.watch(leaderboardFilterProvider);

    return Container(
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
      child: Column(
        children: [
          // Header
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  // Circular back button
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withValues(alpha: 0.15),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                      onPressed: () {
                        // Assuming GoRouter pop or equivalent
                        Navigator.of(context).maybePop();
                      },
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
                  const SizedBox(width: 48), // To balance the back button
                ],
              ),
            ),
          ),

          // Main Content
          Expanded(
            child: leaderboardState.when(
              loading: () => const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
              error: (err, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: $err', style: const TextStyle(color: Colors.white)),
                    ElevatedButton(
                      onPressed: () => ref.refresh(leaderboardDataProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
              data: (users) {
                if (users.isEmpty) return const SizedBox.shrink();

                final top3 = users.where((u) => u.rank <= 3).toList();
                final rest = users.where((u) => u.rank > 3).toList()..sort((a, b) => a.rank.compareTo(b.rank));
                
                // Find current user row for pinning at bottom
                final currentUser = users.firstWhere(
                  (u) => u.isCurrentUser, 
                  orElse: () => users.first,
                );

                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // The Podium placed BEHIND the white container
                    Positioned(
                      top: 10,
                      left: 0,
                      right: 0,
                      child: LeaderboardPodium(topUsers: top3),
                    ),

                    // The White Container for the List
                    Positioned.fill(
                      top: 210, // Overlaps bottom of podium pillars
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 24),
                            _buildFilterSection(ref, filter),
                            const SizedBox(height: 12),
                            // List View
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.only(bottom: 100), // Space for pinned row
                                itemCount: rest.length,
                                itemBuilder: (context, index) {
                                  final user = rest[index];
                                  return LeaderboardListItem(
                                    user: user,
                                    onTap: () => UserRankDetailsPopup.show(context, user),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Pinned Current User Row
                    Positioned(
                      bottom: 8,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.grey.shade50,
                              Colors.grey.shade50.withValues(alpha: 0.9),
                              Colors.grey.shade50.withValues(alpha: 0.0),
                            ],
                            stops: const [0.0, 0.7, 1.0],
                          ),
                        ),
                        padding: const EdgeInsets.only(top: 24),
                        child: LeaderboardListItem(
                          user: currentUser,
                          isPinnedBottom: true,
                          onTap: () => UserRankDetailsPopup.show(context, currentUser),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(WidgetRef ref, LeaderboardFilter currentFilter) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDropdownFilter('Language', Icons.keyboard_arrow_down),
          _buildDropdownFilter('English', Icons.keyboard_arrow_down),
          _buildDropdownFilter(
            currentFilter.timeframe.name.substring(0, 1).toUpperCase() + currentFilter.timeframe.name.substring(1),
            Icons.keyboard_arrow_down,
            onTap: () {
              // Cycle timeframe for demo purposes
              final next = currentFilter.timeframe == TimeframeFilter.daily
                  ? TimeframeFilter.weekly
                  : (currentFilter.timeframe == TimeframeFilter.weekly ? TimeframeFilter.monthly : TimeframeFilter.daily);
              ref.read(leaderboardFilterProvider.notifier).state = currentFilter.copyWith(timeframe: next);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownFilter(String label, IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 4),
            Icon(icon, color: Colors.black54, size: 18),
          ],
        ),
      ),
    );
  }
}
