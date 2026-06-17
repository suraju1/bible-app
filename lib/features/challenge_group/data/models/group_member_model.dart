import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/group_member.dart';

part 'group_member_model.freezed.dart';
part 'group_member_model.g.dart';

@freezed
class GroupMemberModel with _$GroupMemberModel {
  const factory GroupMemberModel({
    required String id,
    required String name,
    required String username,
    String? avatarUrl,
    required String role,
    required int score,
    required int rank,
  }) = _GroupMemberModel;

  factory GroupMemberModel.fromJson(Map<String, dynamic> json) =>
      _$GroupMemberModelFromJson(json);
}

extension GroupMemberModelX on GroupMemberModel {
  GroupMember toEntity() {
    return GroupMember(
      id: id,
      name: name,
      username: username,
      avatarUrl: avatarUrl,
      role: role,
      score: score,
      rank: rank,
    );
  }
}
