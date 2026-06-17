class TranslationTask {
  final String id;
  final String title;
  final String sourceLanguage;
  final String targetLanguage;
  
  // Fields to translate
  final String sourceBibleVersion;
  final String? translatedBibleVersion;

  final String sourceTopicName;
  final String? translatedTopicName;

  final String sourceBibleReference;
  final String? translatedBibleReference;

  final String sourceQuestion;
  final String? translatedQuestion;

  const TranslationTask({
    required this.id,
    required this.title,
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.sourceBibleVersion,
    this.translatedBibleVersion,
    required this.sourceTopicName,
    this.translatedTopicName,
    required this.sourceBibleReference,
    this.translatedBibleReference,
    required this.sourceQuestion,
    this.translatedQuestion,
  });
}
