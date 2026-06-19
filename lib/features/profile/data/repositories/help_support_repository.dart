import '../../domain/models/help_support_model.dart';

class HelpSupportRepository {
  Future<List<FaqModel>> getFaqs() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      const FaqModel(
        id: '1',
        question: 'How do I change my primary language?',
        answer: 'Go to Profile -> Language Settings, tap on a language, and select "Primary".',
      ),
      const FaqModel(
        id: '2',
        question: 'Can I play offline?',
        answer: 'Currently, an active internet connection is required to fetch new quizzes and save your progress.',
      ),
    ];
  }

  Future<List<HelpArticleModel>> getHelpArticles() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      const HelpArticleModel(
        id: '1',
        title: 'Getting Started with Bible Quiz',
        content: 'Welcome to the app! Here is a quick guide...',
      ),
      const HelpArticleModel(
        id: '2',
        title: 'How Points and Rewards Work',
        content: 'You earn points for every correct answer...',
      ),
    ];
  }

  Future<bool> submitFeedback(String feedback) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return true; // Success
  }

  Future<bool> submitIssueReport(String issue, {String? screenshotPath}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1000));
    return true; // Success
  }
}
