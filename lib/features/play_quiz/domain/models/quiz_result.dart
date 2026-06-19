class QuizResult {
  final int totalQuestions;
  final int correctAnswers;
  final int timeTakenSeconds;
  final int earnedPoints;
  final int newRank; // 1 = Bronze, 2 = Silver, etc.
  final int newLevel;

  const QuizResult({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.timeTakenSeconds,
    required this.earnedPoints,
    required this.newRank,
    required this.newLevel,
  });

  double get accuracy => totalQuestions == 0 ? 0 : (correctAnswers / totalQuestions) * 100;
}
