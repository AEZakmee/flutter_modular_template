import 'package:flutter/material.dart';

import 'app_colors.dart';

const fontFamily = 'Roboto';

class AppTheme {
  AppTheme({
    required Brightness brightness,
  }) : _brightness = brightness;

  final Brightness _brightness;

  ThemeData get theme => ThemeData(
        fontFamily: fontFamily,
        extensions: <ThemeExtension<dynamic>>[
          _colors,
        ],
        primaryColor: _colors.primaryColor,
        colorScheme: _colorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: _colors.secondaryColor,
        ),
        textTheme: _textTheme,
      );

  AppColors get _colors {
    return switch (_brightness) {
      Brightness.light => AppColors.light(),
      Brightness.dark => AppColors.dark(),
    };
  }

  ColorScheme get _colorScheme {
    return switch (_brightness) {
      Brightness.light => const ColorScheme.light().copyWith(
          secondary: _colors.secondaryColor,
          primary: _colors.primaryColor,
          background: _colors.surfaceColor,
          error: _colors.errorColor,
          brightness: Brightness.light,
        ),
      Brightness.dark => const ColorScheme.dark().copyWith(
          secondary: _colors.secondaryColor,
          primary: _colors.primaryColor,
          background: _colors.surfaceColor,
          error: _colors.errorColor,
          brightness: Brightness.dark,
        ),
    };
  }

  TextTheme get _textTheme => const TextTheme(
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
