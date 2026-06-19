import '../../domain/models/referral_model.dart';

class ReferralRepository {
  Future<ReferralDataModel> fetchReferralData(String statusFilter) async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 800));

    final allItems = [
      ReferralItem(
        id: '1',
        title: 'App installed but not played yet.',
        status: 'pending',
        stepNumber: 1,
      ),
      ReferralItem(
        id: '2',
        title: 'Your friend played 5 quizzes.',
        status: 'completed',
        stepNumber: 2,
      ),
    ];

    List<ReferralItem> filteredList;
    if (statusFilter == 'pending') {
      filteredList = allItems.where((i) => i.status == 'pending').toList();
    } else if (statusFilter == 'completed') {
      filteredList = allItems.where((i) => i.status == 'completed').toList();
    } else {
      filteredList = allItems;
    }

    return ReferralDataModel(
      totalReferrals: 2,
      pendingReferrals: 1,
      completedReferrals: 1,
      referralLink: 'https://www.google.com/referral=xyz123',
      history: filteredList,
    );
  }
}
