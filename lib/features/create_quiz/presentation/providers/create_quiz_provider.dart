import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/create_quiz_request.dart';
import '../../../play_quiz/data/repositories/quiz_repository_impl.dart';

class CreateQuizState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final bool sameReferenceChecked;

  const CreateQuizState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.sameReferenceChecked = true,
  });

  CreateQuizState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    bool? sameReferenceChecked,
  }) {
    return CreateQuizState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
      sameReferenceChecked: sameReferenceChecked ?? this.sameReferenceChecked,
    );
  }
}

class CreateQuizController extends StateNotifier<CreateQuizState> {
  final Ref ref;

  CreateQuizController(this.ref) : super(const CreateQuizState());

  void toggleSameReference(bool value) {
    state = state.copyWith(sameReferenceChecked: value);
  }

  Future<void> submitQuiz(CreateQuizRequest request) async {
    state = state.copyWith(isLoading: true, errorMessage: null, isSuccess: false);
    
    try {
      final repo = ref.read(quizRepositoryProvider);
      await repo.submitCreatedQuiz(request);
      
      if (mounted) {
        state = state.copyWith(isLoading: false, isSuccess: true);
      }
    } catch (e) {
      if (mounted) {
        state = state.copyWith(isLoading: false, errorMessage: e.toString());
      }
    }
  }
}

final createQuizControllerProvider =
    StateNotifierProvider.autoDispose<CreateQuizController, CreateQuizState>((ref) {
  return CreateQuizController(ref);
});
