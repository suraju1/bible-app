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
    ],
  );
});
