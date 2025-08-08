import 'package:admin_panel/features/admin_local_data_features/admin_local_data.dart';
import 'package:admin_panel/route/app_route_names.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/service_locator.dart';
import '../auth_features/view_models/auth_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authProvider = sl<AuthViewModel>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(title: const Text('Home Page')),

      content: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Welcome to the Home Page, ${authProvider.currentUser?.email ?? "Guest"}!',
            style: FluentTheme.of(context).typography.body,
          ),
        ),
      ),
    );
  }
}
