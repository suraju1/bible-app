import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import 'text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: GoogleFonts.poppins().fontFamily,
      brightness: Brightness.light,
      primaryColor: AppColors.lightThemePrimary,
      scaffoldBackgroundColor: AppColors.lightThemeBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.lightThemePrimary,
        secondary: AppColors.lightThemeSecondary,
        surface: AppColors.lightThemeSurface,
        background: AppColors.lightThemeBackground,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.lightThemeTextPrimary,
        onBackground: AppColors.lightThemeTextPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightThemeBackground,
        foregroundColor: AppColors.lightThemeTextPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: ThemeData.light().textTheme
          .copyWith(
            displayLarge: AppTextStyles.heading1.copyWith(
              color: AppColors.lightThemeTextPrimary,
            ),
            displayMedium: AppTextStyles.heading2.copyWith(
              color: AppColors.lightThemeTextPrimary,
            ),
            bodyLarge: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.lightThemeTextPrimary,
            ),
            bodyMedium: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.lightThemeTextSecondary,
            ),
          )
          .apply(
            fontFamily: GoogleFonts.poppins().fontFamily,
            bodyColor: AppColors.lightThemeTextPrimary,
            displayColor: AppColors.lightThemeTextPrimary,
          ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: GoogleFonts.poppins().fontFamily,
      brightness: Brightness.dark,
      primaryColor: AppColors.darkThemePrimary,
      scaffoldBackgroundColor: AppColors.darkThemeBackground,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.darkThemePrimary,
        secondary: AppColors.darkThemeSecondary,
        surface: AppColors.darkThemeSurface,
        background: AppColors.darkThemeBackground,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: AppColors.darkThemeTextPrimary,
        onBackground: AppColors.darkThemeTextPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkThemeBackground,
        foregroundColor: AppColors.darkThemeTextPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: ThemeData.dark().textTheme
          .copyWith(
            displayLarge: AppTextStyles.heading1.copyWith(
              color: AppColors.darkThemeTextPrimary,
            ),
            displayMedium: AppTextStyles.heading2.copyWith(
              color: AppColors.darkThemeTextPrimary,
            ),
            bodyLarge: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.darkThemeTextPrimary,
            ),
            bodyMedium: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkThemeTextSecondary,
            ),
          )
          .apply(
            fontFamily: GoogleFonts.poppins().fontFamily,
            bodyColor: AppColors.darkThemeTextPrimary,
            displayColor: AppColors.darkThemeTextPrimary,
          ),
    );
  }
}
