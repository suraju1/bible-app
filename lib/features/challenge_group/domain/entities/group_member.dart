class GroupMember {
  final String id;
  final String name;
  final String username;
  final String? avatarUrl;
  final String role; // 'Group Admin', 'Member', etc.
  final int score;
  final int rank; // For leaderboard

  const GroupMember({
    required this.id,
    required this.name,
    required this.username,
    this.avatarUrl,
    required this.role,
    required this.score,
    required this.rank,
  });
}
