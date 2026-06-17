// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DashboardDataModel _$DashboardDataModelFromJson(Map<String, dynamic> json) {
  return _DashboardDataModel.fromJson(json);
}

/// @nodoc
mixin _$DashboardDataModel {
  // ignore: invalid_annotation_target
  @JsonKey(name: 'user_name')
  String get userName => throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'user_avatar_url')
  String? get userAvatarUrl => throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'daily_streak')
  int get dailyStreak => throw _privateConstructorUsedError;
  int get rank => throw _privateConstructorUsedError;
  int get level =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'level_progress')
  double get levelProgress => throw _privateConstructorUsedError;
  int get points =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'today_challenge')
  ChallengeModel get todayChallenge => throw _privateConstructorUsedError;
  List<QuizCategoryModel> get categories =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'notification_badge_count')
  int get notificationBadgeCount => throw _privateConstructorUsedError;

  /// Serializes this DashboardDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardDataModelCopyWith<DashboardDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardDataModelCopyWith<$Res> {
  factory $DashboardDataModelCopyWith(
    DashboardDataModel value,
    $Res Function(DashboardDataModel) then,
  ) = _$DashboardDataModelCopyWithImpl<$Res, DashboardDataModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'user_name') String userName,
    @JsonKey(name: 'user_avatar_url') String? userAvatarUrl,
    @JsonKey(name: 'daily_streak') int dailyStreak,
    int rank,
    int level,
    @JsonKey(name: 'level_progress') double levelProgress,
    int points,
    @JsonKey(name: 'today_challenge') ChallengeModel todayChallenge,
    List<QuizCategoryModel> categories,
    @JsonKey(name: 'notification_badge_count') int notificationBadgeCount,
  });

  $ChallengeModelCopyWith<$Res> get todayChallenge;
}

/// @nodoc
class _$DashboardDataModelCopyWithImpl<$Res, $Val extends DashboardDataModel>
    implements $DashboardDataModelCopyWith<$Res> {
  _$DashboardDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? userAvatarUrl = freezed,
    Object? dailyStreak = null,
    Object? rank = null,
    Object? level = null,
    Object? levelProgress = null,
    Object? points = null,
    Object? todayChallenge = null,
    Object? categories = null,
    Object? notificationBadgeCount = null,
  }) {
    return _then(
      _value.copyWith(
            userName: null == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                      as String,
            userAvatarUrl: freezed == userAvatarUrl
                ? _value.userAvatarUrl
                : userAvatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            dailyStreak: null == dailyStreak
                ? _value.dailyStreak
                : dailyStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            rank: null == rank
                ? _value.rank
                : rank // ignore: cast_nullable_to_non_nullable
                      as int,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
            levelProgress: null == levelProgress
                ? _value.levelProgress
                : levelProgress // ignore: cast_nullable_to_non_nullable
                      as double,
            points: null == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as int,
            todayChallenge: null == todayChallenge
                ? _value.todayChallenge
                : todayChallenge // ignore: cast_nullable_to_non_nullable
                      as ChallengeModel,
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<QuizCategoryModel>,
            notificationBadgeCount: null == notificationBadgeCount
                ? _value.notificationBadgeCount
                : notificationBadgeCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of DashboardDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChallengeModelCopyWith<$Res> get todayChallenge {
    return $ChallengeModelCopyWith<$Res>(_value.todayChallenge, (value) {
      return _then(_value.copyWith(todayChallenge: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DashboardDataModelImplCopyWith<$Res>
    implements $DashboardDataModelCopyWith<$Res> {
  factory _$$DashboardDataModelImplCopyWith(
    _$DashboardDataModelImpl value,
    $Res Function(_$DashboardDataModelImpl) then,
  ) = __$$DashboardDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'user_name') String userName,
    @JsonKey(name: 'user_avatar_url') String? userAvatarUrl,
    @JsonKey(name: 'daily_streak') int dailyStreak,
    int rank,
    int level,
    @JsonKey(name: 'level_progress') double levelProgress,
    int points,
    @JsonKey(name: 'today_challenge') ChallengeModel todayChallenge,
    List<QuizCategoryModel> categories,
    @JsonKey(name: 'notification_badge_count') int notificationBadgeCount,
  });

  @override
  $ChallengeModelCopyWith<$Res> get todayChallenge;
}

/// @nodoc
class __$$DashboardDataModelImplCopyWithImpl<$Res>
    extends _$DashboardDataModelCopyWithImpl<$Res, _$DashboardDataModelImpl>
    implements _$$DashboardDataModelImplCopyWith<$Res> {
  __$$DashboardDataModelImplCopyWithImpl(
    _$DashboardDataModelImpl _value,
    $Res Function(_$DashboardDataModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? userAvatarUrl = freezed,
    Object? dailyStreak = null,
    Object? rank = null,
    Object? level = null,
    Object? levelProgress = null,
    Object? points = null,
    Object? todayChallenge = null,
    Object? categories = null,
    Object? notificationBadgeCount = null,
  }) {
    return _then(
      _$DashboardDataModelImpl(
        userName: null == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String,
        userAvatarUrl: freezed == userAvatarUrl
            ? _value.userAvatarUrl
            : userAvatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        dailyStreak: null == dailyStreak
            ? _value.dailyStreak
            : dailyStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        rank: null == rank
            ? _value.rank
            : rank // ignore: cast_nullable_to_non_nullable
                  as int,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
        levelProgress: null == levelProgress
            ? _value.levelProgress
            : levelProgress // ignore: cast_nullable_to_non_nullable
                  as double,
        points: null == points
            ? _value.points
            : points // ignore: cast_nullable_to_non_nullable
                  as int,
        todayChallenge: null == todayChallenge
            ? _value.todayChallenge
            : todayChallenge // ignore: cast_nullable_to_non_nullable
                  as ChallengeModel,
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<QuizCategoryModel>,
        notificationBadgeCount: null == notificationBadgeCount
            ? _value.notificationBadgeCount
            : notificationBadgeCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardDataModelImpl implements _DashboardDataModel {
  const _$DashboardDataModelImpl({
    @JsonKey(name: 'user_name') required this.userName,
    @JsonKey(name: 'user_avatar_url') this.userAvatarUrl,
    @JsonKey(name: 'daily_streak') required this.dailyStreak,
    required this.rank,
    required this.level,
    @JsonKey(name: 'level_progress') required this.levelProgress,
    required this.points,
    @JsonKey(name: 'today_challenge') required this.todayChallenge,
    required final List<QuizCategoryModel> categories,
    @JsonKey(name: 'notification_badge_count')
    required this.notificationBadgeCount,
  }) : _categories = categories;

  factory _$DashboardDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardDataModelImplFromJson(json);

  // ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'user_name')
  final String userName;
  // ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'user_avatar_url')
  final String? userAvatarUrl;
  // ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'daily_streak')
  final int dailyStreak;
  @override
  final int rank;
  @override
  final int level;
  // ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'level_progress')
  final double levelProgress;
  @override
  final int points;
  // ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'today_challenge')
  final ChallengeModel todayChallenge;
  final List<QuizCategoryModel> _categories;
  @override
  List<QuizCategoryModel> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  // ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'notification_badge_count')
  final int notificationBadgeCount;

  @override
  String toString() {
    return 'DashboardDataModel(userName: $userName, userAvatarUrl: $userAvatarUrl, dailyStreak: $dailyStreak, rank: $rank, level: $level, levelProgress: $levelProgress, points: $points, todayChallenge: $todayChallenge, categories: $categories, notificationBadgeCount: $notificationBadgeCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardDataModelImpl &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userAvatarUrl, userAvatarUrl) ||
                other.userAvatarUrl == userAvatarUrl) &&
            (identical(other.dailyStreak, dailyStreak) ||
                other.dailyStreak == dailyStreak) &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.levelProgress, levelProgress) ||
                other.levelProgress == levelProgress) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.todayChallenge, todayChallenge) ||
                other.todayChallenge == todayChallenge) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            (identical(other.notificationBadgeCount, notificationBadgeCount) ||
                other.notificationBadgeCount == notificationBadgeCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userName,
    userAvatarUrl,
    dailyStreak,
    rank,
    level,
    levelProgress,
    points,
    todayChallenge,
    const DeepCollectionEquality().hash(_categories),
    notificationBadgeCount,
  );

  /// Create a copy of DashboardDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardDataModelImplCopyWith<_$DashboardDataModelImpl> get copyWith =>
      __$$DashboardDataModelImplCopyWithImpl<_$DashboardDataModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardDataModelImplToJson(this);
  }
}

abstract class _DashboardDataModel implements DashboardDataModel {
  const factory _DashboardDataModel({
    @JsonKey(name: 'user_name') required final String userName,
    @JsonKey(name: 'user_avatar_url') final String? userAvatarUrl,
    @JsonKey(name: 'daily_streak') required final int dailyStreak,
    required final int rank,
    required final int level,
    @JsonKey(name: 'level_progress') required final double levelProgress,
    required final int points,
    @JsonKey(name: 'today_challenge')
    required final ChallengeModel todayChallenge,
    required final List<QuizCategoryModel> categories,
    @JsonKey(name: 'notification_badge_count')
    required final int notificationBadgeCount,
  }) = _$DashboardDataModelImpl;

  factory _DashboardDataModel.fromJson(Map<String, dynamic> json) =
      _$DashboardDataModelImpl.fromJson;

  // ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'user_name')
  String get userName; // ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'user_avatar_url')
  String? get userAvatarUrl; // ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'daily_streak')
  int get dailyStreak;
  @override
  int get rank;
  @override
  int get level; // ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'level_progress')
  double get levelProgress;
  @override
  int get points; // ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'today_challenge')
  ChallengeModel get todayChallenge;
  @override
  List<QuizCategoryModel> get categories; // ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'notification_badge_count')
  int get notificationBadgeCount;

  /// Create a copy of DashboardDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardDataModelImplCopyWith<_$DashboardDataModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
