import 'package:dio/dio.dart';
import '../models/bible_version_model.dart';
import '../../domain/entities/expertise_data.dart';

abstract class ExpertiseRemoteDataSource {
  Future<List<BibleVersionModel>> getBibleVersions();
  Future<void> saveExpertise(ExpertiseData data);
}

class ExpertiseRemoteDataSourceImpl implements ExpertiseRemoteDataSource {
  final Dio dio;

  ExpertiseRemoteDataSourceImpl(this.dio);

  @override
  Future<List<BibleVersionModel>> getBibleVersions() async {
    // Mocking API delay
    await Future.delayed(const Duration(seconds: 1));
    return const [
      BibleVersionModel(id: 1, name: 'New King James Version', code: 'NKJV'),
      BibleVersionModel(id: 2, name: 'King James Version', code: 'KJV'),
      BibleVersionModel(id: 3, name: 'New International Version', code: 'NIV'),
      BibleVersionModel(id: 4, name: 'English Standard Version', code: 'ESV'),
    ];
  }

  @override
  Future<void> saveExpertise(ExpertiseData data) async {
    // Mock saving via API
    await Future.delayed(const Duration(seconds: 1));
  }
}
