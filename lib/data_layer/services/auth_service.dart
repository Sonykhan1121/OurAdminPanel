import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase;

  AuthService(this._supabase);

  Future<AuthResponse> signUp(String email, String password) {
    return _supabase.auth.signUp(email: email, password: password);
  }

  Future<AuthResponse> signIn(String email, String password) {
    return _supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  Future<User?> getCurrentUser() async {
    final User? user = _supabase.auth.currentSession?.user;
    return user;
  }

  bool isLoggedIn() => _supabase.auth.currentSession != null;
}
