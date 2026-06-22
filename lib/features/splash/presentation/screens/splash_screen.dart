import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../providers/splash_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to the splash provider to navigate once data is fetched
    ref.listen(splashProvider, (previous, next) {
      if (next is AsyncData) {
        final status = next.requireValue;
        if (!status.hasSelectedLanguage) {
          context.go('/language-selection');
        } else if (!status.hasSelectedExpertise) {
          context.go('/expertise-selection');
        } else if (!status.isLoggedIn) {
          context.go('/auth-selection');
        } else {
          context.go('/home');
        }
      }
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_screen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Image.asset(
            AppAssets.logo,
            width: 250, // Adjust width based on visual preference
            fit: BoxFit.contain,
          ).animate().fade(duration: 800.ms, curve: Curves.easeIn).scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutBack, duration: 800.ms),
        ),
      ),
    );
  }
}
