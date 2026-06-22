import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/notification_settings_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(notificationSettingsProvider);

    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background Header
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
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
                            'Notifications Settings',
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 32), // Balance the back button
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Main Content Container
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      child: settingsAsync.when(
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (err, stack) => Center(child: Text('Error: $err')),
                        data: (settings) {
                          return SingleChildScrollView(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              children: [
                                _buildSettingCard(
                                  context: context,
                                  icon: Icons.notifications_none_rounded,
                                  title: 'Notifications',
                                  value: settings.notificationsEnabled,
                                  onChanged: (val) {
                                    ref.read(notificationSettingsProvider.notifier).toggleNotifications(val);
                                  },
                                ),
                                const SizedBox(height: 16),
                                _buildSettingCard(
                                  context: context,
                                  icon: Icons.notifications_active_outlined,
                                  title: 'Notifications Sound',
                                  value: settings.soundEnabled,
                                  enabled: settings.notificationsEnabled,
                                  onChanged: (val) {
                                    ref.read(notificationSettingsProvider.notifier).toggleSound(val);
                                  },
                                ),
                              ].animate(interval: 50.ms).fade(duration: 400.ms, curve: Curves.easeOutCubic).slideY(begin: 0.05, end: 0.0, curve: Curves.easeOutCubic),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool enabled = true,
  }) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFD6E4FF),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: const Color(0xFF1E3A8A),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
            CupertinoSwitch(
              value: value,
              onChanged: enabled ? onChanged : null,
              activeColor: const Color(0xFF1E3A8A),
            ),
          ],
        ),
      ),
    );
  }
}
