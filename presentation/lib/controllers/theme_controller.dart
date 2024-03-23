import 'dart:async';

import 'package:domain/model/settings/theme_type.dart';
import 'package:domain/services/theme_service.dart';
import 'package:flutter/material.dart';

import '../mappers/theme_mapper.dart';

class ThemeController {
  ThemeController({
    required ThemeService themeService,
  }) : _themeService = themeService;

  final ThemeService _themeService;

  Stream<Brightness> observeBrightness() =>
      _themeService.observeThemeType().map(
            (themeType) => themeType?.toBrightness() ?? _deviceBrightness,
          );

  Future<void> switchBrightness() => _themeService.switchTheme(
        currentTheme: _themeType,
      );

  ThemeType get _themeType =>
      _themeService.getThemeType() ?? _deviceBrightness.toThemeType();

  Brightness get _deviceBrightness =>
      WidgetsBinding.instance.platformDispatcher.platformBrightness;
}
