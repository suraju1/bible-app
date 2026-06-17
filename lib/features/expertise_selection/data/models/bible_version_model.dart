import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/bible_version.dart';

part 'bible_version_model.freezed.dart';
part 'bible_version_model.g.dart';

@freezed
class BibleVersionModel with _$BibleVersionModel {
  const factory BibleVersionModel({
    required int id,
    required String name,
    required String code,
  }) = _BibleVersionModel;

  factory BibleVersionModel.fromJson(Map<String, dynamic> json) => _$BibleVersionModelFromJson(json);
}

extension BibleVersionModelX on BibleVersionModel {
  BibleVersion toEntity() {
    return BibleVersion(
      id: id,
      name: name,
      code: code,
    );
  }
}
