import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/leaderboard_user.dart';

class LeaderboardListItem extends StatelessWidget {
  final LeaderboardUser user;
  final VoidCallback onTap;
  final bool isPinnedBottom;

  const LeaderboardListItem({
    Key? key,
    required this.user,
    required this.onTap,
    this.isPinnedBottom = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // If it's the pinned bottom row, apply the stadium border styling
    if (isPinnedBottom) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: AppColors.primary, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: _buildRowContent(context),
            ),
          ),
        ),
      );
    }

    // Standard list row
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: _buildRowContent(context),
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey.shade200,
          indent: 24,
          endIndent: 24,
        ),
      ],
    );
  }

  Widget _buildRowContent(BuildContext context) {
    final textColor = isPinnedBottom ? AppColors.primary : AppColors.textPrimary;
    final rankColor = isPinnedBottom ? AppColors.primary : Colors.black87;

    return Row(
      children: [
        // Rank Number
        SizedBox(
          width: 40,
          child: Text(
            '${user.rank}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: rankColor,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.visible,
          ),
        ),
        const SizedBox(width: 12),
        
        // Avatar
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(user.avatarUrl),
          backgroundColor: Colors.grey.shade200,
        ),
        const SizedBox(width: 12),
        
        // Name & Username
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isPinnedBottom ? 'You' : user.name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                '@${user.name.split(' ').first}', // Mock username
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        
        // Score Info
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'Score',
              style: TextStyle(
                fontSize: 10,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '${user.score}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        
        // Rank Badge
        Column(
          children: [
            const Text(
              'Rank',
              style: TextStyle(
                fontSize: 10,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            // Placeholder for rank badge image
            Icon(
              Icons.shield, // Fallback for the rank wing badge
              size: 20,
              color: user.rank <= 3 ? const Color(0xFFFFD700) : const Color(0xFFCD7F32),
            ),
          ],
        ),
      ],
    );
  }
}
