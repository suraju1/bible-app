import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class ReferenceModal extends StatelessWidget {
  final String bookName;
  final String chapter;
  final String topic;
  final String explanation;
  final String correctAnswer;

  const ReferenceModal({
    super.key,
    required this.bookName,
    required this.chapter,
    required this.topic,
    required this.explanation,
    required this.correctAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.menu_book, color: Colors.amber, size: 16),
                      const SizedBox(width: 8),
                      const Text(
                        'Reference',
                        style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('Book Name: $bookName', style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text('Chapter: $chapter', style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text('Topic: $topic', style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            const Text('Question Explanation:', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(
              explanation,
              style: TextStyle(color: Colors.grey.shade700, height: 1.4),
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                text: 'Correct Answer: ',
                style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: correctAnswer,
                    style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.normal),
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
