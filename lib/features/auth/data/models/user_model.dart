import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'full_name') required String fullName,
    required String email,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'phone_number') required String phoneNumber,
    required String token,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

extension UserModelX on UserModel {
  User toEntity() {
    return User(
      id: id,
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      token: token,
    );
  }
}
