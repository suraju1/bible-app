import 'package:flutter/material.dart';

class UserFeedbackCard extends StatelessWidget {
  final String userName;
  final String userAvatarUrl;
  final String questionText;
  final String commentText;

  const UserFeedbackCard({
    super.key,
    required this.userName,
    required this.userAvatarUrl,
    required this.questionText,
    required this.commentText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'User Feedback',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(userAvatarUrl),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Question',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0FE), // Light blue background
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  questionText,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'User comment',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0FE), // Light blue background
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  commentText,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
