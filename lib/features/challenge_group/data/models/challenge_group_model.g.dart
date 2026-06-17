// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeGroupModelImpl _$$ChallengeGroupModelImplFromJson(
  Map<String, dynamic> json,
) => _$ChallengeGroupModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  topicName: json['topicName'] as String,
  bibleReference: json['bibleReference'] as String,
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  memberCount: (json['memberCount'] as num).toInt(),
  members: (json['members'] as List<dynamic>)
      .map((e) => GroupMemberModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$ChallengeGroupModelImplToJson(
  _$ChallengeGroupModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'topicName': instance.topicName,
  'bibleReference': instance.bibleReference,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'memberCount': instance.memberCount,
  'members': instance.members,
};
