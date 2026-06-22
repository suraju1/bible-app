import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';

class QuizModeSelectionScreen extends StatelessWidget {
  const QuizModeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400, // Matches the grey background in Figma
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Start quiz', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Select Language',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: 'English',
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: ['English', 'Spanish', 'French'].map((lang) {
                      return DropdownMenuItem(value: lang, child: Text(lang));
                    }).toList(),
                    onChanged: (val) {},
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildModeButton(
                context,
                title: 'Single Mode',
                subtitle: '(Test your personal Bible knowledge)',
                onTap: () {
                  context.push('/quiz-type-selection');
                },
                isGradient: true,
              ),
              const SizedBox(height: 16),
              _buildModeButton(
                context,
                title: 'Group Mode',
                subtitle: '(Learn and share your Bible knowledge with others)',
                onTap: () {
                  // Navigate to group mode
                },
                isGradient: false,
              ),
            ].animate(interval: 50.ms).fade(duration: 400.ms, curve: Curves.easeOutCubic).slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic),
          ),
        ),
      ),
    );
  }

  Widget _buildModeButton(BuildContext context, {required String title, required String subtitle, required VoidCallback onTap, required bool isGradient}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              gradient: isGradient ? AppColors.primaryGradient : null,
              color: isGradient ? null : Colors.white,
              border: isGradient ? null : Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(30),
              boxShadow: isGradient ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ] : null,
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: isGradient ? Colors.white : AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
      ],
    );
  }
}
