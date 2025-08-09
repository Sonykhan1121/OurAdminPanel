import 'package:admin_panel/data_layer/repositories/supabase_repository.dart';
import 'package:admin_panel/data_layer/services/supabase_services.dart';
import 'package:admin_panel/features/auth_features/view_models/supabase_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data_layer/services/auth_service.dart';
import '../../data_layer/repositories/auth_repository.dart';
import '../../features/auth_features/view_models/auth_view_model.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  // Services
  sl.registerLazySingleton<AuthService>(() => AuthService(sl()));
  sl.registerLazySingleton<SupabaseService>(() => SupabaseService(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(sl()));
  sl.registerLazySingleton<SupabaseRepository>(() => SupabaseRepository(sl()));

  // ViewModels
  sl.registerFactory<AuthViewModel>(() => AuthViewModel(sl()));
  sl.registerFactory<SupabaseViewModel>(()=>SupabaseViewModel(sl()));
}
