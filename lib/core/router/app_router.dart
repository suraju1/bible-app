import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/language_selection/presentation/screens/language_selection_screen.dart';
import '../../features/expertise_selection/presentation/screens/expertise_selection_screen.dart';
import '../../features/auth/presentation/screens/auth_selection_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/home_dashboard/presentation/screens/home_screen.dart';
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
import '../../features/profile/presentation/screens/terms_conditions_screen.dart';

// Provide the GoRouter instance
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/language-selection',
        builder: (context, state) => const LanguageSelectionScreen(),
      ),
      GoRoute(
        path: '/expertise-selection',
        builder: (context, state) => const ExpertiseSelectionScreen(),
      ),
      GoRoute(
        path: '/auth-selection',
        builder: (context, state) => const AuthSelectionScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/sign-up',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: '/battles',
        builder: (context, state) => const BattlesScreen(),
      ),
      GoRoute(
        path: '/create-group',
        builder: (context, state) => const CreateGroupScreen(),
      ),
      GoRoute(
        path: '/group-action/:id',
        builder: (context, state) => GroupActionScreen(groupId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/group-details/:id',
        builder: (context, state) => GroupDetailsScreen(groupId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/group-leaderboard/:id',
        builder: (context, state) => GroupLeaderboardScreen(groupId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/translate-quiz-list',
        builder: (context, state) => const TranslateQuizListScreen(),
      ),
      GoRoute(
        path: '/translate-form/:id',
        builder: (context, state) => TranslateFormScreen(taskId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/correction-quiz-list',
        builder: (context, state) => const CorrectionQuizListScreen(),
      ),
      GoRoute(
        path: '/correction-form/:id',
        builder: (context, state) => CorrectionFormScreen(taskId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/quiz-mode-selection',
        builder: (context, state) => const QuizModeSelectionScreen(),
      ),
      GoRoute(
        path: '/quiz-type-selection',
        builder: (context, state) => const QuizTypeSelectionScreen(),
      ),
      GoRoute(
        path: '/play-quiz',
        builder: (context, state) => const PlayQuizScreen(),
      ),
      GoRoute(
        path: '/create-quiz',
        builder: (context, state) => const CreateQuizScreen(),
      ),
      GoRoute(
        path: '/profile/my-profile',
        builder: (context, state) => const MyProfileScreen(),
      ),
      GoRoute(
        path: '/profile/achievements',
        builder: (context, state) => const AchievementsScreen(),
      ),
      GoRoute(
        path: '/profile/rewards',
        builder: (context, state) => const RewardsScreen(),
      ),
      GoRoute(
        path: '/profile/history',
        builder: (context, state) => const QuizHistoryScreen(),
      ),
      GoRoute(
        path: '/profile/history-details/:id',
        builder: (context, state) => QuizHistoryDetailsScreen(quizId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/profile/referral',
        builder: (context, state) => const ReferralScreen(),
      ),
      GoRoute(
        path: '/profile/theme',
        builder: (context, state) => const ThemeSettingsScreen(),
      ),
      GoRoute(
        path: '/profile/notifications',
        builder: (context, state) => const NotificationSettingsScreen(),
      ),
      GoRoute(
        path: '/profile/language',
        builder: (context, state) => const LanguageSettingsScreen(),
      ),
      GoRoute(
        path: '/profile/help',
        builder: (context, state) => const HelpSupportScreen(),
      ),
      GoRoute(
        path: '/profile/help/faq',
        builder: (context, state) => const FaqScreen(),
      ),
      GoRoute(
        path: '/profile/help/report-issue',
        builder: (context, state) => const ReportIssueScreen(),
      ),
      GoRoute(
        path: '/profile/help/feedback',
        builder: (context, state) => const FeedbackScreen(),
      ),
      GoRoute(
        path: '/profile/help/help-center',
        builder: (context, state) => const HelpCenterScreen(),
      ),
      GoRoute(
        path: '/profile/support',
        builder: (context, state) => const HelpSupportScreen(),
      ),
      GoRoute(
        path: '/profile/terms',
        builder: (context, state) => const TermsConditionsScreen(),
      ),
    ],
  );
});
