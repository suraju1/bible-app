import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';

final feedbackServiceProvider = Provider<FeedbackService>((ref) {
  final dio = ref.watch(dioProvider);
  return FeedbackService(dio);
});

class FeedbackService {
  final Dio _dio;

  FeedbackService(this._dio);

  Future<void> submitFeedback({
    required String category,
    required String description,
    File? screenshot,
  }) async {
    try {
      // Simulate network delay for API integration
      await Future.delayed(const Duration(seconds: 2));
      
      // In a real application, you would use FormData for file uploads
      /*
      final formData = FormData.fromMap({
        'category': category,
        'description': description,
        if (screenshot != null)
          'screenshot': await MultipartFile.fromFile(screenshot.path),
      });

      final response = await _dio.post(
        '/feedback',
        data: formData,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to submit feedback');
      }
      */
      
      // Simulating a successful API response
      return;
    } catch (e) {
      throw Exception('Failed to submit feedback: $e');
    }
  }
}
