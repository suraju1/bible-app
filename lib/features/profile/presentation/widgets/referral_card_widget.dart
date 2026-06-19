import 'package:flutter/material.dart';
import '../../domain/models/referral_model.dart';

class ReferralCardWidget extends StatelessWidget {
  final ReferralItem item;

  const ReferralCardWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isPending = item.status == 'pending';
    final badgeColor = isPending ? const Color(0xFFF97316) : const Color(0xFF22C55E); // Orange or Green
    final badgeBgColor = isPending ? const Color(0xFFFFF7ED) : const Color(0xFFF0FDF4);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          // Step Number Circle
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFFD6E4FF), Color(0xFFA5C0F3)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Text(
                item.stepNumber.toString(),
                style: TextStyle(
                  color: Color(0xFF1E3A8A),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Title
          Expanded(
            child: Text(
              item.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // Status Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: badgeBgColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: badgeColor.withOpacity(0.5)),
            ),
            child: Text(
              isPending ? 'Pending' : 'Completed',
              style: TextStyle(
                color: badgeColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
