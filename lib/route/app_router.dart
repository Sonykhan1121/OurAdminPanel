import 'package:admin_panel/features/views/home_page.dart';
import 'package:admin_panel/features/views/login_page.dart';
import 'package:admin_panel/features/views/sign_up.dart';
import 'package:admin_panel/features/views/verifyEmail.dart';// Add this import
import 'package:go_router/go_router.dart';

import '../features/views/admin_splash_screen.dart';
import 'app_route_names.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/', // Change to splash screen
  routes: [
    GoRoute(
      path: AppRouteNames.splash,
      name: 'splash',
      builder: (_, __) =>  AdminSplashScreen(), // Add splash route
    ),
    GoRoute(
      path: AppRouteNames.login,
      name: 'login',
      builder: (_, __) => const LoginPage(),
    ),
    GoRoute(
      path: AppRouteNames.signUp,
      name: 'signup',
      builder: (_, __) => const SignUp(),
    ),
    GoRoute(
      path: AppRouteNames.verifyEmail,
      name: 'verifyEmail',
      builder: (_, __) => const Verifyemail(),
    ),
    GoRoute(
      path: AppRouteNames.homePage,
      name: 'home',
      builder: (_, __) => const HomePage(),
    ),
  ],
);