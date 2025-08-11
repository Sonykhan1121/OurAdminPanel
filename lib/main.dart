import 'package:admin_panel/features/admin_local_data_features/admin_local_data.dart';
import 'package:admin_panel/features/auth_features/view_models/supabase_view_model.dart';
import 'package:admin_panel/route/app_router.dart';
import 'package:admin_panel/utils/constants/app_texts.dart';
import 'package:admin_panel/utils/theme/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'core/env/env.dart';
import 'core/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/auth_features/view_models/auth_view_model.dart';
import 'features/service_features/view_models/service_view_model.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase with Env values
  await Supabase.initialize(url: Env.SUPABASE_URL, anonKey: Env.SUPABASE_ANON_KEY);

  // Setup dependency injection
  await initDependencies();
  await AdminLocalData.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>sl<AuthViewModel>()),
        ChangeNotifierProvider(create: (_)=>sl<SupabaseViewModel>()),
        ChangeNotifierProvider(create: (_)=>ServiceViewModel()),

      ],
      child: FluentApp.router(
        title: AppTexts.appName,
        debugShowCheckedModeBanner: false,
        theme: DAppTheme.lightTheme,
        routerConfig: appRouter,

      ),
    );
  }
}