class TermsSectionModel {
  final String title;
  final String content;
  final bool isBulletList;

  const TermsSectionModel({
    required this.title,
    required this.content,
    this.isBulletList = false,
  });

  /// Helper to split content into bullet points if [isBulletList] is true
  List<String> get bulletPoints {
    if (!isBulletList) return [];
    // Assume bullets are separated by newlines in the raw content
    return content.split('\n').where((s) => s.trim().isNotEmpty).toList();
  }
}
