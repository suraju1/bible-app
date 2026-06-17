import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/challenge_group.dart';
import 'group_member_model.dart';

part 'challenge_group_model.freezed.dart';
part 'challenge_group_model.g.dart';

@freezed
class ChallengeGroupModel with _$ChallengeGroupModel {
  const factory ChallengeGroupModel({
    required String id,
    required String name,
    required String topicName,
    required String bibleReference,
    required DateTime startDate,
    required DateTime endDate,
    required int memberCount,
    required List<GroupMemberModel> members,
  }) = _ChallengeGroupModel;

  factory ChallengeGroupModel.fromJson(Map<String, dynamic> json) =>
      _$ChallengeGroupModelFromJson(json);
}

extension ChallengeGroupModelX on ChallengeGroupModel {
  ChallengeGroup toEntity() {
    return ChallengeGroup(
      id: id,
      name: name,
      topicName: topicName,
      bibleReference: bibleReference,
      startDate: startDate,
      endDate: endDate,
      memberCount: memberCount,
      members: members.map((m) => m.toEntity()).toList(),
    );
  }
}
