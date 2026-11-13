import 'package:flutter/material.dart';
import 'app_colors.dart'; // Apni colors wali file import karein

class AppTheme {
  // ---------------- DARK THEME ---------------- //
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.bgDark,
    primaryColor: AppColors.primaryNeonBlue,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryNeonBlue,
      secondary: AppColors.accentPurple,
      surface: AppColors.cardDark,
      background: AppColors.bgDark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.bgDark,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.primaryNeonBlue),
      titleTextStyle: TextStyle(
        color: AppColors.textWhite,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.cardDark,
      elevation: 4,
      shadowColor: AppColors.primaryNeonBlue.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: AppColors.textWhite, fontSize: 32, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: AppColors.textWhite, fontSize: 16),
      bodyMedium: TextStyle(color: AppColors.textGrey, fontSize: 14),
    ),
  );

  // ---------------- LIGHT THEME ---------------- //
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.bgLight,
    primaryColor: AppColors.secondaryDeepBlue,
    colorScheme: const ColorScheme.light(
      primary: AppColors.secondaryDeepBlue,
      secondary: AppColors.primaryNeonBlue,
      surface: AppColors.cardLight,
      background: AppColors.bgLight,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.bgLight,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.secondaryDeepBlue),
      titleTextStyle: TextStyle(
        color: AppColors.textBlack,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.cardLight,
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: AppColors.textBlack, fontSize: 32, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: AppColors.textBlack, fontSize: 16),
      bodyMedium: TextStyle(color: AppColors.textGrey, fontSize: 14),
    ),
  );
}