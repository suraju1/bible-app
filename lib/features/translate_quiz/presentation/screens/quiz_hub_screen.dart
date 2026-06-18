import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';

class QuizHubScreen extends StatelessWidget {
  const QuizHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildGradientButton(
                title: 'Play Quiz',
                onTap: () {},
              ),
              const SizedBox(height: 16),
              _buildGradientButton(
                title: 'Create Quiz',
                onTap: () {},
              ),
              const SizedBox(height: 16),
              _buildGradientButton(
                title: 'Translate Quiz',
                onTap: () {
                  context.push('/translate-quiz-list');
                },
              ),
              const SizedBox(height: 16),
              _buildGradientButton(
                title: 'Correction Quiz',
                onTap: () {
                  context.push('/correction-quiz-list');
                },
              ),
              const SizedBox(height: 120), // Spacing for bottom nav
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton({required String title, required VoidCallback onTap}) {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A72B2).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(32),
          onTap: onTap,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
