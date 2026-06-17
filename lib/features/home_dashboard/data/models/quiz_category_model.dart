import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/quiz_category.dart';

part 'quiz_category_model.freezed.dart';
part 'quiz_category_model.g.dart';

@freezed
class QuizCategoryModel with _$QuizCategoryModel {
  const factory QuizCategoryModel({
    required String id,
    required String title,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'icon_type') required String iconType,
  }) = _QuizCategoryModel;

  factory QuizCategoryModel.fromJson(Map<String, dynamic> json) => _$QuizCategoryModelFromJson(json);
}

extension QuizCategoryModelX on QuizCategoryModel {
  QuizCategory toEntity() {
    return QuizCategory(
      id: id,
      title: title,
      iconType: iconType,
    );
  }
}
