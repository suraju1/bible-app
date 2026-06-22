import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/language_selection/presentation/screens/language_selection_screen.dart';
import '../../features/expertise_selection/presentation/screens/expertise_selection_screen.dart';
import '../../features/auth/presentation/screens/auth_selection_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/home_dashboard/presentation/screens/home_screen.dart';
import '../../features/home_dashboard/presentation/screens/quiz_categories_screen.dart';
import '../../features/notifications/presentation/screens/notification_screen.dart';
import '../../features/challenge_group/presentation/screens/battles_screen.dart';
import '../../features/challenge_group/presentation/screens/create_group_screen.dart';
import '../../features/challenge_group/presentation/screens/group_action_screen.dart';
import '../../features/challenge_group/presentation/screens/group_details_screen.dart';
import '../../features/challenge_group/presentation/screens/group_leaderboard_screen.dart';
import '../../features/translate_quiz/presentation/screens/translate_quiz_list_screen.dart';
import '../../features/translate_quiz/presentation/screens/translate_form_screen.dart';
import '../../features/correction_quiz/presentation/screens/correction_quiz_list_screen.dart';
import '../../features/correction_quiz/presentation/screens/correction_form_screen.dart';
import '../../features/play_quiz/presentation/screens/quiz_mode_selection_screen.dart';
import '../../features/play_quiz/presentation/screens/quiz_type_selection_screen.dart';
import '../../features/play_quiz/presentation/screens/play_quiz_screen.dart';
import '../../features/create_quiz/presentation/screens/create_quiz_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/placeholders.dart';
import '../../features/profile/presentation/screens/my_profile_screen.dart';
import '../../features/profile/presentation/screens/achievements_screen.dart';
import '../../features/profile/presentation/screens/rewards_screen.dart';
import '../../features/profile/presentation/screens/quiz_history_screen.dart';
import '../../features/profile/presentation/screens/quiz_history_details_screen.dart';
import '../../features/profile/presentation/screens/referral_screen.dart';
import '../../features/profile/presentation/screens/theme_settings_screen.dart';
import '../../features/profile/presentation/screens/notification_settings_screen.dart';
import '../../features/profile/presentation/screens/language_settings_screen.dart';
import '../../features/profile/presentation/screens/help_support_screen.dart';
import '../../features/profile/presentation/screens/help_support_destinations.dart';
import '../../features/profile/presentation/screens/feedback_screen.dart';
import '../../features/profile/presentation/screens/faq_screen.dart';
import '../../features/profile/presentation/screens/report_issue_screen.dart';
import '../../features/profile/presentation/screens/help_center_screen.dart';
import '../../features/profile/presentation/screens/help_article_details_screen.dart';
import '../../features/profile/domain/models/help_support_model.dart';
import '../../features/profile/presentation/screens/terms_conditions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

CustomTransitionPage<T> buildPageWithTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child
          .animate(key: ValueKey(state.pageKey))
          .fade(duration: 300.ms, curve: Curves.easeOutCubic)
          .slideX(begin: 0.05, end: 0.0, duration: 300.ms, curve: Curves.easeOutCubic);
    },
  );
}

// Provide the GoRouter instance
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(), // Splash usually doesn't need slide transition from nothing
      ),
      GoRoute(
        path: '/language-selection',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const LanguageSelectionScreen()),
      ),
      GoRoute(
        path: '/expertise-selection',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const ExpertiseSelectionScreen()),
      ),
      GoRoute(
        path: '/auth-selection',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const AuthSelectionScreen()),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const LoginScreen()),
      ),
      GoRoute(
        path: '/sign-up',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const SignUpScreen()),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const HomeScreen()),
      ),
      GoRoute(
        path: '/quiz-categories',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const QuizCategoriesScreen()),
      ),
      GoRoute(
        path: '/notifications',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const NotificationScreen()),
      ),
      GoRoute(
        path: '/battles',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const BattlesScreen()),
      ),
      GoRoute(
        path: '/create-group',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const CreateGroupScreen()),
      ),
      GoRoute(
        path: '/group-action/:id',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: GroupActionScreen(groupId: state.pathParameters['id']!)),
      ),
      GoRoute(
        path: '/group-details/:id',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: GroupDetailsScreen(groupId: state.pathParameters['id']!)),
      ),
      GoRoute(
        path: '/group-leaderboard/:id',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: GroupLeaderboardScreen(groupId: state.pathParameters['id']!)),
      ),
      GoRoute(
        path: '/translate-quiz-list',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const TranslateQuizListScreen()),
      ),
      GoRoute(
        path: '/translate-form/:id',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: TranslateFormScreen(taskId: state.pathParameters['id']!)),
      ),
      GoRoute(
        path: '/correction-quiz-list',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const CorrectionQuizListScreen()),
      ),
      GoRoute(
        path: '/correction-form/:id',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: CorrectionFormScreen(taskId: state.pathParameters['id']!)),
      ),
      GoRoute(
        path: '/quiz-mode-selection',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const QuizModeSelectionScreen()),
      ),
      GoRoute(
        path: '/quiz-type-selection',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const QuizTypeSelectionScreen()),
      ),
      GoRoute(
        path: '/play-quiz',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const PlayQuizScreen()),
      ),
      GoRoute(
        path: '/create-quiz',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const CreateQuizScreen()),
      ),
      GoRoute(
        path: '/profile/my-profile',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const MyProfileScreen()),
      ),
      GoRoute(
        path: '/profile/achievements',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const AchievementsScreen()),
      ),
      GoRoute(
        path: '/profile/rewards',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const RewardsScreen()),
      ),
      GoRoute(
        path: '/profile/history',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const QuizHistoryScreen()),
      ),
      GoRoute(
        path: '/profile/history-details/:id',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: QuizHistoryDetailsScreen(quizId: state.pathParameters['id']!)),
      ),
      GoRoute(
        path: '/profile/referral',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const ReferralScreen()),
      ),
      GoRoute(
        path: '/profile/theme',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const ThemeSettingsScreen()),
      ),
      GoRoute(
        path: '/profile/notifications',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const NotificationSettingsScreen()),
      ),
      GoRoute(
        path: '/profile/language',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const LanguageSettingsScreen()),
      ),
      GoRoute(
        path: '/profile/help',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const HelpSupportScreen()),
      ),
      GoRoute(
        path: '/profile/help/faq',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const FaqScreen()),
      ),
      GoRoute(
        path: '/profile/help/report-issue',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const ReportIssueScreen()),
      ),
      GoRoute(
        path: '/profile/help/feedback',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const FeedbackScreen()),
      ),
      GoRoute(
        path: '/profile/help/help-center',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const HelpCenterScreen()),
      ),
      GoRoute(
        path: '/profile/help/article',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: HelpArticleDetailsScreen(article: state.extra as HelpArticleModel)),
      ),
      GoRoute(
        path: '/profile/support',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const HelpSupportScreen()),
      ),
      GoRoute(
        path: '/profile/terms',
        pageBuilder: (context, state) => buildPageWithTransition(context: context, state: state, child: const TermsConditionsScreen()),
      ),
    ],
  );
});
