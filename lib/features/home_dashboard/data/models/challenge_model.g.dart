// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeModelImpl _$$ChallengeModelImplFromJson(Map<String, dynamic> json) =>
    _$ChallengeModelImpl(
      title: json['title'] as String,
      description: json['description'] as String,
      progress: (json['progress'] as num).toDouble(),
    );

Map<String, dynamic> _$$ChallengeModelImplToJson(
  _$ChallengeModelImpl instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'progress': instance.progress,
};
