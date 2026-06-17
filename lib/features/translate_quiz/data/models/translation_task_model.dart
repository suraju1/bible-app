import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/translation_task.dart';

part 'translation_task_model.freezed.dart';
part 'translation_task_model.g.dart';

@freezed
class TranslationTaskModel with _$TranslationTaskModel {
  const factory TranslationTaskModel({
    required String id,
    required String title,
    required String sourceLanguage,
    required String targetLanguage,
    required String sourceBibleVersion,
    String? translatedBibleVersion,
    required String sourceTopicName,
    String? translatedTopicName,
    required String sourceBibleReference,
    String? translatedBibleReference,
    required String sourceQuestion,
    String? translatedQuestion,
  }) = _TranslationTaskModel;

  factory TranslationTaskModel.fromJson(Map<String, dynamic> json) =>
      _$TranslationTaskModelFromJson(json);
}

extension TranslationTaskModelX on TranslationTaskModel {
  TranslationTask toEntity() {
    return TranslationTask(
      id: id,
      title: title,
      sourceLanguage: sourceLanguage,
      targetLanguage: targetLanguage,
      sourceBibleVersion: sourceBibleVersion,
      translatedBibleVersion: translatedBibleVersion,
      sourceTopicName: sourceTopicName,
      translatedTopicName: translatedTopicName,
      sourceBibleReference: sourceBibleReference,
      translatedBibleReference: translatedBibleReference,
      sourceQuestion: sourceQuestion,
      translatedQuestion: translatedQuestion,
    );
  }

  static TranslationTaskModel fromEntity(TranslationTask entity) {
    return TranslationTaskModel(
      id: entity.id,
      title: entity.title,
      sourceLanguage: entity.sourceLanguage,
      targetLanguage: entity.targetLanguage,
      sourceBibleVersion: entity.sourceBibleVersion,
      translatedBibleVersion: entity.translatedBibleVersion,
      sourceTopicName: entity.sourceTopicName,
      translatedTopicName: entity.translatedTopicName,
      sourceBibleReference: entity.sourceBibleReference,
      translatedBibleReference: entity.translatedBibleReference,
      sourceQuestion: entity.sourceQuestion,
      translatedQuestion: entity.translatedQuestion,
    );
  }
}
