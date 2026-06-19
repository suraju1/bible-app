import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/models/reward_model.dart';

class RewardCardWidget extends StatelessWidget {
  final RewardModel reward;
  final VoidCallback onClaim;

  const RewardCardWidget({
    super.key,
    required this.reward,
    required this.onClaim,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            reward.description,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                // Gift Icon
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8EFFF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.card_giftcard,
                    color: Color(0xFF4A76A8),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                
                // Title
                Expanded(
                  child: Text(
                    reward.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                
                // Action Button
                _buildActionButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    final isAvailable = reward.status == 'available';
    final isClaimed = reward.status == 'claimed';
    
    Color bgColor;
    Color textColor;
    String buttonText;

    if (isAvailable) {
      bgColor = const Color(0xFF2E5B9F); // Blue
      textColor = Colors.white;
      buttonText = 'Claim';
    } else if (isClaimed) {
      bgColor = Colors.grey.shade300;
      textColor = Colors.grey.shade700;
      buttonText = 'Claimed';
    } else {
      // Expired or other
      bgColor = Colors.grey.shade200;
      textColor = Colors.grey.shade600;
      buttonText = 'Expired';
    }

    return GestureDetector(
      onTap: isAvailable ? onClaim : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
