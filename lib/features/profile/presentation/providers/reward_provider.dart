import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/reward_model.dart';
import '../../data/repositories/reward_repository.dart';

final rewardRepositoryProvider = Provider<RewardRepository>((ref) {
  return RewardRepository();
});

final rewardsProvider = StateNotifierProvider.autoDispose<RewardNotifier, AsyncValue<RewardsDataModel>>((ref) {
  final repo = ref.read(rewardRepositoryProvider);
  return RewardNotifier(repo);
});

class RewardNotifier extends StateNotifier<AsyncValue<RewardsDataModel>> {
  final RewardRepository _repository;

  RewardNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchRewards();
  }

  Future<void> fetchRewards() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.fetchRewards();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> claimReward(String rewardId) async {
    if (state is! AsyncData) return;

    final currentData = state.value!;
    // Optimistic update
    final updatedRewards = currentData.rewards.map((reward) {
      if (reward.id == rewardId) {
        return reward.copyWith(status: 'claimed');
      }
      return reward;
    }).toList();

    state = AsyncValue.data(currentData.copyWith(rewards: updatedRewards));

    try {
      final success = await _repository.claimReward(rewardId);
      if (!success) {
        // Revert on failure
        state = AsyncValue.data(currentData);
      }
    } catch (e) {
      // Revert on error
      state = AsyncValue.data(currentData);
    }
  }
}
