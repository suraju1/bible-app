import 'package:dio/dio.dart';
import '../models/challenge_group_model.dart';
import '../models/group_member_model.dart';

abstract class ChallengeGroupRemoteDataSource {
  Future<List<ChallengeGroupModel>> getJoinedGroups();
  Future<ChallengeGroupModel> getGroupDetails(String groupId);
  Future<ChallengeGroupModel> createGroup(ChallengeGroupModel group);
  Future<void> deleteGroup(String groupId);
  Future<void> exitGroup(String groupId);
}

class ChallengeGroupRemoteDataSourceImpl implements ChallengeGroupRemoteDataSource {
  final Dio dio;

  ChallengeGroupRemoteDataSourceImpl({required this.dio});

  // Mock Data
  final List<GroupMemberModel> _mockMembers = [
    const GroupMemberModel(
      id: '1',
      name: 'You',
      username: '@Caroline',
      role: 'Group Admin',
      score: 10,
      rank: 1,
    ),
    const GroupMemberModel(
      id: '2',
      name: 'Caroline Hugo',
      username: '@Caroline',
      role: 'Member',
      score: 10,
      rank: 2,
    ),
    const GroupMemberModel(
      id: '3',
      name: 'Caroline Hugo',
      username: '@Caroline',
      role: 'Member',
      score: 10,
      rank: 3,
    ),
    const GroupMemberModel(
      id: '4',
      name: 'Caroline Hugo',
      username: '@Caroline',
      role: 'Member',
      score: 10,
      rank: 4,
    ),
  ];

  late final ChallengeGroupModel _mockGroup = ChallengeGroupModel(
    id: 'g1',
    name: 'Quiz Battel!',
    topicName: 'Creation - In the beginning',
    bibleReference: 'Genesis 1:1-31',
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 30)),
    memberCount: 4,
    members: _mockMembers,
  );

  @override
  Future<List<ChallengeGroupModel>> getJoinedGroups() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return [_mockGroup]; // Returning 1 group to match Figma populated state
  }

  @override
  Future<ChallengeGroupModel> getGroupDetails(String groupId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockGroup;
  }

  @override
  Future<ChallengeGroupModel> createGroup(ChallengeGroupModel group) async {
    await Future.delayed(const Duration(seconds: 1));
    return group.copyWith(id: 'g_new_${DateTime.now().millisecondsSinceEpoch}');
  }

  @override
  Future<void> deleteGroup(String groupId) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> exitGroup(String groupId) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
