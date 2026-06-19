class QuizOption {
  final String id;
  final String text;

  const QuizOption({
    required this.id,
    required this.text,
  });
}

class QuizQuestion {
  final String id;
  final String text;
  final List<QuizOption> options;
  final String correctOptionId;
  final String bookName;
  final String chapter;
  final String topic;
  final String explanation;

  const QuizQuestion({
    required this.id,
    required this.text,
    required this.options,
    required this.correctOptionId,
    required this.bookName,
    required this.chapter,
    required this.topic,
    required this.explanation,
  });
}
