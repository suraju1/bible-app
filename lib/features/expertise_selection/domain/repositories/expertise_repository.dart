import '../entities/bible_version.dart';
import '../entities/expertise_data.dart';

abstract class ExpertiseRepository {
  Future<List<BibleVersion>> getBibleVersions();
  Future<void> saveExpertise(ExpertiseData data);
}
