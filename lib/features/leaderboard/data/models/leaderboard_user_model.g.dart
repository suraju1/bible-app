// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaderboardUserModelImpl _$$LeaderboardUserModelImplFromJson(
  Map<String, dynamic> json,
) => _$LeaderboardUserModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  avatarUrl: json['avatarUrl'] as String,
  rank: (json['rank'] as num).toInt(),
  score: (json['score'] as num).toInt(),
  level: (json['level'] as num).toInt(),
  isCurrentUser: json['isCurrentUser'] as bool? ?? false,
);

Map<String, dynamic> _$$LeaderboardUserModelImplToJson(
  _$LeaderboardUserModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'avatarUrl': instance.avatarUrl,
  'rank': instance.rank,
  'score': instance.score,
  'level': instance.level,
  'isCurrentUser': instance.isCurrentUser,
};
