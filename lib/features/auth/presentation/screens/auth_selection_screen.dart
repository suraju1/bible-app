import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../providers/auth_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AuthSelectionScreen extends ConsumerWidget {
  const AuthSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guestState = ref.watch(guestLoginControllerProvider);

    ref.listen(guestLoginControllerProvider, (previous, next) {
      if (next is AsyncData && previous is AsyncLoading) {
        context.go('/home');
      } else if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error.toString())),
        );
      }
    });

    return Scaffold(
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 60.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  AppAssets.logo,
                  height: 250,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 60),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF5A84C3), Color(0xFF383688)],
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () => context.push('/login'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: const Text('Login', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF5A84C3), Color(0xFF383688)],
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: guestState.isLoading
                            ? null
                            : () {
                                ref.read(guestLoginControllerProvider.notifier).guestLogin();
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: guestState.isLoading
                            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                            : const Text('Continue as Guest', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ].animate(interval: 100.ms).fade(duration: 500.ms, curve: Curves.easeOutCubic).slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic),
            ),
          ),
        ),
      ),
    );
  }
}
