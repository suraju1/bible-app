import '../../domain/entities/correction_task.dart';
import '../../domain/repositories/correction_quiz_repository.dart';
import '../datasources/correction_quiz_remote_data_source.dart';
import '../models/correction_task_model.dart';

class CorrectionQuizRepositoryImpl implements CorrectionQuizRepository {
  final CorrectionQuizRemoteDataSource remoteDataSource;

  CorrectionQuizRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<CorrectionTask>> getAvailableCorrectionTasks() async {
    final models = await remoteDataSource.getAvailableCorrectionTasks();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<CorrectionTask> getCorrectionTaskDetails(String id) async {
    final model = await remoteDataSource.getCorrectionTaskDetails(id);
    return model.toEntity();
  }

  @override
  Future<void> submitCorrection(Map<String, dynamic> correctionData) async {
    await remoteDataSource.submitCorrection(correctionData);
  }
}
