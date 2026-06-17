// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LanguageModelImpl _$$LanguageModelImplFromJson(Map<String, dynamic> json) =>
    _$LanguageModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      nativeName: json['nativeName'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$$LanguageModelImplToJson(_$LanguageModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nativeName': instance.nativeName,
      'code': instance.code,
    };
