// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leaderboard_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LeaderboardUserModel _$LeaderboardUserModelFromJson(Map<String, dynamic> json) {
  return _LeaderboardUserModel.fromJson(json);
}

/// @nodoc
mixin _$LeaderboardUserModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get avatarUrl => throw _privateConstructorUsedError;
  int get rank => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  bool get isCurrentUser => throw _privateConstructorUsedError;

  /// Serializes this LeaderboardUserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaderboardUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaderboardUserModelCopyWith<LeaderboardUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderboardUserModelCopyWith<$Res> {
  factory $LeaderboardUserModelCopyWith(
    LeaderboardUserModel value,
    $Res Function(LeaderboardUserModel) then,
  ) = _$LeaderboardUserModelCopyWithImpl<$Res, LeaderboardUserModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String avatarUrl,
    int rank,
    int score,
    int level,
    bool isCurrentUser,
  });
}

/// @nodoc
class _$LeaderboardUserModelCopyWithImpl<
  $Res,
  $Val extends LeaderboardUserModel
>
    implements $LeaderboardUserModelCopyWith<$Res> {
  _$LeaderboardUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaderboardUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatarUrl = null,
    Object? rank = null,
    Object? score = null,
    Object? level = null,
    Object? isCurrentUser = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: null == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            rank: null == rank
                ? _value.rank
                : rank // ignore: cast_nullable_to_non_nullable
                      as int,
            score: null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as int,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
            isCurrentUser: null == isCurrentUser
                ? _value.isCurrentUser
                : isCurrentUser // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LeaderboardUserModelImplCopyWith<$Res>
    implements $LeaderboardUserModelCopyWith<$Res> {
  factory _$$LeaderboardUserModelImplCopyWith(
    _$LeaderboardUserModelImpl value,
    $Res Function(_$LeaderboardUserModelImpl) then,
  ) = __$$LeaderboardUserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String avatarUrl,
    int rank,
    int score,
    int level,
    bool isCurrentUser,
  });
}

/// @nodoc
class __$$LeaderboardUserModelImplCopyWithImpl<$Res>
    extends _$LeaderboardUserModelCopyWithImpl<$Res, _$LeaderboardUserModelImpl>
    implements _$$LeaderboardUserModelImplCopyWith<$Res> {
  __$$LeaderboardUserModelImplCopyWithImpl(
    _$LeaderboardUserModelImpl _value,
    $Res Function(_$LeaderboardUserModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LeaderboardUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatarUrl = null,
    Object? rank = null,
    Object? score = null,
    Object? level = null,
    Object? isCurrentUser = null,
  }) {
    return _then(
      _$LeaderboardUserModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: null == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        rank: null == rank
            ? _value.rank
            : rank // ignore: cast_nullable_to_non_nullable
                  as int,
        score: null == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as int,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
        isCurrentUser: null == isCurrentUser
            ? _value.isCurrentUser
            : isCurrentUser // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaderboardUserModelImpl extends _LeaderboardUserModel {
  const _$LeaderboardUserModelImpl({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.rank,
    required this.score,
    required this.level,
    this.isCurrentUser = false,
  }) : super._();

  factory _$LeaderboardUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaderboardUserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String avatarUrl;
  @override
  final int rank;
  @override
  final int score;
  @override
  final int level;
  @override
  @JsonKey()
  final bool isCurrentUser;

  @override
  String toString() {
    return 'LeaderboardUserModel(id: $id, name: $name, avatarUrl: $avatarUrl, rank: $rank, score: $score, level: $level, isCurrentUser: $isCurrentUser)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaderboardUserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.isCurrentUser, isCurrentUser) ||
                other.isCurrentUser == isCurrentUser));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    avatarUrl,
    rank,
    score,
    level,
    isCurrentUser,
  );

  /// Create a copy of LeaderboardUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaderboardUserModelImplCopyWith<_$LeaderboardUserModelImpl>
  get copyWith =>
      __$$LeaderboardUserModelImplCopyWithImpl<_$LeaderboardUserModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaderboardUserModelImplToJson(this);
  }
}

abstract class _LeaderboardUserModel extends LeaderboardUserModel {
  const factory _LeaderboardUserModel({
    required final String id,
    required final String name,
    required final String avatarUrl,
    required final int rank,
    required final int score,
    required final int level,
    final bool isCurrentUser,
  }) = _$LeaderboardUserModelImpl;
  const _LeaderboardUserModel._() : super._();

  factory _LeaderboardUserModel.fromJson(Map<String, dynamic> json) =
      _$LeaderboardUserModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get avatarUrl;
  @override
  int get rank;
  @override
  int get score;
  @override
  int get level;
  @override
  bool get isCurrentUser;

  /// Create a copy of LeaderboardUserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaderboardUserModelImplCopyWith<_$LeaderboardUserModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
