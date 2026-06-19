import '../../domain/models/reward_model.dart';

class RewardRepository {
  Future<RewardsDataModel> fetchRewards() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    return RewardsDataModel(
      totalPoints: 100,
      rewards: [
        RewardModel(
          id: '1',
          description: 'You achieved 3rd rank worldwide in quiz creation!',
          title: '3rd Prize Winner ₹100 Gift Card',
          status: 'available',
        ),
        RewardModel(
          id: '2',
          description: 'You achieved 1st rank worldwide in quiz participation!',
          title: '1st Prize Winner ₹500 Gift Card',
          status: 'claimed',
        ),
      ],
    );
  }

  Future<bool> claimReward(String rewardId) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    return true; // Assume success
  }
}
