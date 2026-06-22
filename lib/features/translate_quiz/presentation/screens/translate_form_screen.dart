import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/translate_quiz_provider.dart';
import 'translation_success_dialog.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TranslateFormScreen extends ConsumerStatefulWidget {
  final String taskId;

  const TranslateFormScreen({super.key, required this.taskId});

  @override
  ConsumerState<TranslateFormScreen> createState() => _TranslateFormScreenState();
}

class _TranslateFormScreenState extends ConsumerState<TranslateFormScreen> {
  final _bibleVersionController = TextEditingController();
  final _topicNameController = TextEditingController();
  final _bibleReferenceController = TextEditingController();

  @override
  void dispose() {
    _bibleVersionController.dispose();
    _topicNameController.dispose();
    _bibleReferenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskAsyncValue = ref.watch(translationTaskDetailsProvider(widget.taskId));

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
                      'Translate Quiz',
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
                    // Pre-fill controllers if there is already translated data
                    if (_bibleVersionController.text.isEmpty && task.translatedBibleVersion != null) {
                      _bibleVersionController.text = task.translatedBibleVersion!;
                    }
                    if (_topicNameController.text.isEmpty && task.translatedTopicName != null) {
                      _topicNameController.text = task.translatedTopicName!;
                    }
                    if (_bibleReferenceController.text.isEmpty && task.translatedBibleReference != null) {
                      _bibleReferenceController.text = task.translatedBibleReference!;
                    }

                    return Column(
                      children: [
                        // Language Dropdowns Row
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildDropdown(
                                  label: 'Current',
                                  value: task.sourceLanguage,
                                  isReadOnly: true,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildDropdown(
                                  label: 'Translate in',
                                  value: task.targetLanguage,
                                  isReadOnly: false,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Scrollable form fields
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildTranslationSection(
                                  sectionTitle: 'Question - Bible Version',
                                  sourceLanguage: task.sourceLanguage,
                                  sourceText: task.sourceBibleVersion,
                                  targetLanguage: task.targetLanguage,
                                  controller: _bibleVersionController,
                                ),
                                const SizedBox(height: 24),

                                _buildTranslationSection(
                                  sectionTitle: 'Topic Name',
                                  sourceLanguage: task.sourceLanguage,
                                  sourceText: task.sourceTopicName,
                                  targetLanguage: task.targetLanguage,
                                  controller: _topicNameController,
                                ),
                                const SizedBox(height: 24),

                                _buildTranslationSection(
                                  sectionTitle: 'Question - Bible Reference',
                                  sourceLanguage: task.sourceLanguage,
                                  sourceText: task.sourceBibleReference,
                                  targetLanguage: task.targetLanguage,
                                  controller: _bibleReferenceController,
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
                                        // Show Success Dialog as required
                                        showDialog(
                                          context: context,
                                          barrierColor: Colors.black.withOpacity(0.6),
                                          builder: (context) => const TranslationSuccessDialog(),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                                      ),
                                      child: const Text(
                                        'Submit Translate',
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
                              ].animate(interval: 50.ms).fade(duration: 400.ms, curve: Curves.easeOutCubic).slideY(begin: 0.05, end: 0.0, curve: Curves.easeOutCubic),
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

  Widget _buildDropdown({required String label, required String value, required bool isReadOnly}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isReadOnly ? Colors.transparent : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              if (!isReadOnly)
                const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTranslationSection({
    required String sectionTitle,
    required String sourceLanguage,
    required String sourceText,
    required String targetLanguage,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100, // Very light grey container mimicking Figma
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Source Box
              Text(
                sourceLanguage,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Text(
                  sourceText,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Target Box
              Text(
                targetLanguage,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: TextField(
                  controller: controller,
                  maxLines: null,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    border: InputBorder.none,
                    hintText: 'Enter translation...',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
