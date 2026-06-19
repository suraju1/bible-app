class QuizHistoryOption {
  final String label; // A, B, C, D
  final String text;
  final bool isCorrect;
  final bool isSelected;

  QuizHistoryOption({
    required this.label,
    required this.text,
    required this.isCorrect,
    required this.isSelected,
  });

  factory QuizHistoryOption.fromJson(Map<String, dynamic> json) {
    return QuizHistoryOption(
      label: json['label'] as String,
      text: json['text'] as String,
      isCorrect: json['isCorrect'] as bool? ?? false,
      isSelected: json['isSelected'] as bool? ?? false,
    );
  }
}

class QuizAnswerReference {
  final String bookName;
  final String chapter;
  final String topic;
  final String explanation;
  final String correctAnswerText;

  QuizAnswerReference({
    required this.bookName,
    required this.chapter,
    required this.topic,
    required this.explanation,
    required this.correctAnswerText,
  });

  factory QuizAnswerReference.fromJson(Map<String, dynamic> json) {
    return QuizAnswerReference(
      bookName: json['bookName'] as String? ?? '',
      chapter: json['chapter'] as String? ?? '',
      topic: json['topic'] as String? ?? '',
      explanation: json['explanation'] as String? ?? '',
      correctAnswerText: json['correctAnswerText'] as String? ?? '',
    );
  }
}

class QuizHistoryItem {
  final String id;
  final String type; // 'individual' or 'grouped'
  final String title;
  final DateTime date;
  
  // Details specific fields
  final List<QuizHistoryOption>? options;
  final QuizAnswerReference? reference;

  QuizHistoryItem({
    required this.id,
    required this.type,
    required this.title,
    required this.date,
    this.options,
    this.reference,
  });

  factory QuizHistoryItem.fromJson(Map<String, dynamic> json) {
    return QuizHistoryItem(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => QuizHistoryOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      reference: json['reference'] != null 
          ? QuizAnswerReference.fromJson(json['reference'] as Map<String, dynamic>)
          : null,
    );
  }
}
