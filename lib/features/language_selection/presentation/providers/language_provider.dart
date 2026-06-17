import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../splash/data/repositories/splash_repository_impl.dart';
import '../../domain/entities/language.dart';
import '../../domain/repositories/language_repository.dart';
import '../../data/datasources/language_local_data_source.dart';
import '../../data/datasources/language_remote_data_source.dart';
import '../../data/repositories/language_repository_impl.dart';

final languageRepositoryProvider = Provider<LanguageRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final sharedPrefs = ref.watch(sharedPreferencesProvider);

  return LanguageRepositoryImpl(
    remoteDataSource: LanguageRemoteDataSourceImpl(dio),
    localDataSource: LanguageLocalDataSourceImpl(sharedPrefs),
  );
});

final languageListProvider = FutureProvider<List<Language>>((ref) async {
  final repository = ref.watch(languageRepositoryProvider);
  return repository.getLanguages();
});

// Holds the list of selected languages
final selectedLanguagesProvider = StateProvider<List<Language>>((ref) => []);

// Holds the primary selected language
final primaryLanguageProvider = StateProvider<Language?>((ref) => null);

// Holds the selected skills for each language code
final languageSkillsProvider = StateProvider<Map<String, Set<String>>>((ref) => {});

// Handles the save action
final saveLanguageProvider = AsyncNotifierProvider.autoDispose<SaveLanguageNotifier, void>(SaveLanguageNotifier.new);

class SaveLanguageNotifier extends AutoDisposeAsyncNotifier<void> {
  @override
  void build() {}

  Future<void> save(Language primaryLanguage) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(languageRepositoryProvider);
      await repository.saveSelectedLanguage(primaryLanguage);
    });
  }
}
