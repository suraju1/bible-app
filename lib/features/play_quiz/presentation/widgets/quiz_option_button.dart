import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

enum OptionState { normal, selectedCorrect, selectedIncorrect, unselectedCorrect }

class QuizOptionButton extends StatelessWidget {
  final String letter;
  final String text;
  final OptionState state;
  final VoidCallback onTap;

  const QuizOptionButton({
    super.key,
    required this.letter,
    required this.text,
    this.state = OptionState.normal,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.transparent;
    Color letterBgColor = Colors.white;
    Color letterTextColor = AppColors.primary;

    if (state == OptionState.selectedCorrect || state == OptionState.unselectedCorrect) {
      borderColor = Colors.greenAccent;
      letterTextColor = Colors.greenAccent;
    } else if (state == OptionState.selectedIncorrect) {
      borderColor = Colors.redAccent;
      letterTextColor = Colors.redAccent;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: letterBgColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  letter,
                  style: TextStyle(
                    color: letterTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
