import 'package:flutter/material.dart';
import '../../domain/entities/leaderboard_user.dart';

class LeaderboardPodium extends StatelessWidget {
  final List<LeaderboardUser> topUsers;

  const LeaderboardPodium({Key? key, required this.topUsers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (topUsers.isEmpty) return const SizedBox.shrink();

    final first = topUsers.firstWhere((u) => u.rank == 1, orElse: () => topUsers.first);
    final second = topUsers.length > 1 ? topUsers.firstWhere((u) => u.rank == 2, orElse: () => topUsers[1]) : null;
    final third = topUsers.length > 2 ? topUsers.firstWhere((u) => u.rank == 3, orElse: () => topUsers[2]) : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (second != null) _buildPodiumColumn(context, second, 160, 0),
          const SizedBox(width: 12),
          _buildPodiumColumn(context, first, 200, 1),
          const SizedBox(width: 12),
          if (third != null) _buildPodiumColumn(context, third, 140, 2),
        ],
      ),
    );
  }

  Widget _buildPodiumColumn(BuildContext context, LeaderboardUser user, double height, int position) {
    final isFirst = position == 1;
    final isSecond = position == 0;
    
    // Figma uses a semi-transparent whiteish pill
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Crown Icon
        Icon(
          Icons.workspace_premium, // Fallback for crown
          color: isFirst
              ? const Color(0xFFFFD700)
              : (isSecond ? const Color(0xFFC0C0C0) : const Color(0xFFCD7F32)),
          size: isFirst ? 36 : 28,
        ),
        const SizedBox(height: 4),
        
        // Pillar Stack
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            // The semi-transparent pillar
            Container(
              width: 90,
              height: height,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(45)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    user.name.split(' ').first,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Score',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    '${user.score}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50), // Increased space at bottom so text clears the white container
                ],
              ),
            ),
            
            // Avatar positioned overlapping the top
            Positioned(
              top: 6,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isFirst ? const Color(0xFFFFD700) : Colors.white,
                        width: 2.5,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: isFirst ? 32 : 28,
                      backgroundImage: NetworkImage(user.avatarUrl),
                    ),
                  ),
                  if (isFirst)
                    Positioned(
                      bottom: -8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD700),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, size: 10, color: Colors.white),
                            SizedBox(width: 2),
                            Text(
                              '1',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
