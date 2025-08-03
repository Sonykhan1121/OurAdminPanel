import 'package:admin_panel/features/home_page.dart';
import 'package:admin_panel/features/login_page.dart';
import 'package:admin_panel/features/sign_up.dart';
import 'package:admin_panel/features/verifyEmail.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_route_names.dart';



final GoRouter appRouter = GoRouter(
  initialLocation: AppRouteNames.login,
  routes: [
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
