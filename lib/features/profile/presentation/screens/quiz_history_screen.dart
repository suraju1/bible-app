import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/quiz_history_model.dart';
import '../providers/quiz_history_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

class QuizHistoryScreen extends ConsumerWidget {
  const QuizHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(quizHistoryListProvider);
    final filter = ref.watch(quizHistoryFilterProvider);

    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background Header
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Gradient.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Top Bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (context.canPop()) {
                            context.pop();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Quiz History',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 32), // Balance the back button
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Main Content Container
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          // Tabs
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildTab(
                                  context,
                                  ref,
                                  'All',
                                  'all',
                                  filter == 'all',
                                ),
                                const SizedBox(width: 8),
                                _buildTab(
                                  context,
                                  ref,
                                  'Individual',
                                  'individual',
                                  filter == 'individual',
                                ),
                                const SizedBox(width: 8),
                                _buildTab(
                                  context,
                                  ref,
                                  'Grouped',
                                  'grouped',
                                  filter == 'grouped',
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // History List
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                return ref.refresh(
                                  quizHistoryListProvider.future,
                                );
                              },
                              child: historyAsync.when(
                                loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                error: (err, stack) =>
                                    Center(child: Text('Error: $err')),
                                data: (items) {
                                  if (items.isEmpty) {
                                    return ListView(
                                      children: const [
                                        SizedBox(height: 100),
                                        Center(
                                          child: Text(
                                            'No quiz history available',
                                          ),
                                        ),
                                      ],
                                    );
                                  }

                                  final groupedItems = _groupItemsByDate(items);

                                  return ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0,
                                      vertical: 8.0,
                                    ),
                                    itemCount: groupedItems.length,
                                    itemBuilder: (context, index) {
                                      final section = groupedItems[index];
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _buildSectionHeader(context, section.key),
                                          const SizedBox(height: 12),
                                          ...section.value.map(
                                            (item) => _buildHistoryCard(
                                              context,
                                              item,
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                        ].animate(interval: 50.ms).fade(duration: 400.ms, curve: Curves.easeOutCubic).slideY(begin: 0.05, end: 0.0, curve: Curves.easeOutCubic),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
    BuildContext context,
    WidgetRef ref,
    String label,
    String value,
    bool isSelected,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          ref.read(quizHistoryFilterProvider.notifier).state = value;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? null : Colors.white,
            gradient: isSelected
                ? const LinearGradient(
                    colors: [
                      Color(0xFF8BA3FF),
                      Color(0xFF4A6BBA),
                    ], // Similar to the tab gradient
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
            borderRadius: BorderRadius.circular(20),
            border: isSelected ? null : Border.all(color: Colors.grey.shade300),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF8BA3FF),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: Container(height: 1, color: Colors.grey.shade300)),
      ],
    );
  }

  Widget _buildHistoryCard(BuildContext context, QuizHistoryItem item) {
    return GestureDetector(
      onTap: () {
        context.push('/profile/history-details/${item.id}');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color(0xFFD6E4FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons
                    .settings_system_daydream_outlined, // Placeholder for burst icon
                color: Color(0xFF1E3A8A),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<MapEntry<String, List<QuizHistoryItem>>> _groupItemsByDate(
    List<QuizHistoryItem> items,
  ) {
    final Map<String, List<QuizHistoryItem>> grouped = {};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    for (var item in items) {
      final itemDate = DateTime(item.date.year, item.date.month, item.date.day);
      String key;
      if (itemDate == today) {
        key = "Today's quiz history";
      } else if (itemDate == yesterday) {
        key = "Yesterday quiz history";
      } else {
        key = _formatDate(item.date);
      }

      grouped.putIfAbsent(key, () => []).add(item);
    }

    return grouped.entries.toList();
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day.toString().padLeft(2, '0')}, ${date.year}';
  }
}
