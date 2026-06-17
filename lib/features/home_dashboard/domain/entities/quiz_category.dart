class QuizCategory {
  final String id;
  final String title;
  final String iconType; // 'live_quiz' or 'discipline_challenge' etc.

  QuizCategory({
    required this.id,
    required this.title,
    required this.iconType,
  });
}
