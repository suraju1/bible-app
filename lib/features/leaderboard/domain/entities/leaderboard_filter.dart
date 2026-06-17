import 'package:freezed_annotation/freezed_annotation.dart';

part 'leaderboard_filter.freezed.dart';

enum TimeframeFilter { daily, weekly, monthly }

@freezed
class LeaderboardFilter with _$LeaderboardFilter {
  const factory LeaderboardFilter({
    @Default(TimeframeFilter.weekly) TimeframeFilter timeframe,
    String? languageId,
    String? bibleVersionId,
  }) = _LeaderboardFilter;
}
