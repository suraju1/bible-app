class FaqModel {
  final String id;
  final String question;
  final String answer;

  const FaqModel({
    required this.id,
    required this.question,
    required this.answer,
  });
}

class HelpArticleModel {
  final String id;
  final String title;
  final String content;
  final String? url;

  const HelpArticleModel({
    required this.id,
    required this.title,
    required this.content,
    this.url,
  });
}

class HelpCategoryModel {
  final String id;
  final String name;
  final String icon;

  const HelpCategoryModel({
    required this.id,
    required this.name,
    required this.icon,
  });
}
