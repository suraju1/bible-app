import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/help_support_repository.dart';
import '../../domain/models/help_support_model.dart';

final helpSupportRepositoryProvider = Provider<HelpSupportRepository>((ref) {
  return HelpSupportRepository();
});

final faqsProvider = FutureProvider<List<FaqModel>>((ref) async {
  final repo = ref.read(helpSupportRepositoryProvider);
  return repo.getFaqs();
});

final helpArticlesProvider = FutureProvider<List<HelpArticleModel>>((ref) async {
  final repo = ref.read(helpSupportRepositoryProvider);
  return repo.getHelpArticles();
});
