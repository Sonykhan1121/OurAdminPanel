import 'package:flutter/material.dart';

class DColors {
  DColors._();

  // 🎯 Primary Theme Colors
  static const Color primary = Color(0xFF000000); // Black primary
  static const Color secondary = Color(0xFFB71C1C); // Deep Red (Redis)
  static const Color accent = Color(0xFFFF5252); // Light Vibrant Red

  // 🔤 Text Colors
  static const Color textPrimary = Colors.white; // White text on black background
  static const Color textSecondary = Color(0xFFB71C1C); // Deep red text
  static const bodyTextColor = Colors.black87; // Black text for light backgrounds
  static const Color textWhite = Colors.white;

  // 🗂️ Card Text Colors
  static const Color cardTextPrimary = Colors.black;
  static const Color cardTextSecondary = Color(0xFFB71C1C);

  // 🎨 Background Colors
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF121212); // Almost black
  static const Color primaryBackground = Color(0xFF000000); // Pure black

  // 🧱 Container Backgrounds
  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color get darkContainer => white.withOpacity(0.05);

  // 🔘 Buttons
  static const Color buttonPrimary = Color(0xFF000000); // Black button
  static const Color buttonSecondary = Color(0xFFB71C1C); // Deep red button
  static const Color textButtonPrimary = Color(0xFFB71C1C); // Red text button
  static const Color buttonDisabled = Color(0xFF9E9E9E);

  // 🛑 Border Colors
  static const Color borderPrimary = Color(0xFF000000); // Black border
  static const Color borderSecondary = Color(0xFFB71C1C); // Red border

  // ⚠️ Status Colors
  static const Color error = Color(0xFFD32F2F); // Error red
  static const Color success = Color(0xFF2E7D32); // Success green
  static const Color warning = Color(0xFFF57C00); // Warning orange
  static const Color info = Color(0xFF1976D2); // Info blue

  // ⚫ Neutral Colors
  static const Color black = Color(0xFF000000);
  static const Color darkerGrey = Color(0xFF2C2C2C);
  static const Color darkGrey = Color(0xFF4F4F4F);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color softGrey = Color(0xFFBDBDBD);
  static const Color lightGrey = Color(0xFFE0E0E0);
  static const Color white = Color(0xFFFFFFFF);
}
