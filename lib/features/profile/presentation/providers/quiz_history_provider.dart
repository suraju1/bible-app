import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/quiz_history_model.dart';
import '../../data/repositories/quiz_history_repository.dart';

final quizHistoryRepositoryProvider = Provider<QuizHistoryRepository>((ref) {
  return QuizHistoryRepository();
});

final quizHistoryFilterProvider = StateProvider<String>((ref) => 'all'); // 'all', 'individual', 'grouped'

final quizHistoryListProvider = FutureProvider.autoDispose<List<QuizHistoryItem>>((ref) async {
  final filter = ref.watch(quizHistoryFilterProvider);
  final repo = ref.watch(quizHistoryRepositoryProvider);
  return repo.fetchQuizHistory(filter);
});

final quizHistoryDetailsProvider = FutureProvider.autoDispose.family<QuizHistoryItem, String>((ref, id) async {
  final repo = ref.watch(quizHistoryRepositoryProvider);
  return repo.fetchQuizDetails(id);
});
