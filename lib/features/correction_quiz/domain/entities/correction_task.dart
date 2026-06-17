class CorrectionTask {
  final String id;
  final String title; // e.g., 'English Quiz Correction'
  final String userName;
  final String userAvatarUrl;
  final String feedbackQuestion;
  final String feedbackComment;

  // Fields to correct
  final String currentBibleVersion;
  final String currentTopicName;
  final String currentBibleReference;
  final String currentBibleVerse;
  final String currentQuestion;
  final String currentOptions;
  final String currentExplanation;

  const CorrectionTask({
    required this.id,
    required this.title,
    required this.userName,
    required this.userAvatarUrl,
    required this.feedbackQuestion,
    required this.feedbackComment,
    required this.currentBibleVersion,
    required this.currentTopicName,
    required this.currentBibleReference,
    required this.currentBibleVerse,
    required this.currentQuestion,
    required this.currentOptions,
    required this.currentExplanation,
  });
}
