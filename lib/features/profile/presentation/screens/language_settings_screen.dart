import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/language_settings_provider.dart';
import '../../../language_selection/data/models/language_model.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LanguageSettingsScreen extends ConsumerStatefulWidget {
  const LanguageSettingsScreen({super.key});

  @override
  ConsumerState<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends ConsumerState<LanguageSettingsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(languageSettingsProvider);
    final notifier = ref.read(languageSettingsProvider.notifier);

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
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16),
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Language Settings',
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
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
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      child: state.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : state.error != null
                              ? Center(child: Text('Error: ${state.error}'))
                              : SingleChildScrollView(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Search to add language',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: const Color(0xFF666666),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      _buildSearchField(state, notifier),
                                      
                                      if (state.searchResults.isNotEmpty) ...[
                                        const SizedBox(height: 12),
                                        _buildSearchResults(state, notifier),
                                      ],
                                      
                                      const SizedBox(height: 32),
                                      
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Selected language',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: const Color(0xFF666666),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              notifier.removeAllNonPrimary();
                                            },
                                            child: const Icon(
                                              Icons.delete_outline,
                                              color: Color(0xFFEF4444), // Red color
                                              size: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      
                                      ...state.selectedLanguages.map((lang) {
                                        final isPrimary = lang.code == state.primaryLanguageCode;
                                        return _buildLanguageCard(context, lang, isPrimary, notifier);
                                      }).toList(),
                                    ].animate(interval: 50.ms).fade(duration: 400.ms, curve: Curves.easeOutCubic).slideY(begin: 0.05, end: 0.0, curve: Curves.easeOutCubic),
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

  Widget _buildSearchField(LanguageSettingsState state, LanguageSettingsNotifier notifier) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (val) {
          notifier.updateSearchQuery(val);
        },
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: 'ex. Hindi',
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          suffixIcon: Icon(
            Icons.search,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults(LanguageSettingsState state, LanguageSettingsNotifier notifier) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: state.searchResults.map((lang) {
          return ListTile(
            title: Text(
              lang.nativeName,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              lang.name,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
            trailing: const Icon(Icons.add_circle_outline, color: Color(0xFF1E3A8A)),
            onTap: () {
              notifier.addLanguage(lang);
              _searchController.clear();
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLanguageCard(
    BuildContext context, 
    LanguageModel lang, 
    bool isPrimary, 
    LanguageSettingsNotifier notifier,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              lang.nativeName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              notifier.setPrimaryLanguage(lang.code);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isPrimary ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                  color: isPrimary ? const Color(0xFF1E3A8A) : Colors.grey.shade400,
                  size: 20,
                ),
                const SizedBox(width: 6),
                Text(
                  'Primary',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Icon(
            Icons.keyboard_arrow_down,
            color: Theme.of(context).textTheme.bodyLarge?.color,
            size: 20,
          ),
        ],
      ),
    );
  }
}
