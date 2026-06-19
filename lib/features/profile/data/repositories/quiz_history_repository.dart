import '../../domain/models/quiz_history_model.dart';

class QuizHistoryRepository {
  Future<List<QuizHistoryItem>> fetchQuizHistory(String filterType) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    final twoDaysAgo = now.subtract(const Duration(days: 2));

    final allItems = [
      QuizHistoryItem(
        id: '1',
        type: 'individual',
        title: 'Your friends ask you to try smoking at a party. What would you do?',
        date: now, // Today
      ),
      QuizHistoryItem(
        id: '2',
        type: 'grouped',
        title: 'You see a student being bullied in the hallway. How do you react?',
        date: now, // Today
      ),
      QuizHistoryItem(
        id: '3',
        type: 'individual',
        title: 'You see a student being bullied in the hallway. How do you react?',
        date: now, // Today
      ),
      QuizHistoryItem(
        id: '4',
        type: 'individual',
        title: 'You see a student being bullied in the hallway. How do you react?',
        date: yesterday, // Yesterday
      ),
      QuizHistoryItem(
        id: '5',
        type: 'grouped',
        title: 'You see a student being bullied in the hallway. How do you react?',
        date: yesterday, // Yesterday
      ),
      QuizHistoryItem(
        id: '6',
        type: 'individual',
        title: 'Older quiz history item example.',
        date: twoDaysAgo, // Older
      ),
    ];

    if (filterType == 'individual') {
      return allItems.where((item) => item.type == 'individual').toList();
    } else if (filterType == 'grouped') {
      return allItems.where((item) => item.type == 'grouped').toList();
    }
    
    return allItems;
  }

  Future<QuizHistoryItem> fetchQuizDetails(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return QuizHistoryItem(
      id: id,
      type: 'individual',
      title: 'Your friends ask you to try smoking at a party. What would you do?',
      date: DateTime.now(),
      options: [
        QuizHistoryOption(label: 'A', text: 'Say no politely', isCorrect: true, isSelected: false),
        QuizHistoryOption(label: 'B', text: 'Walk away', isCorrect: false, isSelected: false),
        QuizHistoryOption(label: 'C', text: 'Try once', isCorrect: false, isSelected: false),
        QuizHistoryOption(label: 'D', text: 'Change topic', isCorrect: false, isSelected: true),
      ],
      reference: QuizAnswerReference(
        bookName: 'Life Skills & Healthy Choices',
        chapter: 'Handling Peer Pressure',
        topic: 'Smoking Awareness & Smart Decision Making',
        explanation: 'This question is designed to test how well a user can handle peer pressure and make safe, healthy decisions in social situations. Sometimes friends may encourage harmful habits like smoking just to "fit in" or look cool. The correct decision is to stay confident and protect your health.',
        correctAnswerText: 'Say no politely',
      ),
    );
  }
}
