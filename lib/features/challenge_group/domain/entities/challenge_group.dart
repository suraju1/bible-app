import 'group_member.dart';

class ChallengeGroup {
  final String id;
  final String name;
  final String topicName;
  final String bibleReference;
  final DateTime startDate;
  final DateTime endDate;
  final int memberCount;
  final List<GroupMember> members;

  const ChallengeGroup({
    required this.id,
    required this.name,
    required this.topicName,
    required this.bibleReference,
    required this.startDate,
    required this.endDate,
    required this.memberCount,
    required this.members,
  });
}
