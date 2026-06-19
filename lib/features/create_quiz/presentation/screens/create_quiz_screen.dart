import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/models/create_quiz_request.dart';
import '../providers/create_quiz_provider.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/modals/success_modal.dart';
import '../widgets/modals/validation_error_modal.dart';

class CreateQuizScreen extends ConsumerStatefulWidget {
  const CreateQuizScreen({super.key});

  @override
  ConsumerState<CreateQuizScreen> createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends ConsumerState<CreateQuizScreen> {
  final _formKey = GlobalKey<FormState>();

  String _selectedLanguage = 'English';
  String _selectedQVersion = 'New King James Version';
  final _topicController = TextEditingController();
  final _qReferenceController = TextEditingController();
  final _qVerseController = TextEditingController();
  final _qTextController = TextEditingController();

  String _selectedAVersion = 'New King James Version';
  final _aReferenceController = TextEditingController();
  final _aVerseController = TextEditingController();

  final _correctAnswerController = TextEditingController();
  final _wrong1Controller = TextEditingController();
  final _wrong2Controller = TextEditingController();
  final _wrong3Controller = TextEditingController();

  final _reasonController = TextEditingController();
  String _selectedAgeGroup = '10-20';

  @override
  void dispose() {
    _topicController.dispose();
    _qReferenceController.dispose();
    _qVerseController.dispose();
    _qTextController.dispose();
    _aReferenceController.dispose();
    _aVerseController.dispose();
    _correctAnswerController.dispose();
    _wrong1Controller.dispose();
    _wrong2Controller.dispose();
    _wrong3Controller.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final state = ref.read(createQuizControllerProvider);
      
      final req = CreateQuizRequest(
        language: _selectedLanguage,
        questionBibleVersion: _selectedQVersion,
        topicName: _topicController.text.trim(),
        questionReference: _qReferenceController.text.trim(),
        questionVerse: _qVerseController.text.trim(),
        questionText: _qTextController.text.trim(),
        answerBibleVersion: state.sameReferenceChecked ? _selectedQVersion : _selectedAVersion,
        answerReference: state.sameReferenceChecked ? _qReferenceController.text.trim() : _aReferenceController.text.trim(),
        answerVerse: state.sameReferenceChecked ? _qVerseController.text.trim() : _aVerseController.text.trim(),
        correctAnswer: _correctAnswerController.text.trim(),
        wrongAnswer1: _wrong1Controller.text.trim(),
        wrongAnswer2: _wrong2Controller.text.trim().isEmpty ? null : _wrong2Controller.text.trim(),
        wrongAnswer3: _wrong3Controller.text.trim().isEmpty ? null : _wrong3Controller.text.trim(),
        answerReason: _reasonController.text.trim(),
        ageGroup: _selectedAgeGroup,
      );

      ref.read(createQuizControllerProvider.notifier).submitQuiz(req);
    } else {
      // Find the first error conceptually, or just show a generic popup.
      // Based on instructions, show a validation error popup.
      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: 'Dismiss',
        barrierColor: Colors.black54,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, anim1, anim2) {
          return const Align(
            alignment: Alignment.center,
            child: Material(
              color: Colors.transparent,
              child: ValidationErrorModal(
                errorMessage: 'Please fill in all required fields. You must provide a valid Biblical reference and at least one wrong answer.',
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createQuizControllerProvider);

    ref.listen<CreateQuizState>(createQuizControllerProvider, (prev, next) {
      if (next.isSuccess && prev?.isSuccess != true) {
        showGeneralDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.black87,
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (context, anim1, anim2) {
            return const Align(
              alignment: Alignment.center,
              child: Material(
                color: Colors.transparent,
                child: SuccessModal(),
              ),
            );
          },
        );
      } else if (next.errorMessage != null && prev?.errorMessage != next.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient (top part visible)
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Gradient.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Top Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16),
                        ),
                      ),
                      const Text(
                        'Create Quiz',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.monetization_on, color: Colors.amber, size: 18),
                            SizedBox(width: 4),
                            Text('0', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // Form Container
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
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          padding: const EdgeInsets.all(24.0),
                          children: [
                            CustomDropdown(
                              label: 'Select Language',
                              value: _selectedLanguage,
                              items: const ['English', 'Spanish', 'French'],
                              onChanged: (val) {
                                if (val != null) setState(() => _selectedLanguage = val);
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomDropdown(
                              label: 'Question - Bible Version',
                              value: _selectedQVersion,
                              items: const ['New King James Version', 'NIV', 'ESV'],
                              onChanged: (val) {
                                if (val != null) setState(() => _selectedQVersion = val);
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              label: 'Topic Name',
                              hintText: 'e.g. Kindness & Respect...',
                              controller: _topicController,
                              validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              label: 'Question - Bible Reference',
                              hintText: 'e.g. Proverbs 1:10',
                              controller: _qReferenceController,
                              validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              label: 'Question - Bible Verse',
                              hintText: 'Verse text...',
                              controller: _qVerseController,
                              maxLines: 4,
                              validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              label: 'Question',
                              hintText: 'You see a student being bullied...',
                              controller: _qTextController,
                              maxLines: 4,
                              validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                            ),
                            const SizedBox(height: 20),
                            
                            // Checkbox for Same Reference
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Q & A - Same Reference',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                                  ),
                                ),
                                Checkbox(
                                  value: state.sameReferenceChecked,
                                  activeColor: AppColors.primary,
                                  onChanged: (val) {
                                    ref.read(createQuizControllerProvider.notifier).toggleSameReference(val ?? true);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            if (!state.sameReferenceChecked) ...[
                              CustomDropdown(
                                label: 'Answer - Bible Version',
                                value: _selectedAVersion,
                                items: const ['New King James Version', 'NIV', 'ESV'],
                                onChanged: (val) {
                                  if (val != null) setState(() => _selectedAVersion = val);
                                },
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                label: 'Answer - Bible Reference',
                                hintText: 'e.g. Proverbs 1:10',
                                controller: _aReferenceController,
                                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                label: 'Answer - Bible Verse',
                                hintText: 'Verse text...',
                                controller: _aVerseController,
                                maxLines: 4,
                                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                              ),
                              const SizedBox(height: 20),
                            ],

                            const Text(
                              'Options',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              label: 'Enter correct answer',
                              hintText: 'Join',
                              controller: _correctAnswerController,
                              validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              label: 'Enter first wrong answer',
                              hintText: 'Ignore',
                              controller: _wrong1Controller,
                              validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              label: 'Enter second wrong answer',
                              hintText: 'Help & tell teacher',
                              controller: _wrong2Controller,
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              label: 'Enter third wrong answer',
                              hintText: 'Record video',
                              controller: _wrong3Controller,
                            ),
                            const SizedBox(height: 24),
                            
                            CustomTextField(
                              label: 'Answer - Reason',
                              hintText: 'Helping the student...',
                              controller: _reasonController,
                              maxLines: 4,
                              validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                            ),
                            const SizedBox(height: 20),

                            CustomDropdown(
                              label: 'Select Age Group',
                              value: _selectedAgeGroup,
                              items: const ['5-9', '10-20', '21+'],
                              onChanged: (val) {
                                if (val != null) setState(() => _selectedAgeGroup = val);
                              },
                            ),
                            const SizedBox(height: 32),
                            
                            // Submit Button
                            Container(
                              width: double.infinity,
                              height: 55,
                              decoration: BoxDecoration(
                                gradient: AppColors.primaryGradient,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: state.isLoading ? null : _submit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                ),
                                child: state.isLoading 
                                    ? const CircularProgressIndicator(color: Colors.white)
                                    : const Text('Submit Question', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
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
}
