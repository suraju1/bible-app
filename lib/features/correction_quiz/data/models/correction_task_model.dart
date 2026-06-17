import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/correction_task.dart';

part 'correction_task_model.freezed.dart';
part 'correction_task_model.g.dart';

@freezed
class CorrectionTaskModel with _$CorrectionTaskModel {
  const factory CorrectionTaskModel({
    required String id,
    required String title,
    required String userName,
    required String userAvatarUrl,
    required String feedbackQuestion,
    required String feedbackComment,
    required String currentBibleVersion,
    required String currentTopicName,
    required String currentBibleReference,
    required String currentBibleVerse,
    required String currentQuestion,
    required String currentOptions,
    required String currentExplanation,
  }) = _CorrectionTaskModel;

  factory CorrectionTaskModel.fromJson(Map<String, dynamic> json) =>
      _$CorrectionTaskModelFromJson(json);
}

extension CorrectionTaskModelX on CorrectionTaskModel {
  CorrectionTask toEntity() {
    return CorrectionTask(
      id: id,
      title: title,
      userName: userName,
      userAvatarUrl: userAvatarUrl,
      feedbackQuestion: feedbackQuestion,
      feedbackComment: feedbackComment,
      currentBibleVersion: currentBibleVersion,
      currentTopicName: currentTopicName,
      currentBibleReference: currentBibleReference,
      currentBibleVerse: currentBibleVerse,
      currentQuestion: currentQuestion,
      currentOptions: currentOptions,
      currentExplanation: currentExplanation,
    );
  }

  static CorrectionTaskModel fromEntity(CorrectionTask entity) {
    return CorrectionTaskModel(
      id: entity.id,
      title: entity.title,
      userName: entity.userName,
      userAvatarUrl: entity.userAvatarUrl,
      feedbackQuestion: entity.feedbackQuestion,
      feedbackComment: entity.feedbackComment,
      currentBibleVersion: entity.currentBibleVersion,
      currentTopicName: entity.currentTopicName,
      currentBibleReference: entity.currentBibleReference,
      currentBibleVerse: entity.currentBibleVerse,
      currentQuestion: entity.currentQuestion,
      currentOptions: entity.currentOptions,
      currentExplanation: entity.currentExplanation,
    );
  }
}
