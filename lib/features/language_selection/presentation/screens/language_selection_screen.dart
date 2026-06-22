import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../providers/language_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LanguageSelectionScreen extends ConsumerWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageListAsyncValue = ref.watch(languageListProvider);
    final selectedLanguages = ref.watch(selectedLanguagesProvider);
    final primaryLanguage = ref.watch(primaryLanguageProvider);
    final languageSkills = ref.watch(languageSkillsProvider);
    final saveState = ref.watch(saveLanguageProvider);

    // Listen to save action to navigate
    ref.listen(saveLanguageProvider, (previous, next) {
      if (next is AsyncData && previous is AsyncLoading) {
        context.go('/expertise-selection');
      } else if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save language: ${next.error}')),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Language Selection',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: '| ex. Hindi',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.textSecondary,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Scrollable Lists Area
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Suggestion Box
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 16.0,
                                top: 12.0,
                                bottom: 8.0,
                              ),
                              child: Text(
                                'Suggestion',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: languageListAsyncValue.when(
                                loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                error: (err, stack) =>
                                    Center(child: Text('Error: $err')),
                                data: (languages) {
                                  return ListView.separated(
                                    itemCount: languages.length,
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                          height: 1,
                                          indent: 16,
                                          endIndent: 16,
                                          color: Colors.grey.shade300,
                                        ),
                                    itemBuilder: (context, index) {
                                      final language = languages[index];
                                      final isSelected = selectedLanguages.any(
                                        (l) => l.code == language.code,
                                      );
                                      return ListTile(
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 0.0),
                                        title: Text(
                                          language.nativeName,
                                          style: TextStyle(
                                            fontWeight: isSelected
                                                ? FontWeight.w600
                                                : FontWeight.w500,
                                            color: AppColors.textPrimary,
                                            fontSize: 16,
                                          ),
                                        ),
                                        subtitle:
                                            language.name != language.nativeName
                                            ? Text(
                                                language.name,
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                ),
                                              )
                                            : null,
                                        trailing: isSelected
                                            ? const Icon(
                                                Icons.check_circle,
                                                color: AppColors.primary,
                                              )
                                            : const Icon(
                                                Icons.circle_outlined,
                                                color: AppColors.primary,
                                              ),
                                        onTap: () {
                                          final notifier = ref.read(
                                            selectedLanguagesProvider.notifier,
                                          );
                                          if (isSelected) {
                                            notifier.state = selectedLanguages
                                                .where(
                                                  (l) =>
                                                      l.code != language.code,
                                                )
                                                .toList();
                                            if (primaryLanguage?.code ==
                                                language.code) {
                                              ref
                                                      .read(
                                                        primaryLanguageProvider
                                                            .notifier,
                                                      )
                                                      .state =
                                                  null;
                                            }
                                          } else {
                                            notifier.state = [
                                              ...selectedLanguages,
                                              language,
                                            ];
                                            if (primaryLanguage == null) {
                                              ref
                                                      .read(
                                                        primaryLanguageProvider
                                                            .notifier,
                                                      )
                                                      .state =
                                                  language;
                                            }
                                          }
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Selected Language Box (Only show if there are selected languages)
                      if (selectedLanguages.isNotEmpty)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                  left: 16.0,
                                  top: 12.0,
                                  bottom: 8.0,
                                ),
                                child: Text(
                                  'Selected language',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              ...selectedLanguages.map((language) {
                                final isPrimary =
                                    primaryLanguage?.code == language.code;
                                final skills =
                                    languageSkills[language.code] ?? {};

                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent,
                                    ),
                                    child: ExpansionTile(
                                      initiallyExpanded: isPrimary,
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            language.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Radio<String>(
                                                value: language.code,
                                                groupValue:
                                                    primaryLanguage?.code,
                                                onChanged: (val) {
                                                  if (val != null) {
                                                    ref
                                                            .read(
                                                              primaryLanguageProvider
                                                                  .notifier,
                                                            )
                                                            .state =
                                                        language;
                                                  }
                                                },
                                                activeColor: AppColors.primary,
                                              ),
                                              const Text(
                                                'Primary',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      children: [
                                        _buildSkillCheckbox(
                                          ref,
                                          language.code,
                                          skills,
                                          'Reading',
                                        ),
                                        _buildSkillCheckbox(
                                          ref,
                                          language.code,
                                          skills,
                                          'Writing',
                                        ),
                                        _buildSkillCheckbox(
                                          ref,
                                          language.code,
                                          skills,
                                          'Speaking',
                                        ),
                                        const SizedBox(height: 8),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                              const SizedBox(height: 8),
                            ],
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 48.0,
                            left: 16,
                            right: 16,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.language,
                                  size: 48,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                'No Language Selected',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Please select a language from the suggestions above to configure your proficiency.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
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

              // Continue Button
              Builder(
                builder: (context) {
                  final isButtonDisabled =
                      primaryLanguage == null || saveState.isLoading;
                  return Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: isButtonDisabled
                          ? null
                          : AppColors.primaryGradient,
                      color: isButtonDisabled ? Colors.grey.shade300 : null,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ElevatedButton(
                      onPressed: isButtonDisabled
                          ? null
                          : () {
                              ref
                                  .read(saveLanguageProvider.notifier)
                                  .save(primaryLanguage);
                            },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white,
                      ),
                      child: saveState.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Continue',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ].animate(interval: 50.ms).fade(duration: 400.ms, curve: Curves.easeOutCubic).slideY(begin: 0.05, end: 0.0, curve: Curves.easeOutCubic),
          ),
        ),
      ),
    );
  }

  Widget _buildSkillCheckbox(
    WidgetRef ref,
    String languageCode,
    Set<String> skills,
    String skillName,
  ) {
    final isChecked = skills.contains(skillName);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text(
                '• ',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              Text(
                skillName,
                style: const TextStyle(color: AppColors.textPrimary),
              ),
            ],
          ),
          Checkbox(
            value: isChecked,
            onChanged: (val) {
              final currentSkills = Map<String, Set<String>>.from(
                ref.read(languageSkillsProvider),
              );
              final langSkills = Set<String>.from(
                currentSkills[languageCode] ?? {},
              );
              if (val == true) {
                langSkills.add(skillName);
              } else {
                langSkills.remove(skillName);
              }
              currentSkills[languageCode] = langSkills;
              ref.read(languageSkillsProvider.notifier).state = currentSkills;
            },
            activeColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
