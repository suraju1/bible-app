// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'correction_task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorrectionTaskModelImpl _$$CorrectionTaskModelImplFromJson(
  Map<String, dynamic> json,
) => _$CorrectionTaskModelImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  userName: json['userName'] as String,
  userAvatarUrl: json['userAvatarUrl'] as String,
  feedbackQuestion: json['feedbackQuestion'] as String,
  feedbackComment: json['feedbackComment'] as String,
  currentBibleVersion: json['currentBibleVersion'] as String,
  currentTopicName: json['currentTopicName'] as String,
  currentBibleReference: json['currentBibleReference'] as String,
  currentBibleVerse: json['currentBibleVerse'] as String,
  currentQuestion: json['currentQuestion'] as String,
  currentOptions: json['currentOptions'] as String,
  currentExplanation: json['currentExplanation'] as String,
);

Map<String, dynamic> _$$CorrectionTaskModelImplToJson(
  _$CorrectionTaskModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'userName': instance.userName,
  'userAvatarUrl': instance.userAvatarUrl,
  'feedbackQuestion': instance.feedbackQuestion,
  'feedbackComment': instance.feedbackComment,
  'currentBibleVersion': instance.currentBibleVersion,
  'currentTopicName': instance.currentTopicName,
  'currentBibleReference': instance.currentBibleReference,
  'currentBibleVerse': instance.currentBibleVerse,
  'currentQuestion': instance.currentQuestion,
  'currentOptions': instance.currentOptions,
  'currentExplanation': instance.currentExplanation,
};
