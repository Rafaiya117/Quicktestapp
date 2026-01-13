import 'package:demo_riverpod/features/auth/view/login_screen.dart';
import 'package:demo_riverpod/features/feedback/feedback.dart';
import 'package:demo_riverpod/features/team/team_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation:'/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LoginScreen() ,
    ),
    GoRoute(
      path: '/team',
      builder: (context, state) => TeamPage() ,
    ),
    GoRoute(
      path: '/feedbacklist',
      builder: (context, state) => Feedbacklist() ,
    ),
  ],
);