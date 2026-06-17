import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/correction_quiz_provider.dart';
import '../widgets/user_feedback_card.dart';
import '../widgets/correction_field_section.dart';
import 'correction_success_dialog.dart';

class CorrectionFormScreen extends ConsumerStatefulWidget {
  final String taskId;

  const CorrectionFormScreen({super.key, required this.taskId});

  @override
  ConsumerState<CorrectionFormScreen> createState() => _CorrectionFormScreenState();
}

class _CorrectionFormScreenState extends ConsumerState<CorrectionFormScreen> {
  final _bibleVersionController = TextEditingController();
  final _topicNameController = TextEditingController();
  final _bibleReferenceController = TextEditingController();
  final _bibleVerseController = TextEditingController();
  final _questionController = TextEditingController();
  final _optionsController = TextEditingController();
  final _explanationController = TextEditingController();

  @override
  void dispose() {
    _bibleVersionController.dispose();
    _topicNameController.dispose();
    _bibleReferenceController.dispose();
    _bibleVerseController.dispose();
    _questionController.dispose();
    _optionsController.dispose();
    _explanationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskAsyncValue = ref.watch(correctionTaskDetailsProvider(widget.taskId));

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8BB5F5), // Light sky blue
              Color(0xFF3A3B8B), // Deep purple/blue
            ],
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    const Text(
                      'Correction Quiz',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Coin Indicator
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.monetization_on, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text(
                            '0',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Main Content Container
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: taskAsyncValue.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text('Error: $err')),
                  data: (task) {
                    return Column(
                      children: [
                        const SizedBox(height: 24),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // User Feedback Section
                                UserFeedbackCard(
                                  userName: task.userName,
                                  userAvatarUrl: task.userAvatarUrl,
                                  questionText: task.feedbackQuestion,
                                  commentText: task.feedbackComment,
                                ),
                                const SizedBox(height: 32),

                                // Correction Fields
                                CorrectionFieldSection(
                                  title: 'Question - Bible Version',
                                  currentValue: task.currentBibleVersion,
                                  correctionController: _bibleVersionController,
                                  onValidationChanged: (isCorrect) {},
                                ),
                                const SizedBox(height: 24),

                                CorrectionFieldSection(
                                  title: 'Topic Name',
                                  currentValue: task.currentTopicName,
                                  correctionController: _topicNameController,
                                  onValidationChanged: (isCorrect) {},
                                ),
                                const SizedBox(height: 24),

                                CorrectionFieldSection(
                                  title: 'Question - Bible Reference',
                                  currentValue: task.currentBibleReference,
                                  correctionController: _bibleReferenceController,
                                  onValidationChanged: (isCorrect) {},
                                ),
                                const SizedBox(height: 24),

                                CorrectionFieldSection(
                                  title: 'Question - Bible Verse',
                                  currentValue: task.currentBibleVerse,
                                  correctionController: _bibleVerseController,
                                  onValidationChanged: (isCorrect) {},
                                ),
                                const SizedBox(height: 24),

                                CorrectionFieldSection(
                                  title: 'Question',
                                  currentValue: task.currentQuestion,
                                  correctionController: _questionController,
                                  onValidationChanged: (isCorrect) {},
                                ),
                                const SizedBox(height: 24),

                                CorrectionFieldSection(
                                  title: 'Options',
                                  currentValue: task.currentOptions,
                                  correctionController: _optionsController,
                                  onValidationChanged: (isCorrect) {},
                                ),
                                const SizedBox(height: 24),

                                CorrectionFieldSection(
                                  title: 'Explanation',
                                  currentValue: task.currentExplanation,
                                  correctionController: _explanationController,
                                  onValidationChanged: (isCorrect) {},
                                ),
                                const SizedBox(height: 40),

                                // Submit Button
                                SizedBox(
                                  width: double.infinity,
                                  height: 56,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Color(0xFF8BB5F5), Color(0xFF4A72B2)],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: BorderRadius.circular(28),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF4A72B2).withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          barrierColor: Colors.black.withOpacity(0.6),
                                          builder: (context) => const CorrectionSuccessDialog(),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                                      ),
                                      child: const Text(
                                        'Submit Correction',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 32),
                              ],
                            ),
                          ),
                        ),
                      ],
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
