import '../entities/correction_task.dart';

abstract class CorrectionQuizRepository {
  Future<List<CorrectionTask>> getAvailableCorrectionTasks();
  Future<CorrectionTask> getCorrectionTaskDetails(String id);
  Future<void> submitCorrection(Map<String, dynamic> correctionData);
}
