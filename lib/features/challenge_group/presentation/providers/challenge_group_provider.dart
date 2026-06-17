import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/challenge_group.dart';
import '../../domain/repositories/challenge_group_repository.dart';
import '../../data/datasources/challenge_group_remote_data_source.dart';
import '../../data/repositories/challenge_group_repository_impl.dart';

// Providers
final challengeGroupDioProvider = Provider<Dio>((ref) => ref.watch(dioProvider));

final challengeGroupRemoteDataSourceProvider = Provider<ChallengeGroupRemoteDataSource>((ref) {
  return ChallengeGroupRemoteDataSourceImpl(dio: ref.watch(challengeGroupDioProvider));
});

final challengeGroupRepositoryProvider = Provider<ChallengeGroupRepository>((ref) {
  return ChallengeGroupRepositoryImpl(remoteDataSource: ref.watch(challengeGroupRemoteDataSourceProvider));
});

// State classes
class JoinedGroupsState {
  final AsyncValue<List<ChallengeGroup>> groups;
  JoinedGroupsState({this.groups = const AsyncValue.loading()});

  JoinedGroupsState copyWith({AsyncValue<List<ChallengeGroup>>? groups}) {
    return JoinedGroupsState(groups: groups ?? this.groups);
  }
}

class JoinedGroupsNotifier extends StateNotifier<JoinedGroupsState> {
  final ChallengeGroupRepository repository;

  JoinedGroupsNotifier(this.repository) : super(JoinedGroupsState()) {
    fetchJoinedGroups();
  }

  Future<void> fetchJoinedGroups() async {
    state = state.copyWith(groups: const AsyncValue.loading());
    try {
      final items = await repository.getJoinedGroups();
      state = state.copyWith(groups: AsyncValue.data(items));
    } catch (e, stack) {
      state = state.copyWith(groups: AsyncValue.error(e, stack));
    }
  }
}

final joinedGroupsProvider = StateNotifierProvider<JoinedGroupsNotifier, JoinedGroupsState>((ref) {
  return JoinedGroupsNotifier(ref.watch(challengeGroupRepositoryProvider));
});

// Group Details Provider (FutureProvider)
final groupDetailsProvider = FutureProvider.family<ChallengeGroup, String>((ref, groupId) {
  final repo = ref.watch(challengeGroupRepositoryProvider);
  return repo.getGroupDetails(groupId);
});
