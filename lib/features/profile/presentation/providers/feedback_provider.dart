import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/feedback_service.dart';

final feedbackControllerProvider = AsyncNotifierProvider.autoDispose<FeedbackController, void>(FeedbackController.new);

class FeedbackController extends AutoDisposeAsyncNotifier<void> {
  @override
  void build() {}

  Future<bool> submitFeedback({
    required String category,
    required String description,
    File? screenshot,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(feedbackServiceProvider);
      await service.submitFeedback(
        category: category,
        description: description,
        screenshot: screenshot,
      );
    });
    return !state.hasError;
  }
}
