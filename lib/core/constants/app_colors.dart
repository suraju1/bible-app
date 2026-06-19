import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary brand colors
  static const Color primary = Color(0xFF0F4C81); // Classic Blue
  static const Color primaryLight = Color(0xFF4A76A8);
  static const Color primaryDark = Color(0xFF082D4F);

  // Secondary brand colors
  static const Color secondary = Color(0xFFF39C12); // Gold/Orange
  static const Color secondaryLight = Color(0xFFF7C066);

  // Vibrant Brand Colors (Based on Gradient Image)
  static const Color vibrantCyan = Color(0xFF4FB5DF);
  static const Color vibrantIndigo = Color(0xFF221272);

  // Global Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [vibrantCyan, vibrantIndigo],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Background and Surface
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Colors.white;
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Status Colors
  static const Color success = Color(0xFF2ECC71);
  static const Color error = Color(0xFFE74C3C);
  static const Color warning = Color(0xFFF1C40F);
  static const Color info = Color(0xFF3498DB);

  // Text Colors
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);
  static const Color textLight = Colors.white;
  // Theme Guidelines Colors
  // Light Theme
  static const Color lightThemeBackground = Color(0xFFFFFFFF);
  static const Color lightThemeSurface = Color(0xFFF7F8FA);
  static const Color lightThemePrimary = Color(0xFF5A7BFF);
  static const Color lightThemeSecondary = Color(0xFF7ED0FF);
  static const Color lightThemeTextPrimary = Color(0xFF1F2937);
  static const Color lightThemeTextSecondary = Color(0xFF6B7280);

  // Dark Theme
  static const Color darkThemeBackground = Color(0xFF121212);
  static const Color darkThemeSurface = Color(0xFF1E1E1E);
  static const Color darkThemePrimary = Color(0xFF6B8CFF);
  static const Color darkThemeSecondary = Color(0xFF7ED0FF);
  static const Color darkThemeTextPrimary = Color(0xFFFFFFFF);
  static const Color darkThemeTextSecondary = Color(0xFFB0B0B0);
}
