import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/report_issue_service.dart';

final reportIssueControllerProvider = AsyncNotifierProvider.autoDispose<ReportIssueController, void>(ReportIssueController.new);

class ReportIssueController extends AutoDisposeAsyncNotifier<void> {
  @override
  void build() {}

  Future<bool> submitIssue({
    required String category,
    required String description,
    required String deviceInfo,
    required String appVersion,
    File? screenshot,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(reportIssueServiceProvider);
      await service.submitIssue(
        category: category,
        description: description,
        deviceInfo: deviceInfo,
        appVersion: appVersion,
        screenshot: screenshot,
      );
    });
    return !state.hasError;
  }
}
