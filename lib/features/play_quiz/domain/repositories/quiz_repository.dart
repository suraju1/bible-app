import '../models/quiz_question.dart';
import '../models/quiz_result.dart';
import '../../../create_quiz/domain/models/create_quiz_request.dart';

abstract class QuizRepository {
  Future<List<QuizQuestion>> fetchQuestions();
  Future<void> submitIssue({
    required String type, // 'Question' or 'Answer'
    required String issueType,
    required String reference,
    required String text,
    required String comments,
  });
  Future<QuizResult> submitQuizResult(int correctAnswers, int totalQuestions, int timeTakenSeconds);
  Future<void> submitCreatedQuiz(CreateQuizRequest request);
}
