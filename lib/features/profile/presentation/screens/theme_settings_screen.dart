import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/theme_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ThemeSettingsScreen extends ConsumerWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: Colors.white,
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
                            'App Theme',
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Themes',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Top Row: Small Themes (Future support)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildSmallThemeCard(
                                  colors: [
                                    const Color(0xFF5A7BFF),
                                    const Color(0xFF2E5B9F),
                                  ],
                                  isSelected: true,
                                ),
                                _buildSmallThemeCard(
                                  colors: [
                                    const Color(0xFFD8B4E2),
                                    const Color(0xFFA78BFA),
                                  ],
                                  isSelected: false,
                                ),
                                _buildSmallThemeCard(
                                  colors: [
                                    const Color(0xFFF9A8D4),
                                    const Color(0xFFFDBA74),
                                  ],
                                  isSelected: false,
                                ),
                              ],
                            ),

                            const SizedBox(height: 40),

                            // Bottom Row: Light/Dark Modes
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildLargeModeCard(
                                  title: 'Light Mode',
                                  topColors: [
                                    const Color(0xFF5A7BFF),
                                    const Color(0xFF2E5B9F),
                                  ],
                                  bottomColor: Colors.white,
                                  isSelected:
                                      themeMode == ThemeMode.light ||
                                      themeMode ==
                                          ThemeMode
                                              .system, // Defaulting system to light for UI
                                  onTap: () {
                                    ref
                                        .read(themeProvider.notifier)
                                        .setThemeMode(ThemeMode.light);
                                  },
                                ),
                                const SizedBox(width: 16),
                                _buildLargeModeCard(
                                  title: 'Dark Mode',
                                  topColors: [
                                    const Color(0xFF5A7BFF),
                                    const Color(0xFF2E5B9F),
                                  ],
                                  bottomColor: const Color(0xFF333333),
                                  isSelected: themeMode == ThemeMode.dark,
                                  onTap: () {
                                    ref
                                        .read(themeProvider.notifier)
                                        .setThemeMode(ThemeMode.dark);
                                  },
                                ),
                              ],
                            ),
                          ].animate(interval: 50.ms).fade(duration: 400.ms, curve: Curves.easeOutCubic).slideY(begin: 0.05, end: 0.0, curve: Curves.easeOutCubic),
                        ),
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

  Widget _buildSmallThemeCard({
    required List<Color> colors,
    required bool isSelected,
  }) {
    return Column(
      children: [
        Container(
          width: 90,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF5A7BFF)
                  : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFF5A7BFF).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(14),
                    ),
                    gradient: LinearGradient(
                      colors: colors,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(14),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 8,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: colors,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF5A7BFF)
                  : Colors.grey.shade300,
              width: isSelected ? 4 : 1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLargeModeCard({
    required String title,
    required List<Color> topColors,
    required Color bottomColor,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF5A7BFF)
                      : Colors.grey.shade400,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFF5A7BFF).withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ]
                    : [],
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(18),
                        ),
                        gradient: LinearGradient(
                          colors: topColors,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: bottomColor,
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(18),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Container(
                            width: 60,
                            height: 12,
                            decoration: BoxDecoration(
                              color: const Color(0xFF5A7BFF),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF5A7BFF)
                      : Colors.grey.shade300,
                  width: isSelected ? 4 : 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
