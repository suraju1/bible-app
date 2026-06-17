import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/language.dart';

part 'language_model.freezed.dart';
part 'language_model.g.dart';

@freezed
class LanguageModel with _$LanguageModel {
  const factory LanguageModel({
    required int id,
    required String name,
    required String nativeName,
    required String code,
  }) = _LanguageModel;

  factory LanguageModel.fromJson(Map<String, dynamic> json) => _$LanguageModelFromJson(json);
}

extension LanguageModelX on LanguageModel {
  Language toEntity() {
    return Language(
      id: id,
      name: name,
      nativeName: nativeName,
      code: code,
    );
  }
}
