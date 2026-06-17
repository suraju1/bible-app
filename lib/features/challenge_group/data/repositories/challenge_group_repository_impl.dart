import '../../domain/entities/challenge_group.dart';
import '../../domain/repositories/challenge_group_repository.dart';
import '../datasources/challenge_group_remote_data_source.dart';
import '../models/challenge_group_model.dart';

class ChallengeGroupRepositoryImpl implements ChallengeGroupRepository {
  final ChallengeGroupRemoteDataSource remoteDataSource;

  ChallengeGroupRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ChallengeGroup>> getJoinedGroups() async {
    final models = await remoteDataSource.getJoinedGroups();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<ChallengeGroup> getGroupDetails(String groupId) async {
    final model = await remoteDataSource.getGroupDetails(groupId);
    return model.toEntity();
  }

  @override
  Future<ChallengeGroup> createGroup(ChallengeGroup group) async {
    // Map entity to model (omitted mapping for brevity, mocking the response)
    final modelToCreate = ChallengeGroupModel(
      id: group.id,
      name: group.name,
      topicName: group.topicName,
      bibleReference: group.bibleReference,
      startDate: group.startDate,
      endDate: group.endDate,
      memberCount: group.memberCount,
      members: [], // Simplification for mock
    );
    final createdModel = await remoteDataSource.createGroup(modelToCreate);
    return createdModel.toEntity();
  }

  @override
  Future<void> deleteGroup(String groupId) async {
    await remoteDataSource.deleteGroup(groupId);
  }

  @override
  Future<void> exitGroup(String groupId) async {
    await remoteDataSource.exitGroup(groupId);
  }
}
