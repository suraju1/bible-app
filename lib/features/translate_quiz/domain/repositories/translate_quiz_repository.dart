import '../entities/translation_task.dart';

abstract class TranslateQuizRepository {
  Future<List<TranslationTask>> getAvailableTranslationTasks();
  Future<TranslationTask> getTranslationTaskDetails(String id);
  Future<void> submitTranslation(TranslationTask task);
}
