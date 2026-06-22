import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/leaderboard_user.dart';
import '../../../../core/utils/rank_utils.dart';

class CurrentUserCard extends StatelessWidget {
  final LeaderboardUser user;
  final VoidCallback onTap;

  const CurrentUserCard({
    Key? key,
    required this.user,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF01369F), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF01369F).withValues(alpha: 0.1),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                SizedBox(
                  width: 44,
                  child: Text(
                    '${user.rank}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF01369F),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                  ),
                ),
                const SizedBox(width: 8),
                
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
                      const Text(
                        'You',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500, // Medium weight
                          color: Color(0xFF01369F), // Primary blue
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Score',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${user.score}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600, // Semi-bold
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                
                // Rank Badge
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Rank',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Image.asset(
                      RankUtils.getRankAsset(user.level),
                      width: 36,
                      height: 36,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
