import 'package:flutter/material.dart';

class RankBadgeWidget extends StatelessWidget {
  final String rankName;
  final String assetPath;
  final int requiredLevel;
  final bool isUnlocked;
  final bool isCurrentRank;

  const RankBadgeWidget({
    super.key,
    required this.rankName,
    required this.assetPath,
    required this.requiredLevel,
    required this.isUnlocked,
    this.isCurrentRank = false,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isUnlocked ? 1.0 : 0.4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCurrentRank ? Colors.amber.withOpacity(0.2) : Colors.transparent,
              border: isCurrentRank ? Border.all(color: Colors.amber, width: 2) : null,
            ),
            padding: const EdgeInsets.all(4),
            child: Image.asset(
              assetPath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Placeholder if asset doesn't exist yet
                return const Icon(Icons.shield, size: 40, color: Colors.blueGrey);
              },
            ),
          ),
          const SizedBox(height: 4),
          Text(
            rankName.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: isCurrentRank ? FontWeight.bold : FontWeight.w600,
              color: _getRankColor(rankName),
            ),
          ),
          Text(
            '$requiredLevel Level',
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRankColor(String rank) {
    switch (rank.toLowerCase()) {
      case 'bronze':
        return const Color(0xFFCD7F32);
      case 'silver':
        return const Color(0xFFC0C0C0);
      case 'gold':
        return const Color(0xFFFFD700);
      case 'platinum':
        return const Color(0xFFE5E4E2);
      case 'diamond':
        return const Color(0xFFb9f2ff);
      case 'master':
        return const Color(0xFF9966CC);
      case 'grand master':
        return const Color(0xFFFF4500);
      case 'elite':
        return const Color(0xFF00CED1);
      case 'champion':
        return const Color(0xFFDAA520);
      case 'legend':
        return const Color(0xFFFFD700);
      default:
        return Colors.grey;
    }
  }
}
