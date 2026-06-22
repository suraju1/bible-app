import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../providers/challenge_group_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BattlesScreen extends ConsumerStatefulWidget {
  const BattlesScreen({super.key});

  @override
  ConsumerState<BattlesScreen> createState() => _BattlesScreenState();
}

class _BattlesScreenState extends ConsumerState<BattlesScreen> {
  int _selectedTabIndex = 1; // 0: All, 1: Joined, 2: +Group

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Container(
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
                    'Battles',
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

            const SizedBox(height: 16),

            // Main Content Container
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    // Custom Tabs
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        children: [
                          _buildTabItem(title: 'All', index: 0),
                          _buildTabItem(title: 'Joined', index: 1),
                          _buildTabItem(title: '+Group', index: 2),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Tab Content
                    if (_selectedTabIndex == 0)
                      Expanded(child: _buildAllTabContent(context)),
                    
                    if (_selectedTabIndex == 1)
                      Expanded(child: _buildJoinedTabContent(ref)),
                      
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({required String title, required int index}) {
    final isSelected = _selectedTabIndex == index;
    
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (index == 2) {
            context.push('/create-group');
          } else {
            setState(() {
              _selectedTabIndex = index;
            });
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: isSelected ? null : Colors.white,
            gradient: isSelected ? AppColors.primaryGradient : null,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected ? Colors.transparent : Colors.grey.shade300,
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey.shade600,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJoinedTabContent(WidgetRef ref) {
    final state = ref.watch(joinedGroupsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              const Text(
                'Your joined groups',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C3E50),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Divider(color: Colors.grey.shade300, thickness: 1),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        
        Expanded(
          child: state.groups.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
            data: (groups) {
              if (groups.isEmpty) {
                return const SizedBox.shrink(); // Empty state shown in Figma
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  final group = groups[index];
                  return GestureDetector(
                    onTap: () => context.push('/group-action/${group.id}'),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12.0),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F0FE),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.people_outline, color: AppColors.primary, size: 24),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              group.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C3E50),
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ].animate(interval: 50.ms).fade(duration: 400.ms, curve: Curves.easeOutCubic).slideX(begin: 0.05, end: 0.0, curve: Curves.easeOutCubic),
    );
  }

  Widget _buildAllTabContent(BuildContext context) {
    // Dummy data for trending and all groups
    final trendingGroups = [
      {'name': 'Global Bible Trivia', 'participants': 1250},
      {'name': 'Sunday Special Battle', 'participants': 890},
      {'name': 'New Testament Challenge', 'participants': 650},
    ];

    final allGroups = [
      {'name': 'Daily Genesis Quiz', 'participants': 420},
      {'name': 'Proverbs Masters', 'participants': 310},
      {'name': 'Youth Ministry Quiz', 'participants': 150},
      {'name': 'Bible Scholars Group', 'participants': 85},
      {'name': 'Morning Devotion Battle', 'participants': 50},
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Trending Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                const Icon(Icons.local_fire_department, color: Colors.orange, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Trending Groups',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 150,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              scrollDirection: Axis.horizontal,
              itemCount: trendingGroups.length,
              itemBuilder: (context, index) {
                final group = trendingGroups[index];
                return Container(
                  width: 260,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: _buildPublicGroupCard(
                    context: context,
                    name: group['name'] as String,
                    participants: group['participants'] as int,
                    isTrending: true,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          // All Groups Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: const Text(
              'All Groups',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
            ),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: allGroups.length,
            itemBuilder: (context, index) {
              final group = allGroups[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _buildPublicGroupCard(
                  context: context,
                  name: group['name'] as String,
                  participants: group['participants'] as int,
                  isTrending: false,
                ),
              );
            },
          ),
          const SizedBox(height: 100), // Bottom padding for nav bar
        ].animate(interval: 60.ms).fade(duration: 400.ms, curve: Curves.easeOutCubic).slideY(begin: 0.05, end: 0.0, curve: Curves.easeOutCubic),
      ),
    );
  }

  Widget _buildPublicGroupCard({
    required BuildContext context,
    required String name,
    required int participants,
    required bool isTrending,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isTrending ? Colors.orange.shade50 : const Color(0xFFE8F0FE),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isTrending ? Icons.whatshot : Icons.public,
                  color: isTrending ? Colors.orange : AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '👤 $participants Joined',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Successfully joined $name!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 0,
                ),
                child: const Text('Join', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
