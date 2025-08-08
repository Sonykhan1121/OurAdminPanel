import 'package:flutter/foundation.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data_layer/repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repo;

  AuthViewModel(this._repo);

  bool isLoading = false;
  String? errorMessage;
  User? _currentUser;
  User? get currentUser => _currentUser;

  Future<void> login(String email, String password) async {
    _setLoading(true);
    try {
      _currentUser = await _repo.login(email, password);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    }
    _setLoading(false);
  }

  Future<void> register(String email, String password) async {
    _setLoading(true);
    try {
      _currentUser = await _repo.register(email, password);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    }
    _setLoading(false);
  }

  Future<void> SendPasswordReset(String email) async {
    _setLoading(true);
    try {
      await _repo.sendPasswordReset(email);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    }
    _setLoading(false);
  }
  bool isLoggedIn() {
    return _repo.isLoggedIn();
  }

  Future<void> getCurrentUser() async {
    _setLoading(true);
    try {
      _currentUser = await _repo.getCurrentUser();
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    }
    _setLoading(false);
  }


  Future<void> logout() async {
    await _repo.logout();
    _currentUser = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
