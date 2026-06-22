import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';

final reportIssueServiceProvider = Provider<ReportIssueService>((ref) {
  final dio = ref.watch(dioProvider);
  return ReportIssueService(dio);
});

class ReportIssueService {
  final Dio _dio;

  ReportIssueService(this._dio);

  Future<void> submitIssue({
    required String category,
    required String description,
    required String deviceInfo,
    required String appVersion,
    File? screenshot,
  }) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      /*
      // Real API Implementation
      final formData = FormData.fromMap({
        'category': category,
        'description': description,
        'device_info': deviceInfo,
        'app_version': appVersion,
        if (screenshot != null)
          'screenshot': await MultipartFile.fromFile(screenshot.path),
      });

      final response = await _dio.post(
        '/issues/report',
        data: formData,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to submit issue report');
      }
      */
      
      // Simulating success
      return;
    } catch (e) {
      throw Exception('Failed to submit issue: $e');
    }
  }
}
