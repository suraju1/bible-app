import 'package:shared_preferences/shared_preferences.dart';

abstract class LanguageLocalDataSource {
  Future<void> saveSelectedLanguage(String code);
}

class LanguageLocalDataSourceImpl implements LanguageLocalDataSource {
  final SharedPreferences sharedPreferences;

  LanguageLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> saveSelectedLanguage(String code) async {
    await sharedPreferences.setBool('has_selected_language', true);
    await sharedPreferences.setString('selected_language_code', code);
  }
}
