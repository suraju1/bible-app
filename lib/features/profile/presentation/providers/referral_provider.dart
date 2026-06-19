import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/referral_model.dart';
import '../../data/repositories/referral_repository.dart';

final referralRepositoryProvider = Provider<ReferralRepository>((ref) {
  return ReferralRepository();
});

final referralFilterProvider = StateProvider<String>((ref) => 'pending'); // 'all', 'pending', 'completed'

final referralDataProvider = FutureProvider.autoDispose<ReferralDataModel>((ref) async {
  final filter = ref.watch(referralFilterProvider);
  final repo = ref.watch(referralRepositoryProvider);
  return repo.fetchReferralData(filter);
});
