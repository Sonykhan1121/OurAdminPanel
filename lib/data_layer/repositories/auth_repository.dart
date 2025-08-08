import '../services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final AuthService _service;

  AuthRepository(this._service);

  Future<User?> login(String email, String password) async {
    final res = await _service.signIn(email, password);
    return res.user;
  }

  Future<User?> register(String email, String password) async {
    final res = await _service.signUp(email, password);
    return res.user;
  }

  Future<User?> getCurrentUser() => _service.getCurrentUser();

  Future<void> logout() => _service.signOut();

  Future<void> sendPasswordReset(String email) =>
      _service.resetPassword(email);

  bool isLoggedIn() => _service.isLoggedIn();
}
