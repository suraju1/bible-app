import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/help_support_model.dart';
import '../../data/services/faq_service.dart';

final faqControllerProvider = AsyncNotifierProvider.autoDispose<FaqController, List<FaqModel>>(FaqController.new);

class FaqController extends AutoDisposeAsyncNotifier<List<FaqModel>> {
  List<FaqModel> _allFaqs = [];

  @override
  Future<List<FaqModel>> build() async {
    return _fetchFaqs();
  }

  Future<List<FaqModel>> _fetchFaqs() async {
    final service = ref.read(faqServiceProvider);
    _allFaqs = await service.getFaqs();
    return _allFaqs;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchFaqs());
  }

  void search(String query) {
    if (query.isEmpty) {
      state = AsyncData(_allFaqs);
      return;
    }

    final lowercaseQuery = query.toLowerCase();
    final filteredFaqs = _allFaqs.where((faq) {
      return faq.question.toLowerCase().contains(lowercaseQuery) ||
             faq.answer.toLowerCase().contains(lowercaseQuery);
    }).toList();

    state = AsyncData(filteredFaqs);
  }
}
