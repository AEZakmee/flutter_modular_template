import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  AppColors({
    required this.primaryColor,
    required this.secondaryColor,
    required this.errorColor,
    required this.surfaceColor,
    required this.borderColor,
    required this.textColor,
  });

  factory AppColors.light() => AppColors(
        primaryColor: Colors.blue,
        secondaryColor: Colors.green,
        errorColor: Colors.red,
        surfaceColor: Colors.white,
        borderColor: Colors.grey,
        textColor: Colors.black,
      );

  factory AppColors.dark() => AppColors(
        primaryColor: Colors.lightBlue,
        secondaryColor: Colors.lightGreen,
        errorColor: Colors.redAccent,
        surfaceColor: Colors.black,
        borderColor: Colors.black12,
        textColor: Colors.white,
      );

  final Color? primaryColor;
  final Color? secondaryColor;

  final Color? errorColor;

  final Color? surfaceColor;
  final Color? borderColor;

  final Color? textColor;

  @override
  ThemeExtension<AppColors> copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? errorColor,
    Color? surfaceColor,
    Color? borderColor,
    Color? textColor,
  }) =>
      AppColors(
        primaryColor: primaryColor ?? this.primaryColor,
        secondaryColor: secondaryColor ?? this.secondaryColor,
        errorColor: errorColor ?? this.errorColor,
        surfaceColor: surfaceColor ?? this.surfaceColor,
        borderColor: borderColor ?? this.borderColor,
        textColor: textColor ?? this.textColor,
      );

  @override
  ThemeExtension<AppColors> lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t),
      errorColor: Color.lerp(errorColor, other.errorColor, t),
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      textColor: Color.lerp(textColor, other.textColor, t),
    );
  }
}
