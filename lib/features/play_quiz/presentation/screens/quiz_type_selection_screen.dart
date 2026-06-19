import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';

class QuizTypeSelectionScreen extends StatelessWidget {
  const QuizTypeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text('Start quiz', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTypeButton(context, title: 'Correction Quiz', coins: '5+', onTap: () {}),
              const SizedBox(height: 24),
              _buildTypeButton(context, title: 'Create Quiz', coins: '5+', onTap: () {}),
              const SizedBox(height: 24),
              _buildTypeButton(context, title: 'Translate Quiz', coins: '5+', onTap: () {}),
              const SizedBox(height: 24),
              _buildTypeButton(context, title: 'Play Quiz', coins: '2+', onTap: () {
                context.push('/play-quiz');
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeButton(BuildContext context, {required String title, required String coins, required VoidCallback onTap}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.monetization_on, color: Colors.amber, size: 16),
            const SizedBox(width: 4),
            Text(
              coins,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ],
        ),
      ],
    );
  }
}
