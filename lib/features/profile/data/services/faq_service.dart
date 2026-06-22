import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/models/help_support_model.dart';

final faqServiceProvider = Provider<FaqService>((ref) {
  final dio = ref.watch(dioProvider);
  return FaqService(dio);
});

class FaqService {
  final Dio _dio;

  FaqService(this._dio);

  Future<List<FaqModel>> getFaqs() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      /*
      // In a real application, you would fetch from your API:
      final response = await _dio.get('/faqs');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['faqs'];
        return data.map((json) => FaqModel(
          id: json['id'],
          question: json['question'],
          answer: json['answer'],
        )).toList();
      } else {
        throw Exception('Failed to load FAQs');
      }
      */

      // Mock Data
      return [
        const FaqModel(
          id: '1',
          question: 'How do I change my primary language?',
          answer: 'Go to Profile -> Language Settings, tap on a language, and select "Primary".',
        ),
        const FaqModel(
          id: '2',
          question: 'Can I play offline?',
          answer: 'Currently, an active internet connection is required to fetch new quizzes and save your progress.',
        ),
        const FaqModel(
          id: '3',
          question: 'How do I earn points?',
          answer: 'You can earn points by completing quizzes, participating in battles, and inviting friends.',
        ),
        const FaqModel(
          id: '4',
          question: 'Is my data secure?',
          answer: 'Yes, we use industry standard encryption to protect your personal information and quiz data.',
        ),
        const FaqModel(
          id: '5',
          question: 'Can I suggest a new quiz topic?',
          answer: 'Absolutely! Please use the Feedback section to share your suggestions with us.',
        ),
      ];
    } catch (e) {
      throw Exception('Failed to fetch FAQs: $e');
    }
  }
}
