import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/translation_task.dart';
import '../../domain/repositories/translate_quiz_repository.dart';
import '../../data/datasources/translate_quiz_remote_data_source.dart';
import '../../data/repositories/translate_quiz_repository_impl.dart';

// Dependency Injection
final translateQuizDioProvider = Provider<Dio>((ref) => ref.watch(dioProvider));

final translateQuizRemoteDataSourceProvider = Provider<TranslateQuizRemoteDataSource>((ref) {
  return TranslateQuizRemoteDataSourceImpl(dio: ref.watch(translateQuizDioProvider));
});

final translateQuizRepositoryProvider = Provider<TranslateQuizRepository>((ref) {
  return TranslateQuizRepositoryImpl(remoteDataSource: ref.watch(translateQuizRemoteDataSourceProvider));
});

// State classes
class TranslationTaskListState {
  final AsyncValue<List<TranslationTask>> tasks;
  TranslationTaskListState({this.tasks = const AsyncValue.loading()});

  TranslationTaskListState copyWith({AsyncValue<List<TranslationTask>>? tasks}) {
    return TranslationTaskListState(tasks: tasks ?? this.tasks);
  }
}

class TranslationTaskListNotifier extends StateNotifier<TranslationTaskListState> {
  final TranslateQuizRepository repository;

  TranslationTaskListNotifier(this.repository) : super(TranslationTaskListState()) {
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    state = state.copyWith(tasks: const AsyncValue.loading());
    try {
      final items = await repository.getAvailableTranslationTasks();
      state = state.copyWith(tasks: AsyncValue.data(items));
    } catch (e, stack) {
      state = state.copyWith(tasks: AsyncValue.error(e, stack));
    }
  }
}

final translationTaskListProvider = StateNotifierProvider<TranslationTaskListNotifier, TranslationTaskListState>((ref) {
  return TranslationTaskListNotifier(ref.watch(translateQuizRepositoryProvider));
});

// Task Details Provider
final translationTaskDetailsProvider = FutureProvider.family<TranslationTask, String>((ref, id) {
  final repo = ref.watch(translateQuizRepositoryProvider);
  return repo.getTranslationTaskDetails(id);
});
