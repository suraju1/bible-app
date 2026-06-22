import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../providers/play_quiz_provider.dart';
import '../widgets/quiz_option_button.dart';
import '../widgets/bottom_action_button.dart';
import '../widgets/modals/reference_modal.dart';
import '../widgets/modals/issue_modal.dart';
import '../widgets/modals/quiz_completed_modal.dart';
import '../widgets/modals/times_up_modal.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PlayQuizScreen extends ConsumerWidget {
  const PlayQuizScreen({super.key});

  void _showModal(BuildContext context, Widget modal) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.center,
          child: Material(
            color: Colors.transparent,
            child: modal,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(playQuizControllerProvider);
    final controller = ref.read(playQuizControllerProvider.notifier);
    final currentCoins = ref.watch(userCoinsProvider);

    ref.listen<PlayQuizState>(playQuizControllerProvider, (previous, next) {
      if (next.timesUp && previous?.timesUp != true) {
        _showModal(context, const TimesUpModal());
        Future.delayed(const Duration(seconds: 2), () {
          if (context.mounted) {
            Navigator.of(context, rootNavigator: true).pop();
            controller.nextQuestion();
          }
        });
      }

      if (next.isCompleted && previous?.isCompleted != true && next.result != null) {
        _showModal(context, QuizCompletedModal(result: next.result!));
      }
    });

    if (state.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Play Quiz')),
        body: const Center(child: Text('No questions found.')),
      );
    }

    final currentQuestion = state.questions[state.currentIndex];

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
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
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back Button
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
                      // Question Counter
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withOpacity(0.5)),
                        ),
                        child: Text(
                          '${state.currentIndex + 1}/${state.questions.length}',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Coins
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.monetization_on, color: Colors.amber, size: 18),
                            const SizedBox(width: 4),
                            Text(currentCoins.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      // Skip Button
                      GestureDetector(
                        onTap: () => controller.skipQuestion(),
                        child: const Text('Skip', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                
                // Question Text
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Center(
                      child: Text(
                        currentQuestion.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.4,
                        ),
                      ).animate(key: ValueKey(currentQuestion.id)).fade(duration: 400.ms).scale(curve: Curves.easeOutBack, begin: const Offset(0.8, 0.8)),
                    ),
                  ),
                ),

                // Timer Progress
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                  child: Row(
                    children: [
                      const Text('Time', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: state.remainingSeconds / 10,
                            backgroundColor: Colors.white.withOpacity(0.3),
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                            minHeight: 8,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '00.${state.remainingSeconds.toString().padLeft(2, '0')}',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                // Options and Actions Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    left: 24.0,
                    right: 24.0,
                    top: 24.0,
                    bottom: 24.0 + MediaQuery.of(context).padding.bottom,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      ...currentQuestion.options.map((option) {
                        OptionState optState = OptionState.normal;
                        if (state.optionLocked) {
                          if (option.id == currentQuestion.correctOptionId) {
                            optState = OptionState.unselectedCorrect;
                            if (state.selectedOptionId == option.id) {
                              optState = OptionState.selectedCorrect;
                            }
                          } else if (state.selectedOptionId == option.id) {
                            optState = OptionState.selectedIncorrect;
                          }
                        }

                        return QuizOptionButton(
                          letter: option.id,
                          text: option.text,
                          state: optState,
                          onTap: () => controller.selectOption(option.id),
                        );
                      }).toList().animate(interval: 80.ms).fade(duration: 300.ms).slideX(begin: 0.05, end: 0.0, curve: Curves.easeOutCubic),
                      const SizedBox(height: 16),
                      // Bottom Actions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BottomActionButton(
                            iconPath: 'assets/icons/play_quiz/play_quiz_reference.png',
                            cost: 50,
                            onTap: () {
                              if (controller.canAfford(50)) {
                                controller.deductCoins(50);
                                _showModal(context, ReferenceModal(
                                  bookName: currentQuestion.bookName,
                                  chapter: currentQuestion.chapter,
                                  topic: currentQuestion.topic,
                                  explanation: currentQuestion.explanation,
                                  correctAnswer: currentQuestion.options.firstWhere((o) => o.id == currentQuestion.correctOptionId).text,
                                ));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Not enough coins!'), duration: Duration(seconds: 2)),
                                );
                              }
                            },
                          ),
                          BottomActionButton(
                            iconPath: 'assets/icons/play_quiz/play_quiz_correct.png',
                            cost: 50,
                            onTap: () {
                              if (controller.canAfford(50)) {
                                controller.deductCoins(50);
                                controller.selectOption(currentQuestion.correctOptionId);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Not enough coins!'), duration: Duration(seconds: 2)),
                                );
                              }
                            },
                          ),
                          BottomActionButton(
                            iconPath: 'assets/icons/play_quiz/play_quiz_wrong.png',
                            cost: 50,
                            onTap: () {
                              if (controller.canAfford(50)) {
                                controller.deductCoins(50);
                                controller.skipQuestion();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Not enough coins!'), duration: Duration(seconds: 2)),
                                );
                              }
                            },
                          ),
                          BottomActionButton(
                            iconPath: 'assets/icons/play_quiz/play_quiz_message.png',
                            cost: 50,
                            onTap: () {
                              if (controller.canAfford(50)) {
                                controller.deductCoins(50);
                                _showModal(context, IssueModal(
                                  questionText: currentQuestion.text,
                                  answerText: currentQuestion.explanation,
                                  optionsText: currentQuestion.options.map((o) => '${o.id}. ${o.text}').join('\n'),
                                ));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Not enough coins!'), duration: Duration(seconds: 2)),
                                );
                              }
                            },
                          ),
                        ],
                      ).animate(key: ValueKey('actions_${currentQuestion.id}')).fade(duration: 500.ms).slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic),
                    ],
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
