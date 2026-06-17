import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../language_selection/domain/entities/language.dart';
import '../../../language_selection/presentation/providers/language_provider.dart';
import '../../domain/entities/bible_version.dart';
import '../providers/expertise_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ExpertiseSelectionScreen extends ConsumerStatefulWidget {
  const ExpertiseSelectionScreen({super.key});

  @override
  ConsumerState<ExpertiseSelectionScreen> createState() => _ExpertiseSelectionScreenState();
}

class _ExpertiseSelectionScreenState extends ConsumerState<ExpertiseSelectionScreen> {
  final _educationController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill controllers if values exist in providers
    _educationController.text = ref.read(expertiseEducationProvider);
    _ageController.text = ref.read(expertiseAgeProvider);
  }

  @override
  void dispose() {
    _educationController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languages = ref.watch(expertiseLanguagesProvider);
    final versions = ref.watch(expertiseVersionsProvider);
    final saveState = ref.watch(saveExpertiseProvider);

    ref.listen(saveExpertiseProvider, (previous, next) {
      if (next is AsyncData && previous is AsyncLoading) {
        Future.microtask(() async {
          final token = await ref.read(secureStorageProvider).getToken();
          if (context.mounted) {
            if (token != null && token.isNotEmpty) {
              context.go('/home');
            } else {
              context.go('/auth-selection');
            }
          }
        });
      } else if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error.toString())),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    radius: 20,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.black54),
                      onPressed: () {
                        if (context.canPop()) context.pop();
                      },
                    ),
                  ),
                  const Text('Expertise', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    radius: 20,
                    child: TextButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('has_selected_expertise', true);

                        final token = await ref.read(secureStorageProvider).getToken();
                        if (context.mounted) {
                          if (token != null && token.isNotEmpty) {
                            context.go('/home');
                          } else {
                            context.go('/auth-selection');
                          }
                        }
                      },
                      child: const Text('Skip', style: TextStyle(fontSize: 12, color: Colors.black54)),
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Form Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildLanguageSection(context, ref, languages),
                    const SizedBox(height: 20),
                    _buildVersionSection(context, ref, versions),
                    const SizedBox(height: 20),
                    _buildEducationSection(context, ref),
                    const SizedBox(height: 20),
                    _buildAgeSection(context, ref),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            // Continue Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: saveState.isLoading
                    ? null
                    : () {
                        // Sync text controllers with provider before saving
                        ref.read(expertiseEducationProvider.notifier).state = _educationController.text;
                        ref.read(expertiseAgeProvider.notifier).state = _ageController.text;
                        ref.read(saveExpertiseProvider.notifier).save();
                      },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor: Colors.grey.shade300,
                ),
                child: saveState.isLoading
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSection(BuildContext context, WidgetRef ref, List<Language?> languages) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Which language Bible do you read regularly?', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Preferred language', style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              ...languages.asMap().entries.map((entry) {
                final index = entry.key;
                final lang = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: GestureDetector(
                    onTap: () => _showLanguagePicker(context, ref, index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.grey.shade300)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(lang?.name ?? 'Select Language', style: TextStyle(color: lang != null ? AppColors.textPrimary : Colors.grey)),
                          const Icon(Icons.arrow_drop_down, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              GestureDetector(
                onTap: () {
                  ref.read(expertiseLanguagesProvider.notifier).state = [...languages, null];
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.grey.shade300)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_circle_outline, color: AppColors.textPrimary, size: 20),
                      SizedBox(width: 8),
                      Text('Add another Language', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVersionSection(BuildContext context, WidgetRef ref, List<BibleVersion?> versions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Which Bible Version do you read regularly?', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Version', style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              ...versions.asMap().entries.map((entry) {
                final index = entry.key;
                final ver = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: GestureDetector(
                    onTap: () => _showVersionPicker(context, ref, index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.grey.shade300)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(ver?.name ?? 'Select Version', style: TextStyle(color: ver != null ? AppColors.textPrimary : Colors.grey)),
                          const Icon(Icons.arrow_drop_down, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              GestureDetector(
                onTap: () {
                  ref.read(expertiseVersionsProvider.notifier).state = [...versions, null];
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.grey.shade300)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_circle_outline, color: AppColors.textPrimary, size: 20),
                      SizedBox(width: 8),
                      Text('Add another version', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEducationSection(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Enter your educational qualifications', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Education', style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextField(
                controller: _educationController,
                decoration: InputDecoration(
                  hintText: 'e.g., 10th',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide(color: Colors.grey.shade300)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide(color: Colors.grey.shade300)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: const BorderSide(color: AppColors.primary)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAgeSection(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Enter your age', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Age', style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '20',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide(color: Colors.grey.shade300)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide(color: Colors.grey.shade300)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: const BorderSide(color: AppColors.primary)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showLanguagePicker(BuildContext context, WidgetRef ref, int index) {
    // Assuming languageListProvider has fetched successfully
    final asyncLangs = ref.read(languageListProvider);
    if (asyncLangs is! AsyncData) return;

    final allLangs = asyncLangs.value ?? [];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return ListView.builder(
          itemCount: allLangs.length,
          itemBuilder: (context, i) {
            final lang = allLangs[i];
            return ListTile(
              title: Text(lang.name),
              onTap: () {
                final current = List<Language?>.from(ref.read(expertiseLanguagesProvider));
                current[index] = lang;
                ref.read(expertiseLanguagesProvider.notifier).state = current;
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  void _showVersionPicker(BuildContext context, WidgetRef ref, int index) {
    final asyncVers = ref.read(bibleVersionsListProvider);
    if (asyncVers is! AsyncData) {
      // In case it's loading or not fetched, don't open
      return;
    }

    final allVers = asyncVers.value ?? [];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return ListView.builder(
          itemCount: allVers.length,
          itemBuilder: (context, i) {
            final ver = allVers[i];
            return ListTile(
              title: Text(ver.name),
              onTap: () {
                final current = List<BibleVersion?>.from(ref.read(expertiseVersionsProvider));
                current[index] = ver;
                ref.read(expertiseVersionsProvider.notifier).state = current;
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
