// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BibleVersionModelImpl _$$BibleVersionModelImplFromJson(
  Map<String, dynamic> json,
) => _$BibleVersionModelImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  code: json['code'] as String,
);

Map<String, dynamic> _$$BibleVersionModelImplToJson(
  _$BibleVersionModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'code': instance.code,
};
