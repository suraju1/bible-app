// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leaderboard_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$LeaderboardFilter {
  TimeframeFilter get timeframe => throw _privateConstructorUsedError;
  String? get languageId => throw _privateConstructorUsedError;
  String? get bibleVersionId => throw _privateConstructorUsedError;

  /// Create a copy of LeaderboardFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaderboardFilterCopyWith<LeaderboardFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderboardFilterCopyWith<$Res> {
  factory $LeaderboardFilterCopyWith(
    LeaderboardFilter value,
    $Res Function(LeaderboardFilter) then,
  ) = _$LeaderboardFilterCopyWithImpl<$Res, LeaderboardFilter>;
  @useResult
  $Res call({
    TimeframeFilter timeframe,
    String? languageId,
    String? bibleVersionId,
  });
}

/// @nodoc
class _$LeaderboardFilterCopyWithImpl<$Res, $Val extends LeaderboardFilter>
    implements $LeaderboardFilterCopyWith<$Res> {
  _$LeaderboardFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaderboardFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeframe = null,
    Object? languageId = freezed,
    Object? bibleVersionId = freezed,
  }) {
    return _then(
      _value.copyWith(
            timeframe: null == timeframe
                ? _value.timeframe
                : timeframe // ignore: cast_nullable_to_non_nullable
                      as TimeframeFilter,
            languageId: freezed == languageId
                ? _value.languageId
                : languageId // ignore: cast_nullable_to_non_nullable
                      as String?,
            bibleVersionId: freezed == bibleVersionId
                ? _value.bibleVersionId
                : bibleVersionId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LeaderboardFilterImplCopyWith<$Res>
    implements $LeaderboardFilterCopyWith<$Res> {
  factory _$$LeaderboardFilterImplCopyWith(
    _$LeaderboardFilterImpl value,
    $Res Function(_$LeaderboardFilterImpl) then,
  ) = __$$LeaderboardFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    TimeframeFilter timeframe,
    String? languageId,
    String? bibleVersionId,
  });
}

/// @nodoc
class __$$LeaderboardFilterImplCopyWithImpl<$Res>
    extends _$LeaderboardFilterCopyWithImpl<$Res, _$LeaderboardFilterImpl>
    implements _$$LeaderboardFilterImplCopyWith<$Res> {
  __$$LeaderboardFilterImplCopyWithImpl(
    _$LeaderboardFilterImpl _value,
    $Res Function(_$LeaderboardFilterImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LeaderboardFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeframe = null,
    Object? languageId = freezed,
    Object? bibleVersionId = freezed,
  }) {
    return _then(
      _$LeaderboardFilterImpl(
        timeframe: null == timeframe
            ? _value.timeframe
            : timeframe // ignore: cast_nullable_to_non_nullable
                  as TimeframeFilter,
        languageId: freezed == languageId
            ? _value.languageId
            : languageId // ignore: cast_nullable_to_non_nullable
                  as String?,
        bibleVersionId: freezed == bibleVersionId
            ? _value.bibleVersionId
            : bibleVersionId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$LeaderboardFilterImpl implements _LeaderboardFilter {
  const _$LeaderboardFilterImpl({
    this.timeframe = TimeframeFilter.weekly,
    this.languageId,
    this.bibleVersionId,
  });

  @override
  @JsonKey()
  final TimeframeFilter timeframe;
  @override
  final String? languageId;
  @override
  final String? bibleVersionId;

  @override
  String toString() {
    return 'LeaderboardFilter(timeframe: $timeframe, languageId: $languageId, bibleVersionId: $bibleVersionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaderboardFilterImpl &&
            (identical(other.timeframe, timeframe) ||
                other.timeframe == timeframe) &&
            (identical(other.languageId, languageId) ||
                other.languageId == languageId) &&
            (identical(other.bibleVersionId, bibleVersionId) ||
                other.bibleVersionId == bibleVersionId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, timeframe, languageId, bibleVersionId);

  /// Create a copy of LeaderboardFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaderboardFilterImplCopyWith<_$LeaderboardFilterImpl> get copyWith =>
      __$$LeaderboardFilterImplCopyWithImpl<_$LeaderboardFilterImpl>(
        this,
        _$identity,
      );
}

abstract class _LeaderboardFilter implements LeaderboardFilter {
  const factory _LeaderboardFilter({
    final TimeframeFilter timeframe,
    final String? languageId,
    final String? bibleVersionId,
  }) = _$LeaderboardFilterImpl;

  @override
  TimeframeFilter get timeframe;
  @override
  String? get languageId;
  @override
  String? get bibleVersionId;

  /// Create a copy of LeaderboardFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaderboardFilterImplCopyWith<_$LeaderboardFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
