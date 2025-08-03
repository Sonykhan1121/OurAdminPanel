import 'package:admin_panel/route/app_router.dart';

import 'core/env/env.dart';
import 'core/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase with Env values
  await Supabase.initialize(url: Env.SUPABASE_URL, anonKey: Env.SUPABASE_ANON_KEY);

  // Setup dependency injection
  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Admin Panel',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}