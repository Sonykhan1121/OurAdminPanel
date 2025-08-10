import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminLocalData {
  static User? user;
  static String? refreshToken;
  static bool adminRemember = false;

  // Load from storage
  static Future<void> initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    adminRemember = prefs.getBool('adminRemember') ?? false;

    String? userJson = prefs.getString('user');
    if (userJson != null) {
      user = User.fromJson(jsonDecode(userJson));
    }

    refreshToken = prefs.getString('refreshToken');

    // Restore session if token exists
    if (refreshToken != null) {
      try {
        final response = await Supabase.instance.client.auth.refreshSession(
            refreshToken!);

        if (response.session != null) {
          user = response.session!.user;
          // Save latest token (it can change)
          await saveAdminData();
        }
      }catch(e)
    {
      await resetAdmin();
    }
    }
  }

  // Save to storage
  static Future<void> saveAdminData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final session = Supabase.instance.client.auth.currentSession;
    if (session != null) {
      prefs.setString('user', jsonEncode(session.user.toJson()));
      prefs.setString('refreshToken', session.refreshToken ?? '');
    }
    prefs.setBool('adminRemember', adminRemember);
  }

  // Clear storage
  static Future<void> resetAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    prefs.remove('refreshToken');
    prefs.remove('adminRemember');
  }
}
