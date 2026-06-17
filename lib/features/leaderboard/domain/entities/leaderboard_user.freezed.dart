// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leaderboard_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$LeaderboardUser {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get avatarUrl => throw _privateConstructorUsedError;
  int get rank => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  bool get isCurrentUser => throw _privateConstructorUsedError;

  /// Create a copy of LeaderboardUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaderboardUserCopyWith<LeaderboardUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderboardUserCopyWith<$Res> {
  factory $LeaderboardUserCopyWith(
    LeaderboardUser value,
    $Res Function(LeaderboardUser) then,
  ) = _$LeaderboardUserCopyWithImpl<$Res, LeaderboardUser>;
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
class _$LeaderboardUserCopyWithImpl<$Res, $Val extends LeaderboardUser>
    implements $LeaderboardUserCopyWith<$Res> {
  _$LeaderboardUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaderboardUser
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
abstract class _$$LeaderboardUserImplCopyWith<$Res>
    implements $LeaderboardUserCopyWith<$Res> {
  factory _$$LeaderboardUserImplCopyWith(
    _$LeaderboardUserImpl value,
    $Res Function(_$LeaderboardUserImpl) then,
  ) = __$$LeaderboardUserImplCopyWithImpl<$Res>;
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
class __$$LeaderboardUserImplCopyWithImpl<$Res>
    extends _$LeaderboardUserCopyWithImpl<$Res, _$LeaderboardUserImpl>
    implements _$$LeaderboardUserImplCopyWith<$Res> {
  __$$LeaderboardUserImplCopyWithImpl(
    _$LeaderboardUserImpl _value,
    $Res Function(_$LeaderboardUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LeaderboardUser
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
      _$LeaderboardUserImpl(
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

class _$LeaderboardUserImpl implements _LeaderboardUser {
  const _$LeaderboardUserImpl({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.rank,
    required this.score,
    required this.level,
    this.isCurrentUser = false,
  });

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
    return 'LeaderboardUser(id: $id, name: $name, avatarUrl: $avatarUrl, rank: $rank, score: $score, level: $level, isCurrentUser: $isCurrentUser)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaderboardUserImpl &&
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

  /// Create a copy of LeaderboardUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaderboardUserImplCopyWith<_$LeaderboardUserImpl> get copyWith =>
      __$$LeaderboardUserImplCopyWithImpl<_$LeaderboardUserImpl>(
        this,
        _$identity,
      );
}

abstract class _LeaderboardUser implements LeaderboardUser {
  const factory _LeaderboardUser({
    required final String id,
    required final String name,
    required final String avatarUrl,
    required final int rank,
    required final int score,
    required final int level,
    final bool isCurrentUser,
  }) = _$LeaderboardUserImpl;

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

  /// Create a copy of LeaderboardUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaderboardUserImplCopyWith<_$LeaderboardUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
