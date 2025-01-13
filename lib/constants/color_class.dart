// color_class.dart
import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand Colors
  static const Color red = Color(0xFFE60023);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  
  // Light Theme
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF0F0F0);
  static const Color lightPrimary = Color(0xFF000000);
  static const Color lightSecondary = Color(0xFF767676);
  static const Color lightCardBg = Color(0xFFFFFFFF);
  static const Color lightIconColor = Color(0xFF636363);
  static const Color lightDivider = Color(0xFFE0E0E0);
  static const Color lightBorder = Color(0xFFDCDCDC);
  
  // Dark Theme
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkPrimary = Color(0xFFFFFFFF);
  static const Color darkSecondary = Color(0xFFB3B3B3);
  static const Color darkCardBg = Color(0xFF2D2D2D);
  static const Color darkIconColor = Color(0xFFB3B3B3);
  static const Color darkDivider = Color(0xFF3D3D3D);
  static const Color darkBorder = Color(0xFF2D2D2D);
  
  // Common Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA726);
  static const Color info = Color(0xFF2196F3);

  // Shadows
  static final BoxShadow lightShadow = BoxShadow(
    color: black.withOpacity(0.1),
    offset: const Offset(0, 2),
    blurRadius: 4,
  );
  
  static final BoxShadow darkShadow = BoxShadow(
    color: black.withOpacity(0.3),
    offset: const Offset(0, 2),
    blurRadius: 4,
  );
}

// theme_styles.dart
class ThemeStyles {
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      primaryColor: AppColors.red,
      cardColor: AppColors.lightCardBg,
      dividerColor: AppColors.lightDivider,
      iconTheme: const IconThemeData(
        color: AppColors.lightIconColor,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: AppColors.lightPrimary,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: AppColors.lightSecondary,
          fontSize: 14,
        ),
        titleLarge: TextStyle(
          color: AppColors.lightPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      primaryColor: AppColors.red,
      cardColor: AppColors.darkCardBg,
      dividerColor: AppColors.darkDivider,
      iconTheme: const IconThemeData(
        color: AppColors.darkIconColor,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: AppColors.darkPrimary,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: AppColors.darkSecondary,
          fontSize: 14,
        ),
        titleLarge: TextStyle(
          color: AppColors.darkPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}