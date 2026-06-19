import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/user_profile.dart';
import '../../data/repositories/profile_repository_impl.dart';

final profileProvider = FutureProvider.autoDispose<UserProfile>((ref) async {
  final repo = ref.read(profileRepositoryProvider);
  return repo.fetchUserProfile();
});
