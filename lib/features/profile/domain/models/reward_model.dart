class RewardModel {
  final String id;
  final String description;
  final String title;
  final String status; // 'available', 'claimed', 'expired'

  RewardModel({
    required this.id,
    required this.description,
    required this.title,
    required this.status,
  });

  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
      id: json['id'] as String,
      description: json['description'] as String,
      title: json['title'] as String,
      status: json['status'] as String,
    );
  }

  RewardModel copyWith({
    String? id,
    String? description,
    String? title,
    String? status,
  }) {
    return RewardModel(
      id: id ?? this.id,
      description: description ?? this.description,
      title: title ?? this.title,
      status: status ?? this.status,
    );
  }
}

class RewardsDataModel {
  final int totalPoints;
  final List<RewardModel> rewards;

  RewardsDataModel({
    required this.totalPoints,
    required this.rewards,
  });

  factory RewardsDataModel.fromJson(Map<String, dynamic> json) {
    return RewardsDataModel(
      totalPoints: json['total_points'] as int? ?? 0,
      rewards: (json['rewards'] as List<dynamic>?)
              ?.map((e) => RewardModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  RewardsDataModel copyWith({
    int? totalPoints,
    List<RewardModel>? rewards,
  }) {
    return RewardsDataModel(
      totalPoints: totalPoints ?? this.totalPoints,
      rewards: rewards ?? this.rewards,
    );
  }
}
