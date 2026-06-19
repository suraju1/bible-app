import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../language_selection/data/models/language_model.dart';

class LanguageSettingsRepository {
  static const String _selectedLanguagesKey = 'selected_languages_v2';
  static const String _primaryLanguageKey = 'primary_language_v2';

  // Mocked API data
  final List<LanguageModel> _availableLanguages = [
    const LanguageModel(id: 1, name: 'English', nativeName: 'English', code: 'en'),
    const LanguageModel(id: 2, name: 'Marathi', nativeName: 'मराठी', code: 'mr'),
    const LanguageModel(id: 3, name: 'Hindi', nativeName: 'हिंदी', code: 'hi'),
    const LanguageModel(id: 4, name: 'Spanish', nativeName: 'Español', code: 'es'),
    const LanguageModel(id: 5, name: 'French', nativeName: 'Français', code: 'fr'),
  ];

  Future<List<LanguageModel>> getAvailableLanguages() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));
    return _availableLanguages;
  }

  Future<List<String>> getSelectedLanguageCodes() async {
    final prefs = await SharedPreferences.getInstance();
    final codes = prefs.getStringList(_selectedLanguagesKey);
    if (codes != null && codes.isNotEmpty) {
      return codes;
    }
    // Default to English if nothing selected
    return ['en'];
  }

  Future<String> getPrimaryLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    final primary = prefs.getString(_primaryLanguageKey);
    if (primary != null && primary.isNotEmpty) {
      return primary;
    }
    // Default to English
    return 'en';
  }

  Future<void> saveSelectedLanguages(List<String> languageCodes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_selectedLanguagesKey, languageCodes);
    // Simulate API sync
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<void> savePrimaryLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_primaryLanguageKey, languageCode);
    // Simulate API sync
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
