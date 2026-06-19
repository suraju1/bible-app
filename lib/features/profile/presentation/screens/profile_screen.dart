import 'package:flutter/material.dart';
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
                            child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16),
                          ),
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Profile',
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
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
                              icon: Icons.person_outline,
                              title: 'My Profile',
                              onTap: () => context.push('/profile/my-profile'),
                            ),
                            ProfileMenuItem(
                              icon: Icons.emoji_events_outlined,
                              title: 'Achievements',
                              onTap: () => context.push('/profile/achievements'),
                            ),
                            ProfileMenuItem(
                              icon: Icons.card_giftcard,
                              title: 'Rewards',
                              onTap: () => context.push('/profile/rewards'),
                            ),
                            ProfileMenuItem(
                              icon: Icons.history,
                              title: 'Quiz History',
                              onTap: () => context.push('/profile/history'),
                            ),
                            ProfileMenuItem(
                              icon: Icons.people_outline,
                              title: 'Refer & Get Points',
                              onTap: () => context.push('/profile/referral'),
                            ),
                            ProfileMenuItem(
                              icon: Icons.brightness_6_outlined,
                              title: 'App Theme',
                              onTap: () => context.push('/profile/theme'),
                            ),
                            ProfileMenuItem(
                              icon: Icons.notifications_none,
                              title: 'Notifications Settings',
                              onTap: () => context.push('/profile/notifications'),
                            ),
                            ProfileMenuItem(
                              icon: Icons.language,
                              title: 'Language Settings',
                              onTap: () => context.push('/profile/language'),
                            ),
                            ProfileMenuItem(
                              icon: Icons.help_outline,
                              title: 'Help & Support',
                              onTap: () => context.push('/profile/support'),
                            ),
                            ProfileMenuItem(
                              icon: Icons.verified_user_outlined,
                              title: 'Terms & Conditions',
                              onTap: () => context.push('/profile/terms'),
                            ),
                          ],
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
