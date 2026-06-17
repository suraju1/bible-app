import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../domain/entities/app_launch_status.dart';
import '../../domain/repositories/splash_repository.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider must be overridden in main.dart');
});

final splashRepositoryProvider = Provider<SplashRepository>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return SplashRepositoryImpl(
    secureStorageService: secureStorage,
    sharedPreferences: sharedPrefs,
  );
});

class SplashRepositoryImpl implements SplashRepository {
  final SecureStorageService secureStorageService;
  final SharedPreferences sharedPreferences;

  SplashRepositoryImpl({
    required this.secureStorageService,
    required this.sharedPreferences,
  });

  static const String _keyHasSelectedLanguage = 'has_selected_language';
  static const String _keyHasSelectedExpertise = 'has_selected_expertise';

  @override
  Future<AppLaunchStatus> getAppLaunchStatus() async {
    // Check local storage flags
    final hasSelectedLanguage = sharedPreferences.getBool(_keyHasSelectedLanguage) ?? false;
    final hasSelectedExpertise = sharedPreferences.getBool(_keyHasSelectedExpertise) ?? false;
    
    // Check token
    final token = await secureStorageService.getToken();
    final isLoggedIn = token != null && token.isNotEmpty;

    // Simulate small delay for splash screen visibility (optional, but good for UX)
    await Future.delayed(const Duration(seconds: 2));

    return AppLaunchStatus(
      hasSelectedLanguage: hasSelectedLanguage,
      hasSelectedExpertise: hasSelectedExpertise,
      isLoggedIn: isLoggedIn,
    );
  }
}
