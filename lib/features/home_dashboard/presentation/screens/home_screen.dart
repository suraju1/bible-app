import 'package:bible_quiz_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/secure_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/metrics_card.dart';
import '../widgets/challenge_card.dart';
import '../widgets/category_card.dart';
import '../../../leaderboard/presentation/screens/leaderboard_screen.dart';
import '../../../challenge_group/presentation/screens/battles_screen.dart';
import '../../../translate_quiz/presentation/screens/quiz_hub_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentTab = 0; // 0: Home, 1: Challenge, 2: Quiz, 3: Rank, 4: Profile

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: _buildBody(),
      // Custom Floating Action Button in the center (Quiz Tab)
      floatingActionButton: Container(
        width: 68,
        height: 68,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.primaryGradient,
          boxShadow: [
            BoxShadow(
              color: AppColors.vibrantIndigo.withValues(alpha: 0.5),
              blurRadius: 16, // Increased blur for larger shadow
              spreadRadius: 4, // Increased spread
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: RawMaterialButton(
          shape: const CircleBorder(),
          onPressed: () {
            setState(() {
              _currentTab = 2; // Set tab to Quiz
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/star.png',
                width: 26,
                height: 26,
                color: Colors
                    .white, // Ensure it's white if it's an outline or solid shape
              ),
              const SizedBox(height: 2),
              const Text(
                'Quiz',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.white,
        elevation: 16,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left Tabs (Home, Challenge)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTabItem(
                      index: 0,
                      assetPath: 'assets/icons/home_nav_bar.png',
                      label: 'Home',
                    ),
                    _buildTabItem(
                      index: 1,
                      assetPath: 'assets/icons/challenges_nav_bar.png',
                      label: 'Challenge',
                    ),
                  ],
                ),
              ),
              // Space for the notched FAB
              const SizedBox(width: 80),
              // Right Tabs (Rank, Profile)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTabItem(
                      index: 3,
                      assetPath: 'assets/icons/rank_nav_bar.png',
                      label: 'Rank',
                    ),
                    _buildTabItem(
                      index: 4,
                      assetPath: 'assets/icons/profile_nav_bar.png',
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentTab) {
      case 0:
        return const _DashboardTabView();
      case 1:
        return const BattlesScreen();
      case 2:
        return const QuizHubScreen();
      case 3:
        return const LeaderboardScreen();
      case 4:
        return const ProfileScreen();
      default:
        return const _DashboardTabView();
    }
  }

  Widget _buildTabItem({
    required int index,
    required String assetPath,
    required String label,
  }) {
    final isActive = _currentTab == index;
    final color = isActive ? const Color(0xFF2D2BA7) : Colors.grey.shade400;

    return InkWell(
      onTap: () {
        setState(() {
          _currentTab = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            assetPath,
            width: 24,
            height: 24,
            color: color,
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

/// The main Home Dashboard View (Caroline Hugo profile + challenge + categories)
class _DashboardTabView extends ConsumerStatefulWidget {
  const _DashboardTabView();

  @override
  ConsumerState<_DashboardTabView> createState() => _DashboardTabViewState();
}

class _DashboardTabViewState extends ConsumerState<_DashboardTabView> {
  int _currentCarouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardDataProvider);

    return dashboardState.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: Color(0xFF01369F)),
      ),
      error: (err, stack) => Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error loading dashboard: $err',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => ref.refresh(dashboardDataProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      data: (data) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Stack containing Profile and Metrics Card
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // Gradient Banner with Figma-matching bottom curve
                  ClipPath(
                    clipper: const BannerClipper(),
                    child: Container(
                      width: double.infinity,
                      height: 225,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/Gradient.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 24.0,
                            right: 24.0,
                            top: 4.0,
                            bottom: 12.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Profile Avatar and Text Info
                              Row(
                                children: [
                                  // Avatar circle with border
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.1,
                                          ),
                                          blurRadius: 6,
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      radius: 26,
                                      backgroundImage:
                                          data.userAvatarUrl != null
                                          ? NetworkImage(data.userAvatarUrl!)
                                          : null,
                                      backgroundColor: Colors.blue.shade100,
                                      child: data.userAvatarUrl == null
                                          ? const Icon(
                                              Icons.person,
                                              color: Colors.white,
                                            )
                                          : null,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  // Text info
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        data.userName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        "Let's Play Quiz",
                                        style: TextStyle(
                                          color: Colors.white.withValues(
                                            alpha: 0.8,
                                          ),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // Notification Icon with Badge
                              Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withValues(
                                        alpha: 0.15,
                                      ),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.notifications_none_outlined,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        context.push('/notifications');
                                      },
                                    ),
                                  ),
                                  if (data.notificationBadgeCount > 0)
                                    Positioned(
                                      right: 6,
                                      top: 6,
                                      child: Container(
                                        width: 10,
                                        height: 10,
                                        decoration: const BoxDecoration(
                                          color: Color(
                                            0xFFE74C3C,
                                          ), // Red badge color
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Positioned MetricsCard overlaying the banner bottom
                  Positioned(
                    bottom: -36,
                    left: 20,
                    right: 20,
                    child: MetricsCard(
                      dailyStreak: data.dailyStreak,
                      rank: data.rank,
                      level: data.level,
                      levelProgress: data.levelProgress,
                      points: data.points,
                    ),
                  ),
                ],
              ),

              // Spacer for the MetricsCard overlay
              const SizedBox(height: 64),

              // Today's Challenge Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: const Text(
                  "Today's Challenge",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              CarouselSlider(
                options: CarouselOptions(
                  height: 225,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  viewportFraction: 0.85,
                  autoPlayInterval: const Duration(seconds: 4),
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentCarouselIndex = index;
                    });
                  },
                ),
                items: [
                  _buildImageBanner('assets/images/1_learn_daily_banner.png'),
                  _buildImageBanner('assets/images/focous_today_achive_tommarow-removebg-preview.png'),
                  _buildImageBanner('assets/images/test_your_knowledge_banner-removebg-preview.png'),
                  _buildImageBanner('assets/images/2_stay.png'),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => Container(
                    width: _currentCarouselIndex == index ? 24.0 : 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: _currentCarouselIndex == index
                          ? const Color(0xFF01369F)
                          : Colors.grey.shade300,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Quiz Categories Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Quiz Categories",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF2C3E50),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.push('/quiz-categories');
                          },
                          child: const Text(
                            "View All",
                            style: TextStyle(
                              color: Color(0xFF01369F),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Horizontal Category cards row
                    Row(
                      children: [
                        for (int i = 0; i < data.categories.length; i++) ...[
                          if (i > 0) const SizedBox(width: 16),
                          Expanded(
                            child: CategoryCard(
                              title: data.categories[i].title,
                              iconType: data.categories[i].iconType,
                              onTap: () {
                                // Category tap action
                              },
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              // Final bottom padding for center FAB clearance
              const SizedBox(height: 140),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageBanner(String imagePath) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF01369F).withValues(alpha: 0.15),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

/// A simple screen placeholder to show when other navigation items are tapped
class _PlaceholderScreen extends StatelessWidget {
  final String title;

  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.dashboard_customize_outlined,
            size: 64,
            color: Colors.blue.shade200,
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'This screen will be completed in the next modules.',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _ProfileTabView extends ConsumerWidget {
  const _ProfileTabView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=150&q=80',
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Caroline Hugo',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
          const Text(
            'caroline.hugo@example.com',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();

              final secureStorage = ref.read(secureStorageProvider);
              await secureStorage.deleteToken();

              if (context.mounted) {
                context.go('/splash');
              }
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout & Reset App'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BannerClipper extends CustomClipper<Path> {
  const BannerClipper();

  @override
  Path getClip(Size size) {
    final double w = size.width;
    final double h = size.height;
    const double r = 32.0; // Curve radius

    final path = Path()
      ..lineTo(0, h)
      ..quadraticBezierTo(0, h - r, r, h - r)
      ..lineTo(w - r, h - r)
      ..quadraticBezierTo(w, h - r, w, h)
      ..lineTo(w, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
