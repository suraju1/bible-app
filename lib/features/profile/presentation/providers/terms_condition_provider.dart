import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/terms_condition_repository.dart';
import '../../domain/models/terms_condition_model.dart';

final termsConditionRepositoryProvider = Provider<TermsConditionRepository>((ref) {
  return TermsConditionRepository();
});

final termsConditionProvider = FutureProvider<List<TermsSectionModel>>((ref) async {
  final repo = ref.read(termsConditionRepositoryProvider);
  return repo.getTermsAndConditions();
});
