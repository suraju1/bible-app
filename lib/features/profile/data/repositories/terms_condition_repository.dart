import '../../domain/models/terms_condition_model.dart';

class TermsConditionRepository {
  Future<List<TermsSectionModel>> getTermsAndConditions() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    // Return the mocked content exactly matching the Figma design
    return const [
      TermsSectionModel(
        title: '1. Introduction',
        content: 'Welcome to our Bible Quiz App. By using this app, you agree to follow these Terms & Conditions. The app is designed to provide fun, learning, and competitive quiz challenges for all users. Please use it responsibly and enjoy the experience.',
        isBulletList: false,
      ),
      TermsSectionModel(
        title: '2. User Rules',
        content: '''Users must provide accurate profile information.
Any cheating, use of bots, or unfair means is strictly prohibited.
Respect other players in chats, comments, or leaderboards.
Do not attempt to hack, modify, or misuse the app system.
One account per user is recommended for fair gameplay.''',
        isBulletList: true,
      ),
      TermsSectionModel(
        title: '3. Privacy Policy',
        content: '''We collect basic user data like name, score, and gameplay activity to improve experience.
Your personal information will never be sold or shared with third parties.
Score and ranking data may be visible on leaderboards.
We use cookies and analytics to improve app performance and user experience.''',
        isBulletList: true,
      ),
      TermsSectionModel(
        title: '4. Payment Terms (if any)',
        content: '''Some features like premium quizzes, rewards, or gift cards may require payment.''',
        isBulletList: true,
      ),
    ];
  }
}
