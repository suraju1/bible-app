class ReferralItem {
  final String id;
  final String title;
  final String status; // 'pending', 'completed'
  final int stepNumber;

  ReferralItem({
    required this.id,
    required this.title,
    required this.status,
    required this.stepNumber,
  });

  factory ReferralItem.fromJson(Map<String, dynamic> json) {
    return ReferralItem(
      id: json['id'] as String,
      title: json['title'] as String,
      status: json['status'] as String,
      stepNumber: json['stepNumber'] as int? ?? 1,
    );
  }
}

class ReferralDataModel {
  final int totalReferrals;
  final int pendingReferrals;
  final int completedReferrals;
  final String referralLink;
  final List<ReferralItem> history;

  ReferralDataModel({
    required this.totalReferrals,
    required this.pendingReferrals,
    required this.completedReferrals,
    required this.referralLink,
    required this.history,
  });

  factory ReferralDataModel.fromJson(Map<String, dynamic> json) {
    return ReferralDataModel(
      totalReferrals: json['totalReferrals'] as int? ?? 0,
      pendingReferrals: json['pendingReferrals'] as int? ?? 0,
      completedReferrals: json['completedReferrals'] as int? ?? 0,
      referralLink: json['referralLink'] as String? ?? '',
      history: (json['history'] as List<dynamic>?)
              ?.map((e) => ReferralItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
