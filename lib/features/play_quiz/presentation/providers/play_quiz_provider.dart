import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/quiz_question.dart';
import '../../domain/models/quiz_result.dart';
import '../../data/repositories/quiz_repository_impl.dart';

// Assume a user provider exists, but for now we'll mock coin balance
final userCoinsProvider = StateProvider<int>((ref) => 100);

class PlayQuizState {
  final bool isLoading;
  final List<QuizQuestion> questions;
  final int currentIndex;
  final int score;
  final int remainingSeconds;
  final int totalTimeTaken;
  final String? selectedOptionId;
  final bool isCompleted;
  final QuizResult? result;
  final bool timesUp;
  final bool optionLocked;

  const PlayQuizState({
    this.isLoading = true,
    this.questions = const [],
    this.currentIndex = 0,
    this.score = 0,
    this.remainingSeconds = 10,
    this.totalTimeTaken = 0,
    this.selectedOptionId,
    this.isCompleted = false,
    this.result,
    this.timesUp = false,
    this.optionLocked = false,
  });

  PlayQuizState copyWith({
    bool? isLoading,
    List<QuizQuestion>? questions,
    int? currentIndex,
    int? score,
    int? remainingSeconds,
    int? totalTimeTaken,
    String? selectedOptionId,
    bool? isCompleted,
    QuizResult? result,
    bool? timesUp,
    bool? optionLocked,
  }) {
    return PlayQuizState(
      isLoading: isLoading ?? this.isLoading,
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      score: score ?? this.score,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      totalTimeTaken: totalTimeTaken ?? this.totalTimeTaken,
      selectedOptionId: selectedOptionId ?? this.selectedOptionId,
      isCompleted: isCompleted ?? this.isCompleted,
      result: result ?? this.result,
      timesUp: timesUp ?? this.timesUp,
      optionLocked: optionLocked ?? this.optionLocked,
    );
  }
}

class PlayQuizController extends StateNotifier<PlayQuizState> {
  final Ref ref;
  Timer? _timer;

  PlayQuizController(this.ref) : super(const PlayQuizState()) {
    _init();
  }

  Future<void> _init() async {
    final repo = ref.read(quizRepositoryProvider);
    final questions = await repo.fetchQuestions();
    if (!mounted) return;
    state = state.copyWith(
      isLoading: false,
      questions: questions,
      remainingSeconds: 10, // 10 seconds per question based on design "00.10"
    );
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (state.remainingSeconds > 0) {
        state = state.copyWith(
          remainingSeconds: state.remainingSeconds - 1,
          totalTimeTaken: state.totalTimeTaken + 1,
        );
      } else {
        _timer?.cancel();
        // Time's up
        state = state.copyWith(timesUp: true, optionLocked: true);
      }
    });
  }

  void selectOption(String optionId) {
    if (state.optionLocked || state.timesUp || state.isCompleted) return;

    final currentQuestion = state.questions[state.currentIndex];
    final isCorrect = optionId == currentQuestion.correctOptionId;

    state = state.copyWith(
      selectedOptionId: optionId,
      score: isCorrect ? state.score + 1 : state.score,
      optionLocked: true,
    );
    _timer?.cancel();
    
    // Auto advance after 1.5 seconds
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) nextQuestion();
    });
  }

  void skipQuestion() {
    if (state.isCompleted) return;
    _timer?.cancel();
    
    // Auto advance
    nextQuestion();
  }

  void deductCoins(int amount) {
    final currentCoins = ref.read(userCoinsProvider);
    if (currentCoins >= amount) {
      ref.read(userCoinsProvider.notifier).state = currentCoins - amount;
    }
  }

  bool canAfford(int amount) {
    return ref.read(userCoinsProvider) >= amount;
  }

  Future<void> nextQuestion() async {
    if (state.currentIndex < state.questions.length - 1) {
      state = state.copyWith(
        currentIndex: state.currentIndex + 1,
        selectedOptionId: null,
        remainingSeconds: 10,
        timesUp: false,
        optionLocked: false,
      );
      _startTimer();
    } else {
      _finishQuiz();
    }
  }

  Future<void> _finishQuiz() async {
    _timer?.cancel();
    state = state.copyWith(isLoading: true, isCompleted: true);
    final repo = ref.read(quizRepositoryProvider);
    final result = await repo.submitQuizResult(
      state.score,
      state.questions.length,
      state.totalTimeTaken,
    );
    if (mounted) {
      state = state.copyWith(isLoading: false, result: result);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final playQuizControllerProvider =
    StateNotifierProvider.autoDispose<PlayQuizController, PlayQuizState>((ref) {
  return PlayQuizController(ref);
});
