import 'dart:async';

import 'package:domain/model/settings/theme_type.dart';
import 'package:domain/services/theme_service.dart';
import 'package:flutter/material.dart';

import '../mappers/theme_mapper.dart';

class ThemeController {
  ThemeController({required ThemeService themeService})
    : _themeService = themeService;

  final ThemeService _themeService;

  Stream<Brightness> observeBrightness() => _themeService.manager.stream().map(
    (themeType) => themeType?.toBrightness() ?? _deviceBrightness,
  );

  Future<void> switchBrightness() async =>
      _themeService.switchTheme(currentTheme: await _themeType());

  Future<ThemeType> _themeType() async {
    final savedTheme = await _themeService.manager.fetch();
    return savedTheme ?? _deviceBrightness.toThemeType();
  }

  Brightness get _deviceBrightness =>
      WidgetsBinding.instance.platformDispatcher.platformBrightness;
}
