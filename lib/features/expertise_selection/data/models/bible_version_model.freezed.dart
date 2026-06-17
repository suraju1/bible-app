// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bible_version_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BibleVersionModel _$BibleVersionModelFromJson(Map<String, dynamic> json) {
  return _BibleVersionModel.fromJson(json);
}

/// @nodoc
mixin _$BibleVersionModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;

  /// Serializes this BibleVersionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BibleVersionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BibleVersionModelCopyWith<BibleVersionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BibleVersionModelCopyWith<$Res> {
  factory $BibleVersionModelCopyWith(
    BibleVersionModel value,
    $Res Function(BibleVersionModel) then,
  ) = _$BibleVersionModelCopyWithImpl<$Res, BibleVersionModel>;
  @useResult
  $Res call({int id, String name, String code});
}

/// @nodoc
class _$BibleVersionModelCopyWithImpl<$Res, $Val extends BibleVersionModel>
    implements $BibleVersionModelCopyWith<$Res> {
  _$BibleVersionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BibleVersionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? code = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BibleVersionModelImplCopyWith<$Res>
    implements $BibleVersionModelCopyWith<$Res> {
  factory _$$BibleVersionModelImplCopyWith(
    _$BibleVersionModelImpl value,
    $Res Function(_$BibleVersionModelImpl) then,
  ) = __$$BibleVersionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String code});
}

/// @nodoc
class __$$BibleVersionModelImplCopyWithImpl<$Res>
    extends _$BibleVersionModelCopyWithImpl<$Res, _$BibleVersionModelImpl>
    implements _$$BibleVersionModelImplCopyWith<$Res> {
  __$$BibleVersionModelImplCopyWithImpl(
    _$BibleVersionModelImpl _value,
    $Res Function(_$BibleVersionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BibleVersionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? code = null}) {
    return _then(
      _$BibleVersionModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BibleVersionModelImpl implements _BibleVersionModel {
  const _$BibleVersionModelImpl({
    required this.id,
    required this.name,
    required this.code,
  });

  factory _$BibleVersionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BibleVersionModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String code;

  @override
  String toString() {
    return 'BibleVersionModel(id: $id, name: $name, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BibleVersionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, code);

  /// Create a copy of BibleVersionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BibleVersionModelImplCopyWith<_$BibleVersionModelImpl> get copyWith =>
      __$$BibleVersionModelImplCopyWithImpl<_$BibleVersionModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BibleVersionModelImplToJson(this);
  }
}

abstract class _BibleVersionModel implements BibleVersionModel {
  const factory _BibleVersionModel({
    required final int id,
    required final String name,
    required final String code,
  }) = _$BibleVersionModelImpl;

  factory _BibleVersionModel.fromJson(Map<String, dynamic> json) =
      _$BibleVersionModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get code;

  /// Create a copy of BibleVersionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BibleVersionModelImplCopyWith<_$BibleVersionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
