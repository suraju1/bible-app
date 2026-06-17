import 'package:dio/dio.dart';
import '../models/language_model.dart';

abstract class LanguageRemoteDataSource {
  Future<List<LanguageModel>> getLanguages();
}

class LanguageRemoteDataSourceImpl implements LanguageRemoteDataSource {
  final Dio dio;

  LanguageRemoteDataSourceImpl(this.dio);

  @override
  Future<List<LanguageModel>> getLanguages() async {
    try {
      // Real API call (commented out until backend is fully hooked up)
      // final response = await dio.get('/languages');
      // return (response.data as List).map((json) => LanguageModel.fromJson(json)).toList();

      // Mock Data for UI testing as per Figma
      await Future.delayed(const Duration(seconds: 1));
      return const [
        LanguageModel(id: 1, name: 'English (UK)', nativeName: 'English (UK)', code: 'en'),
        LanguageModel(id: 2, name: 'Tamil', nativeName: 'தமிழ்', code: 'ta'),
        LanguageModel(id: 3, name: 'Telugu', nativeName: 'తెలుగు', code: 'te'),
        LanguageModel(id: 4, name: 'Hindi', nativeName: 'हिंदी', code: 'hi'),
        LanguageModel(id: 5, name: 'Marathi', nativeName: 'मराठी', code: 'mr'),
      ];
    } catch (e) {
      throw Exception('Failed to fetch languages');
    }
  }
}
