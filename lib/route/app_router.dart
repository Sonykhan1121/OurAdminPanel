import 'package:admin_panel/features/auth_features/views/forget_password_page.dart';
import 'package:admin_panel/features/auth_features/views/login_page.dart';
import 'package:admin_panel/features/auth_features/views/signUp_page.dart';
import 'package:admin_panel/features/home_features/home_page.dart';
import 'package:admin_panel/features/navigation_features/main_navigation_view.dart';
import 'package:go_router/go_router.dart';

import '../features/intro_features/views/verifyEmail.dart';
import '../features/splash_screen_features/views/admin_splash_screen.dart';
import 'app_route_names.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRouteNames.splash_path, // Change to splash screen
  routes: [
    GoRoute(
      path: AppRouteNames.splash_path,
      name: AppRouteNames.splash,
      builder: (_, __) =>  AdminSplashScreen(), // Add splash route
    ),
    GoRoute(
      path: AppRouteNames.login_path,
      name: AppRouteNames.login,
      builder: (_, __) => const LoginPage(),
    ),
    GoRoute(
      path: AppRouteNames.signUp_path,
      name: AppRouteNames.signUp,
      builder: (_, __) => const SignUpPage(),
    ),
    GoRoute(
      path: AppRouteNames.verifyEmail_path,
      name: AppRouteNames.verifyEmail,
      builder: (_, __) => const Verifyemail(),
    ),
    GoRoute(
      path: AppRouteNames.homePage_path,
      name: AppRouteNames.homePage,
      builder: (_, __) =>  HomePage(),
    ),
    GoRoute(
      path: AppRouteNames.mainNavigationView_path,
      name: AppRouteNames.mainNavigationViewPage,
      builder: (_, __) =>  MainNavigationView(),
    ),
    GoRoute(
      path: AppRouteNames.forget_password_path,
      name: AppRouteNames.forget_password,
      builder: (_, __) => const ForgotPasswordPage(),
    ),
  ],
);