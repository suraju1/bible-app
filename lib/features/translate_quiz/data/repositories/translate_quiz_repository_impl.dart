import '../../domain/entities/translation_task.dart';
import '../../domain/repositories/translate_quiz_repository.dart';
import '../datasources/translate_quiz_remote_data_source.dart';
import '../models/translation_task_model.dart';

class TranslateQuizRepositoryImpl implements TranslateQuizRepository {
  final TranslateQuizRemoteDataSource remoteDataSource;

  TranslateQuizRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<TranslationTask>> getAvailableTranslationTasks() async {
    final models = await remoteDataSource.getAvailableTranslationTasks();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<TranslationTask> getTranslationTaskDetails(String id) async {
    final model = await remoteDataSource.getTranslationTaskDetails(id);
    return model.toEntity();
  }

  @override
  Future<void> submitTranslation(TranslationTask task) async {
    final model = TranslationTaskModelX.fromEntity(task);
    await remoteDataSource.submitTranslation(model);
  }
}
