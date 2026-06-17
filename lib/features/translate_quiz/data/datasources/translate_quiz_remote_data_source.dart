import 'package:dio/dio.dart';
import '../models/translation_task_model.dart';

abstract class TranslateQuizRemoteDataSource {
  Future<List<TranslationTaskModel>> getAvailableTranslationTasks();
  Future<TranslationTaskModel> getTranslationTaskDetails(String id);
  Future<void> submitTranslation(TranslationTaskModel task);
}

class TranslateQuizRemoteDataSourceImpl implements TranslateQuizRemoteDataSource {
  final Dio dio;

  TranslateQuizRemoteDataSourceImpl({required this.dio});

  // Mock data to match Figma exactly
  final List<TranslationTaskModel> _mockTasks = [
    const TranslationTaskModel(
      id: '1',
      title: 'English Quiz Translate',
      sourceLanguage: 'English',
      targetLanguage: 'Hindi',
      sourceBibleVersion: 'New King James Version',
      sourceTopicName: 'Kindness & Respectful Comm...',
      sourceBibleReference: 'Proverbs 1:10',
      sourceQuestion: 'If sinners entice you, do not consent.',
      translatedBibleVersion: 'नया किंग जेम्स संस्करण',
      translatedTopicName: 'दयालुता और सम्मानजनक व्यवहार...',
    ),
    const TranslationTaskModel(
      id: '2',
      title: 'Hindi Quiz Translate',
      sourceLanguage: 'Hindi',
      targetLanguage: 'English',
      sourceBibleVersion: 'Hindi Bible',
      sourceTopicName: 'Love & Faith',
      sourceBibleReference: 'John 3:16',
      sourceQuestion: 'For God so loved the world...',
    ),
    const TranslationTaskModel(
      id: '3',
      title: 'Marathi Quiz Translate',
      sourceLanguage: 'Marathi',
      targetLanguage: 'English',
      sourceBibleVersion: 'Marathi Bible',
      sourceTopicName: 'Hope & Peace',
      sourceBibleReference: 'Psalm 23:1',
      sourceQuestion: 'The Lord is my shepherd...',
    ),
  ];

  @override
  Future<List<TranslationTaskModel>> getAvailableTranslationTasks() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _mockTasks;
  }

  @override
  Future<TranslationTaskModel> getTranslationTaskDetails(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockTasks.firstWhere((t) => t.id == id, orElse: () => _mockTasks.first);
  }

  @override
  Future<void> submitTranslation(TranslationTaskModel task) async {
    // Mock API submission
    await Future.delayed(const Duration(seconds: 1));
  }
}
