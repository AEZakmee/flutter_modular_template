import 'package:flutter/material.dart';

import 'app_colors.dart';

const fontFamily = 'Roboto';

class AppTheme {
  AppTheme({
    AppColors? lightColors,
    AppColors? darkColors,
  })  : _lightColors = lightColors ?? AppColors.light(),
        _darkColors = darkColors = AppColors.dark();

  final AppColors _lightColors;
  final AppColors _darkColors;

  ThemeData get darkTheme => ThemeData(
        fontFamily: fontFamily,
        extensions: <ThemeExtension<dynamic>>[
          _lightColors,
        ],
        primaryColor: _darkColors.primaryColor,
        colorScheme: const ColorScheme.light().copyWith(
          secondary: _darkColors.secondaryColor,
          primary: _darkColors.primaryColor,
          background: _darkColors.surfaceColor,
          error: _darkColors.errorColor,
          brightness: Brightness.light,
        ),
        appBarTheme: AppBarTheme(backgroundColor: _darkColors.surfaceColor),
        textTheme: textTheme,
      );

  ThemeData get lightTheme => ThemeData(
        fontFamily: fontFamily,
        extensions: <ThemeExtension<dynamic>>[
          _lightColors,
        ],
        primaryColor: _lightColors.primaryColor,
        colorScheme: const ColorScheme.light().copyWith(
          secondary: _lightColors.secondaryColor,
          primary: _lightColors.primaryColor,
          background: _lightColors.surfaceColor,
          error: _lightColors.errorColor,
          brightness: Brightness.light,
        ),
        appBarTheme: AppBarTheme(backgroundColor: _lightColors.surfaceColor),
        textTheme: textTheme,
      );

  TextTheme get textTheme => const TextTheme(
        displayLarge: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w700,
          fontFamily: fontFamily,
        ),
        displayMedium: TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.w700,
          fontFamily: fontFamily,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w500,
          fontFamily: fontFamily,
        ),
        titleLarge: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          fontFamily: fontFamily,
        ),
        titleMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w500,
          fontFamily: fontFamily,
        ),
        titleSmall: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          fontFamily: fontFamily,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          fontFamily: fontFamily,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: fontFamily,
        ),
        bodySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: fontFamily,
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: fontFamily,
        ),
        labelMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: fontFamily,
        ),
        labelSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: fontFamily,
        ),
      );
}
