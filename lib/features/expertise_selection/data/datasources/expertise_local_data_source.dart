import 'package:shared_preferences/shared_preferences.dart';

abstract class ExpertiseLocalDataSource {
  Future<void> saveExpertiseCompleted();
}

class ExpertiseLocalDataSourceImpl implements ExpertiseLocalDataSource {
  final SharedPreferences sharedPreferences;

  ExpertiseLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> saveExpertiseCompleted() async {
    await sharedPreferences.setBool('has_selected_expertise', true);
  }
}
