import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../domain/entities/leaderboard_user.dart';
import '../../../../core/utils/rank_utils.dart';

class PodiumCard extends StatelessWidget {
  final LeaderboardUser user;
  final double height;
  final int position; // 0 = 2nd, 1 = 1st, 2 = 3rd

  const PodiumCard({
    Key? key,
    required this.user,
    required this.height,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isFirst = position == 1;
    final isSecond = position == 0;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Pillar Stack
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            // The semi-transparent pillar
            Container(
              width: 76,
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
                      fontWeight: FontWeight.w600, // semi-bold
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
                      fontSize: 22, // bold, 22px
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50), // Increased space at bottom
                ],
              ),
            ),
            
            // Avatar positioned overlapping the top edge
            Positioned(
              top: isFirst ? -40 : -35,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3.0,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: isFirst ? 36 : 30,
                      backgroundImage: NetworkImage(user.avatarUrl),
                    ),
                  ),
                  // Custom Rank Image (Floating above Avatar)
                  Positioned(
                    top: isFirst ? -32 : -24,
                    child: Image.asset(
                      isFirst 
                          ? 'assets/images/1st_rank.png' 
                          : (isSecond ? 'assets/images/2nd_rank.png' : 'assets/images/3rd_rank.png'),
                      width: isFirst ? 44 : 36,
                      height: isFirst ? 44 : 36,
                      fit: BoxFit.contain,
                    ),
                  ),
                  // True Rank Image from User Level
                  Positioned(
                    bottom: -12,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(3),
                      child: Image.asset(
                        RankUtils.getRankAsset(user.level),
                        width: 32,
                        height: 32,
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
