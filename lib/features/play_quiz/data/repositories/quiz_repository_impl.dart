import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/quiz_question.dart';
import '../../domain/models/quiz_result.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../../../create_quiz/domain/models/create_quiz_request.dart';

final quizRepositoryProvider = Provider<QuizRepository>((ref) {
  return QuizRepositoryImpl();
});

class QuizRepositoryImpl implements QuizRepository {
  @override
  Future<List<QuizQuestion>> fetchQuestions() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Dummy data matching the Figma design
    return List.generate(
      10,
      (index) => QuizQuestion(
        id: 'q_$index',
        text: 'Your friends ask you to try smoking at a party. What would you do?',
        options: const [
          QuizOption(id: 'A', text: 'Say no politely'),
          QuizOption(id: 'B', text: 'Walk away'),
          QuizOption(id: 'C', text: 'Try once'),
          QuizOption(id: 'D', text: 'Change topic'),
        ],
        correctOptionId: 'A',
        bookName: 'Life Skills & Healthy Choices',
        chapter: 'Handling Peer Pressure',
        topic: 'Smoking Awareness & Smart Decision Making',
        explanation:
            'This question is designed to test how well a user can handle peer pressure and make safe, healthy decisions in social situations. Sometimes friends may encourage harmful habits like smoking just to "fit in" or look cool.\n\nThe correct decision is to stay confident and protect your health.',
      ),
    );
  }

  @override
  Future<void> submitIssue({
    required String type,
    required String issueType,
    required String reference,
    required String text,
    required String comments,
  }) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<QuizResult> submitQuizResult(
      int correctAnswers, int totalQuestions, int timeTakenSeconds) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    return QuizResult(
      totalQuestions: totalQuestions,
      correctAnswers: correctAnswers,
      timeTakenSeconds: timeTakenSeconds,
      earnedPoints: correctAnswers * 10,
      newRank: 1,
      newLevel: 2,
    );
  }

  @override
  Future<void> submitCreatedQuiz(CreateQuizRequest request) async {
    // Simulate API call for submitting a newly created quiz
    await Future.delayed(const Duration(seconds: 2));
  }
}
