import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../language_selection/data/models/language_model.dart';
import '../../data/repositories/language_settings_repository.dart';

class LanguageSettingsState {
  final List<LanguageModel> availableLanguages;
  final List<LanguageModel> selectedLanguages;
  final String primaryLanguageCode;
  final String searchQuery;
  final bool isLoading;
  final String? error;

  LanguageSettingsState({
    this.availableLanguages = const [],
    this.selectedLanguages = const [],
    this.primaryLanguageCode = 'en',
    this.searchQuery = '',
    this.isLoading = true,
    this.error,
  });

  LanguageSettingsState copyWith({
    List<LanguageModel>? availableLanguages,
    List<LanguageModel>? selectedLanguages,
    String? primaryLanguageCode,
    String? searchQuery,
    bool? isLoading,
    String? error,
  }) {
    return LanguageSettingsState(
      availableLanguages: availableLanguages ?? this.availableLanguages,
      selectedLanguages: selectedLanguages ?? this.selectedLanguages,
      primaryLanguageCode: primaryLanguageCode ?? this.primaryLanguageCode,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  List<LanguageModel> get searchResults {
    if (searchQuery.trim().isEmpty) return [];
    final query = searchQuery.toLowerCase().trim();
    return availableLanguages.where((lang) {
      final isAlreadySelected = selectedLanguages.any((s) => s.code == lang.code);
      if (isAlreadySelected) return false;
      return lang.name.toLowerCase().contains(query) || lang.nativeName.toLowerCase().contains(query);
    }).toList();
  }
}

final languageSettingsRepositoryProvider = Provider((ref) => LanguageSettingsRepository());

final languageSettingsProvider = StateNotifierProvider<LanguageSettingsNotifier, LanguageSettingsState>((ref) {
  return LanguageSettingsNotifier(ref.read(languageSettingsRepositoryProvider));
});

class LanguageSettingsNotifier extends StateNotifier<LanguageSettingsState> {
  final LanguageSettingsRepository _repository;

  LanguageSettingsNotifier(this._repository) : super(LanguageSettingsState()) {
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      
      final available = await _repository.getAvailableLanguages();
      final selectedCodes = await _repository.getSelectedLanguageCodes();
      final primaryCode = await _repository.getPrimaryLanguageCode();
      
      final selectedLangs = available.where((l) => selectedCodes.contains(l.code)).toList();

      state = state.copyWith(
        availableLanguages: available,
        selectedLanguages: selectedLangs,
        primaryLanguageCode: primaryCode,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  Future<void> addLanguage(LanguageModel language) async {
    if (state.selectedLanguages.any((l) => l.code == language.code)) return;

    final updatedList = List<LanguageModel>.from(state.selectedLanguages)..add(language);
    String primary = state.primaryLanguageCode;
    
    // If it's the first language being added, make it primary
    if (updatedList.length == 1) {
      primary = language.code;
    }

    state = state.copyWith(
      selectedLanguages: updatedList,
      primaryLanguageCode: primary,
      searchQuery: '', // clear search after adding
    );

    await _repository.saveSelectedLanguages(updatedList.map((e) => e.code).toList());
    if (primary != state.primaryLanguageCode) {
      await _repository.savePrimaryLanguage(primary);
    }
  }

  Future<void> setPrimaryLanguage(String languageCode) async {
    if (state.primaryLanguageCode == languageCode) return;
    
    state = state.copyWith(primaryLanguageCode: languageCode);
    await _repository.savePrimaryLanguage(languageCode);
  }

  Future<void> removeLanguage(String languageCode) async {
    // Prevent removing if it's the only language selected
    if (state.selectedLanguages.length <= 1) {
      return; 
    }

    final updatedList = state.selectedLanguages.where((l) => l.code != languageCode).toList();
    String primary = state.primaryLanguageCode;

    // If the removed language was primary, automatically assign another one
    if (primary == languageCode && updatedList.isNotEmpty) {
      primary = updatedList.first.code;
    }

    state = state.copyWith(
      selectedLanguages: updatedList,
      primaryLanguageCode: primary,
    );

    await _repository.saveSelectedLanguages(updatedList.map((e) => e.code).toList());
    if (primary != state.primaryLanguageCode) {
      await _repository.savePrimaryLanguage(primary);
    }
  }

  Future<void> removeAllNonPrimary() async {
    final primaryLang = state.selectedLanguages.firstWhere(
      (l) => l.code == state.primaryLanguageCode,
      orElse: () => state.selectedLanguages.first,
    );
    
    final updatedList = [primaryLang];
    
    state = state.copyWith(
      selectedLanguages: updatedList,
    );
    
    await _repository.saveSelectedLanguages(updatedList.map((e) => e.code).toList());
  }
}
