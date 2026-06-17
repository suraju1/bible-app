import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/challenge.dart';

part 'challenge_model.freezed.dart';
part 'challenge_model.g.dart';

@freezed
class ChallengeModel with _$ChallengeModel {
  const factory ChallengeModel({
    required String title,
    required String description,
    required double progress,
  }) = _ChallengeModel;

  factory ChallengeModel.fromJson(Map<String, dynamic> json) => _$ChallengeModelFromJson(json);
}

extension ChallengeModelX on ChallengeModel {
  Challenge toEntity() {
    return Challenge(
      title: title,
      description: description,
      progress: progress,
    );
  }
}
