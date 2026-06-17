import '../../domain/entities/bible_version.dart';
import '../../domain/entities/expertise_data.dart';
import '../../domain/repositories/expertise_repository.dart';
import '../datasources/expertise_local_data_source.dart';
import '../datasources/expertise_remote_data_source.dart';
import '../models/bible_version_model.dart';

class ExpertiseRepositoryImpl implements ExpertiseRepository {
  final ExpertiseRemoteDataSource remoteDataSource;
  final ExpertiseLocalDataSource localDataSource;

  ExpertiseRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<BibleVersion>> getBibleVersions() async {
    final models = await remoteDataSource.getBibleVersions();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> saveExpertise(ExpertiseData data) async {
    await remoteDataSource.saveExpertise(data);
    await localDataSource.saveExpertiseCompleted();
  }
}
