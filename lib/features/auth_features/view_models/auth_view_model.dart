import 'package:flutter/foundation.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data_layer/repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repo;

  AuthViewModel(this._repo);

  bool isLoading = false;
  String? errorMessage;
  User? currentUser;

  Future<void> login(String email, String password) async {
    _setLoading(true);
    try {
      currentUser = await _repo.login(email, password);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    }
    _setLoading(false);
  }

  Future<void> register(String email, String password) async {
    _setLoading(true);
    try {
      currentUser = await _repo.register(email, password);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    }
    _setLoading(false);
  }

  Future<void> logout() async {
    await _repo.logout();
    currentUser = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
