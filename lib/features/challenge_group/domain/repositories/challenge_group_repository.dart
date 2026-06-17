import '../entities/challenge_group.dart';

abstract class ChallengeGroupRepository {
  Future<List<ChallengeGroup>> getJoinedGroups();
  Future<ChallengeGroup> getGroupDetails(String groupId);
  Future<ChallengeGroup> createGroup(ChallengeGroup group);
  Future<void> deleteGroup(String groupId);
  Future<void> exitGroup(String groupId);
}
