import 'package:dio/dio.dart';
import '../models/correction_task_model.dart';

abstract class CorrectionQuizRemoteDataSource {
  Future<List<CorrectionTaskModel>> getAvailableCorrectionTasks();
  Future<CorrectionTaskModel> getCorrectionTaskDetails(String id);
  Future<void> submitCorrection(Map<String, dynamic> correctionData);
}

class CorrectionQuizRemoteDataSourceImpl implements CorrectionQuizRemoteDataSource {
  final Dio dio;

  CorrectionQuizRemoteDataSourceImpl({required this.dio});

  // Mock data to match Figma exactly
  final List<CorrectionTaskModel> _mockTasks = [
    const CorrectionTaskModel(
      id: '1',
      title: 'English Quiz Correction',
      userName: 'Caroline Hugo',
      userAvatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=150&q=80',
      feedbackQuestion: 'My friends did you try amazing food at a party. What would you do?',
      feedbackComment: 'Spelling mistakes',
      currentBibleVersion: 'Bible',
      currentTopicName: 'Kindness & Respectful Comm...',
      currentBibleReference: 'Proverbs 1:10',
      currentBibleVerse: 'If sinners entice you, do not consent.',
      currentQuestion: 'My friends did you try amazing food at a party. What would you do?',
      currentOptions: 'A. Eat it all\nB. Share it\nC. Throw it',
      currentExplanation: 'Sharing is caring according to Proverbs.',
    ),
    const CorrectionTaskModel(
      id: '2',
      title: 'Hindi Quiz Correction',
      userName: 'Amit Kumar',
      userAvatarUrl: 'https://images.unsplash.com/photo-1599566150163-29194dcaad36?auto=format&fit=crop&w=150&q=80',
      feedbackQuestion: 'What is the most important commandment?',
      feedbackComment: 'Incorrect translation of love.',
      currentBibleVersion: 'Hindi Bible',
      currentTopicName: 'Love & Faith',
      currentBibleReference: 'Mark 12:31',
      currentBibleVerse: 'Love your neighbor as yourself.',
      currentQuestion: 'सबसे महत्वपूर्ण आज्ञा क्या है?',
      currentOptions: 'A. Love\nB. Peace',
      currentExplanation: 'Jesus said to love your neighbor.',
    ),
    const CorrectionTaskModel(
      id: '3',
      title: 'Marathi Quiz Correction',
      userName: 'Priya Joshi',
      userAvatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=150&q=80',
      feedbackQuestion: 'How many days did it take to create the world?',
      feedbackComment: 'Wrong options provided.',
      currentBibleVersion: 'Marathi Bible',
      currentTopicName: 'Creation',
      currentBibleReference: 'Genesis 1:1',
      currentBibleVerse: 'In the beginning God created the heavens and the earth.',
      currentQuestion: 'जग निर्माण करण्यासाठी किती दिवस लागले?',
      currentOptions: 'A. 5\nB. 6\nC. 7',
      currentExplanation: 'God rested on the 7th day.',
    ),
  ];

  @override
  Future<List<CorrectionTaskModel>> getAvailableCorrectionTasks() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _mockTasks;
  }

  @override
  Future<CorrectionTaskModel> getCorrectionTaskDetails(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockTasks.firstWhere((t) => t.id == id, orElse: () => _mockTasks.first);
  }

  @override
  Future<void> submitCorrection(Map<String, dynamic> correctionData) async {
    // Mock API submission
    await Future.delayed(const Duration(seconds: 1));
  }
}
