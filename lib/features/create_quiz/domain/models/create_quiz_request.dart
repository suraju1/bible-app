class CreateQuizRequest {
  final String language;
  final String questionBibleVersion;
  final String topicName;
  final String questionReference;
  final String questionVerse;
  final String questionText;
  
  final String answerBibleVersion;
  final String answerReference;
  final String answerVerse;
  
  final String correctAnswer;
  final String wrongAnswer1;
  final String? wrongAnswer2;
  final String? wrongAnswer3;
  
  final String answerReason;
  final String ageGroup;

  const CreateQuizRequest({
    required this.language,
    required this.questionBibleVersion,
    required this.topicName,
    required this.questionReference,
    required this.questionVerse,
    required this.questionText,
    required this.answerBibleVersion,
    required this.answerReference,
    required this.answerVerse,
    required this.correctAnswer,
    required this.wrongAnswer1,
    this.wrongAnswer2,
    this.wrongAnswer3,
    required this.answerReason,
    required this.ageGroup,
  });

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'questionBibleVersion': questionBibleVersion,
      'topicName': topicName,
      'questionReference': questionReference,
      'questionVerse': questionVerse,
      'questionText': questionText,
      'answerBibleVersion': answerBibleVersion,
      'answerReference': answerReference,
      'answerVerse': answerVerse,
      'correctAnswer': correctAnswer,
      'wrongAnswer1': wrongAnswer1,
      'wrongAnswer2': wrongAnswer2,
      'wrongAnswer3': wrongAnswer3,
      'answerReason': answerReason,
      'ageGroup': ageGroup,
    };
  }
}
