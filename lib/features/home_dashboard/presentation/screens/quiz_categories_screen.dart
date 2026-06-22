import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/category_card.dart';
import 'package:flutter_animate/flutter_animate.dart';

class QuizCategoriesScreen extends ConsumerWidget {
  const QuizCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardDataProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Gradient.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Header
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.15),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                        onPressed: () => context.pop(),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'Quiz Categories',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Main Content
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: dashboardState.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text('Error: $err')),
                  data: (data) {
                    if (data.categories.isEmpty) {
                      return const Center(child: Text('No categories available'));
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.all(24.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.85, // Same as CategoryCard roughly
                      ),
                      itemCount: data.categories.length,
                      itemBuilder: (context, index) {
                        final category = data.categories[index];
                        return CategoryCard(
                          title: category.title,
                          iconType: category.iconType,
                          onTap: () {
                            if (category.id == 'live_quiz_mode') {
                              context.push('/quiz-mode-selection');
                            }
                            // Add other tap behaviors if needed
                          },
                        ).animate(delay: (index * 50).ms).fade(duration: 400.ms, curve: Curves.easeOutCubic).slideY(begin: 0.05, end: 0.0, curve: Curves.easeOutCubic);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
