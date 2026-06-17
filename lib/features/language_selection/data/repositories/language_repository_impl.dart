import '../../domain/entities/language.dart';
import '../../domain/repositories/language_repository.dart';
import '../datasources/language_local_data_source.dart';
import '../datasources/language_remote_data_source.dart';
import '../models/language_model.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  final LanguageRemoteDataSource remoteDataSource;
  final LanguageLocalDataSource localDataSource;

  LanguageRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Language>> getLanguages() async {
    final models = await remoteDataSource.getLanguages();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> saveSelectedLanguage(Language language) async {
    await localDataSource.saveSelectedLanguage(language.code);
  }
}
