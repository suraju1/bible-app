import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/help_support_model.dart';
import '../../data/services/help_center_service.dart';

class HelpCenterState {
  final List<HelpCategoryModel> categories;
  final List<HelpArticleModel> allArticles;
  final List<HelpArticleModel> displayArticles; // Filtered or recent articles
  final bool isSearchActive;

  HelpCenterState({
    this.categories = const [],
    this.allArticles = const [],
    this.displayArticles = const [],
    this.isSearchActive = false,
  });

  HelpCenterState copyWith({
    List<HelpCategoryModel>? categories,
    List<HelpArticleModel>? allArticles,
    List<HelpArticleModel>? displayArticles,
    bool? isSearchActive,
  }) {
    return HelpCenterState(
      categories: categories ?? this.categories,
      allArticles: allArticles ?? this.allArticles,
      displayArticles: displayArticles ?? this.displayArticles,
      isSearchActive: isSearchActive ?? this.isSearchActive,
    );
  }
}

final helpCenterControllerProvider = AsyncNotifierProvider.autoDispose<HelpCenterController, HelpCenterState>(HelpCenterController.new);

class HelpCenterController extends AutoDisposeAsyncNotifier<HelpCenterState> {
  @override
  Future<HelpCenterState> build() async {
    return _fetchData();
  }

  Future<HelpCenterState> _fetchData() async {
    final service = ref.read(helpCenterServiceProvider);
    
    // Fetch categories and articles concurrently
    final results = await Future.wait([
      service.getCategories(),
      service.getArticles(),
    ]);
    
    final categories = results[0] as List<HelpCategoryModel>;
    final articles = results[1] as List<HelpArticleModel>;

    return HelpCenterState(
      categories: categories,
      allArticles: articles,
      displayArticles: articles, // Initially display all (or could slice to recent)
      isSearchActive: false,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchData());
  }

  void search(String query) {
    if (state.value == null) return;
    
    if (query.isEmpty) {
      state = AsyncData(state.value!.copyWith(
        displayArticles: state.value!.allArticles,
        isSearchActive: false,
      ));
      return;
    }

    final lowercaseQuery = query.toLowerCase();
    final filtered = state.value!.allArticles.where((article) {
      return article.title.toLowerCase().contains(lowercaseQuery) ||
             article.content.toLowerCase().contains(lowercaseQuery);
    }).toList();

    state = AsyncData(state.value!.copyWith(
      displayArticles: filtered,
      isSearchActive: true,
    ));
  }
}
