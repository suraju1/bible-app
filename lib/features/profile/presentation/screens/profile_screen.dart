import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_menu_item.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (profile) => Stack(
          children: [
            // Background Gradient Header
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
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: const Center(
                      child: Text(
                        'Profile',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  
                  // User Info Section
                  const SizedBox(height: 16),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.orange.shade200,
                    child: CircleAvatar(
                      radius: 38,
                      backgroundImage: NetworkImage(profile.imageUrl),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    profile.name,
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  
                  // Progress Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              height: 12,
                              child: LinearProgressIndicator(
                                value: profile.completionPercentage / 100,
                                
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade900),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${profile.completionPercentage}%',
                          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Complete your profile details',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 24),
                  
                  // Menu Items Container
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
                        child: ListView(
                          padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0, bottom: 100.0), // bottom padding for nav bar
                          children: [
                            ProfileMenuItem(
                              iconPath: 'assets/icons/profile_screen_icons/my_profile.png',
                              title: 'My Profile',
                              onTap: () => context.push('/profile/my-profile'),
                            ),
                            ProfileMenuItem(
                              iconPath: 'assets/icons/profile_screen_icons/achievements.png',
                              title: 'Achievements',
                              onTap: () => context.push('/profile/achievements'),
                            ),
                            ProfileMenuItem(
                              iconPath: 'assets/icons/profile_screen_icons/rewards.png',
                              title: 'Rewards',
                              onTap: () => context.push('/profile/rewards'),
                            ),
                            ProfileMenuItem(
                              iconPath: 'assets/icons/profile_screen_icons/quiz_history.png',
                              title: 'Quiz History',
                              onTap: () => context.push('/profile/history'),
                            ),
                            ProfileMenuItem(
                              iconPath: 'assets/icons/profile_screen_icons/refer_and_earn.png',
                              title: 'Refer & Get Points',
                              onTap: () => context.push('/profile/referral'),
                            ),
                            ProfileMenuItem(
                              iconPath: 'assets/icons/profile_screen_icons/app_theme.png',
                              title: 'App Theme',
                              onTap: () => context.push('/profile/theme'),
                            ),
                            ProfileMenuItem(
                              iconPath: 'assets/icons/profile_screen_icons/notification.png',
                              title: 'Notifications Settings',
                              onTap: () => context.push('/profile/notifications'),
                            ),
                            ProfileMenuItem(
                              iconPath: 'assets/icons/profile_screen_icons/languages.png',
                              title: 'Language Settings',
                              onTap: () => context.push('/profile/language'),
                            ),
                            ProfileMenuItem(
                              iconPath: 'assets/icons/profile_screen_icons/help_and_support.png',
                              title: 'Help & Support',
                              onTap: () => context.push('/profile/support'),
                            ),
                            ProfileMenuItem(
                              iconPath: 'assets/icons/profile_screen_icons/terms_and_conditions.png',
                              title: 'Terms & Conditions',
                              onTap: () => context.push('/profile/terms'),
                            ),
                          ].animate(interval: 50.ms).fade(duration: 400.ms, curve: Curves.easeOutCubic).slideX(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
