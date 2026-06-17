// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupMemberModelImpl _$$GroupMemberModelImplFromJson(
  Map<String, dynamic> json,
) => _$GroupMemberModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  username: json['username'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  role: json['role'] as String,
  score: (json['score'] as num).toInt(),
  rank: (json['rank'] as num).toInt(),
);

Map<String, dynamic> _$$GroupMemberModelImplToJson(
  _$GroupMemberModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'username': instance.username,
  'avatarUrl': instance.avatarUrl,
  'role': instance.role,
  'score': instance.score,
  'rank': instance.rank,
};
