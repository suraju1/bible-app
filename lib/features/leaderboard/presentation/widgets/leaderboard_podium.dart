import 'package:flutter/material.dart';
import '../../domain/entities/leaderboard_user.dart';
import 'podium_card.dart';

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
          if (second != null) PodiumCard(user: second, height: 190, position: 0),
          const SizedBox(width: 16),
          PodiumCard(user: first, height: 240, position: 1),
          const SizedBox(width: 16),
          if (third != null) PodiumCard(user: third, height: 160, position: 2),
        ],
      ),
    );
  }
}
