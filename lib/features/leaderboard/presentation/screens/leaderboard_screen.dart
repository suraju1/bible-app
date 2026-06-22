import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/leaderboard_filter.dart';
import '../providers/leaderboard_provider.dart';
import '../widgets/leaderboard_podium.dart';
import '../widgets/user_rank_details_popup.dart';
import '../widgets/leaderboard_skeleton.dart';
import '../widgets/filter_chip_dropdown.dart';
import '../widgets/user_rank_tile.dart';
import '../widgets/current_user_card.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LeaderboardScreen extends ConsumerWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderboardState = ref.watch(leaderboardDataProvider);
    final filter = ref.watch(leaderboardFilterProvider);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Gradient.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          // Header
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: const Center(
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
            ),
          ),

          // Main Content
          Expanded(
            child: leaderboardState.when(
              loading: () => const LeaderboardSkeleton(),
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
                      top: 54,
                      left: 0,
                      right: 0,
                      child: LeaderboardPodium(topUsers: top3).animate().fade(duration: 500.ms).slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutBack),
                    ),

                    // The White Container for the List
                    Positioned.fill(
                      top: 254, // Overlaps bottom of podium pillars
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 24),
                            const _SegmentedControl(),
                            const SizedBox(height: 16),
                            _buildFilterSection(ref, filter),
                            const SizedBox(height: 16),
                            // List View
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.only(bottom: 120), // Space for pinned row
                                itemCount: rest.length,
                                itemBuilder: (context, index) {
                                  final user = rest[index];
                                  return UserRankTile(
                                    user: user,
                                    onTap: () => UserRankDetailsPopup.show(context, user),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ).animate(delay: 200.ms).fade(duration: 400.ms).slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic),
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
                        child: CurrentUserCard(
                          user: currentUser,
                          onTap: () => UserRankDetailsPopup.show(context, currentUser),
                        ),
                      ).animate(delay: 400.ms).fade(duration: 400.ms).slideY(begin: 0.2, end: 0.0, curve: Curves.easeOutCubic),
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
          const FilterChipDropdown(label: 'Language'),
          const FilterChipDropdown(label: 'English'),
          FilterChipDropdown(
            label: currentFilter.timeframe.name.substring(0, 1).toUpperCase() + currentFilter.timeframe.name.substring(1),
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
}

class _SegmentedControl extends StatefulWidget {
  const _SegmentedControl({Key? key}) : super(key: key);

  @override
  _SegmentedControlState createState() => _SegmentedControlState();
}

class _SegmentedControlState extends State<_SegmentedControl> {
  int _selectedIndex = 0; // 0 for Sponsor, 1 for Rewards

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.grey.shade100, // Light gray background
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedIndex = 0),
                child: _buildSegment('Sponsor', _selectedIndex == 0),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedIndex = 1),
                child: _buildSegment('Rewards', _selectedIndex == 1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegment(String title, bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : [],
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.black87 : Colors.grey.shade600,
          fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }
}
