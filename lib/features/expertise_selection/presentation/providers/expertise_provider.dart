import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../splash/data/repositories/splash_repository_impl.dart';
import '../../../language_selection/domain/entities/language.dart';
import '../../../language_selection/presentation/providers/language_provider.dart';
import '../../domain/entities/bible_version.dart';
import '../../domain/entities/expertise_data.dart';
import '../../domain/repositories/expertise_repository.dart';
import '../../data/datasources/expertise_local_data_source.dart';
import '../../data/datasources/expertise_remote_data_source.dart';
import '../../data/repositories/expertise_repository_impl.dart';

final expertiseRepositoryProvider = Provider<ExpertiseRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final sharedPrefs = ref.watch(sharedPreferencesProvider);

  return ExpertiseRepositoryImpl(
    remoteDataSource: ExpertiseRemoteDataSourceImpl(dio),
    localDataSource: ExpertiseLocalDataSourceImpl(sharedPrefs),
  );
});

final bibleVersionsListProvider = FutureProvider<List<BibleVersion>>((ref) async {
  final repository = ref.watch(expertiseRepositoryProvider);
  return repository.getBibleVersions();
});

// State for dynamically added Language selections
final expertiseLanguagesProvider = StateProvider<List<Language?>>((ref) {
  // Pre-fill with the primaryLanguage from previous screen if available
  final primaryLanguage = ref.read(primaryLanguageProvider);
  return [primaryLanguage];
});

// State for dynamically added Version selections
final expertiseVersionsProvider = StateProvider<List<BibleVersion?>>((ref) => [null]);

// State for Education
final expertiseEducationProvider = StateProvider<String>((ref) => '');

// State for Age
final expertiseAgeProvider = StateProvider<String>((ref) => '');

// Save action
final saveExpertiseProvider = AsyncNotifierProvider.autoDispose<SaveExpertiseNotifier, void>(SaveExpertiseNotifier.new);

class SaveExpertiseNotifier extends AutoDisposeAsyncNotifier<void> {
  @override
  void build() {}

  Future<bool> save() async {
    final languages = ref.read(expertiseLanguagesProvider).whereType<Language>().toList();
    final versions = ref.read(expertiseVersionsProvider).whereType<BibleVersion>().toList();
    final education = ref.read(expertiseEducationProvider);
    final ageStr = ref.read(expertiseAgeProvider);
    final age = int.tryParse(ageStr) ?? 0;

    // Validation
    if (languages.isEmpty || versions.isEmpty || education.trim().isEmpty || age <= 0) {
      state = AsyncError('Please complete all fields with valid information.', StackTrace.current);
      return false;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(expertiseRepositoryProvider);
      final data = ExpertiseData(
        preferredLanguages: languages,
        preferredVersions: versions,
        education: education.trim(),
        age: age,
      );
      await repository.saveExpertise(data);
    });

    return !state.hasError;
  }
}
