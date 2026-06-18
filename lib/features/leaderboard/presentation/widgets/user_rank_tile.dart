import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/leaderboard_user.dart';

class UserRankTile extends StatelessWidget {
  final LeaderboardUser user;
  final VoidCallback onTap;

  const UserRankTile({
    Key? key,
    required this.user,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0), // Reduced vertical padding
            child: Row(
              children: [
                SizedBox(
                  width: 44,
                  child: Text(
                    '${user.rank}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                  ),
                ),
                const SizedBox(width: 8),
                
                // Circular User Avatar
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
                        user.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500, // Medium weight
                          color: AppColors.textPrimary,
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
                    // Mock rank badge using icons
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.shield,
                          size: 24,
                          color: user.rank == 1
                              ? const Color(0xFFFFD700)
                              : (user.rank == 2
                                  ? const Color(0xFFE0E0E0)
                                  : (user.rank == 3 ? const Color(0xFFCD7F32) : const Color(0xFFB87333))),
                        ),
                        const Icon(
                          Icons.star,
                          size: 10,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
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
}
