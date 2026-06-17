// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TranslationTaskModelImpl _$$TranslationTaskModelImplFromJson(
  Map<String, dynamic> json,
) => _$TranslationTaskModelImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  sourceLanguage: json['sourceLanguage'] as String,
  targetLanguage: json['targetLanguage'] as String,
  sourceBibleVersion: json['sourceBibleVersion'] as String,
  translatedBibleVersion: json['translatedBibleVersion'] as String?,
  sourceTopicName: json['sourceTopicName'] as String,
  translatedTopicName: json['translatedTopicName'] as String?,
  sourceBibleReference: json['sourceBibleReference'] as String,
  translatedBibleReference: json['translatedBibleReference'] as String?,
  sourceQuestion: json['sourceQuestion'] as String,
  translatedQuestion: json['translatedQuestion'] as String?,
);

Map<String, dynamic> _$$TranslationTaskModelImplToJson(
  _$TranslationTaskModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'sourceLanguage': instance.sourceLanguage,
  'targetLanguage': instance.targetLanguage,
  'sourceBibleVersion': instance.sourceBibleVersion,
  'translatedBibleVersion': instance.translatedBibleVersion,
  'sourceTopicName': instance.sourceTopicName,
  'translatedTopicName': instance.translatedTopicName,
  'sourceBibleReference': instance.sourceBibleReference,
  'translatedBibleReference': instance.translatedBibleReference,
  'sourceQuestion': instance.sourceQuestion,
  'translatedQuestion': instance.translatedQuestion,
};
