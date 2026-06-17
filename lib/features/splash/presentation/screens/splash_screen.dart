import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../providers/splash_provider.dart';

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
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF5A84C3), // Lighter blue from the top of the Figma image
              Color(0xFF383688), // Darker purplish-blue from the bottom
            ],
          ),
        ),
        child: Center(
          child: Image.asset(
            AppAssets.logo,
            width: 250, // Adjust width based on visual preference
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
