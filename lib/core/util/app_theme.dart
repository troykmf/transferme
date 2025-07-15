import 'package:flutter/material.dart';
import 'package:transferme/core/util/app_color.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.white,
        primary: AppColor.primaryColor,
        secondary: AppColor.secondaryColor,
      ),
      fontFamily: 'Sans Francisco',
      scaffoldBackgroundColor: AppColor.whiteColor,
      appBarTheme: AppBarTheme(backgroundColor: Colors.white),
      useMaterial3: true,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColor.whiteColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(backgroundColor: AppColor.primaryColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
