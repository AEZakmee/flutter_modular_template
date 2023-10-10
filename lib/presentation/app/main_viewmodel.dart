import 'package:flutter/material.dart';

import '../../app/model/theme_type.dart';
import '../../app/utils/extensions.dart';
import '../../domain/services/auth_service.dart';
import '../../domain/services/localization_service.dart';
import '../../domain/services/theme_service.dart';
import '../utils/base_viewmodel.dart';
import '../utils/extensions.dart';
import 'router.dart';

enum SupportedLocales {
  en,
  bg,
}

final class MainViewModel extends BaseViewModel {
  MainViewModel({
    required ThemeService themeService,
    required LocalizationService localizationService,
    required Auth auth,
  })  : _themeService = themeService,
        _localizationService = localizationService,
        _auth = auth;

  final ThemeService _themeService;
  final LocalizationService _localizationService;
  final Auth _auth;

  Locale? _locale;
  Locale? get locale => _locale;

  Brightness _brightness = Brightness.light;

  bool _authenticated = false;

  @override
  Future<void> init() async {
    _locale = Locale(_localizationService.localeCode);
    _brightness = _handleBrightnessTheme(_themeService.themeType);
    _authenticated = _auth.isAuthenticated;

    _localizationService.observeLocaleCode().listen((event) {
      event?.let((code) {
        _locale = Locale(code);
        notifyListeners();
      });
    }).disposeWith(this);

    _themeService.observeThemeType().listen((event) {
      event?.let((themeType) {
        _brightness = _handleBrightnessTheme(themeType);
        notifyListeners();
      });
    }).disposeWith(this);

    _auth.observeAuthentication().listen((newAuthStatus) {
      if (_authenticated && !newAuthStatus) {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          Routes.initial,
          (r) => false,
        );
      }
      _authenticated = newAuthStatus;
    }).disposeWith(this);
  }

  bool get isDarkTheme => _brightness == Brightness.dark;

  Future<void> switchTheme() async {
    final newTheme = switch (_brightness) {
      Brightness.light => ThemeType.dark,
      Brightness.dark => ThemeType.light,
    };

    await _themeService.saveThemeType(newTheme);
  }

  Future<void> setLocale(Locale locale) =>
      _localizationService.saveLocaleCode(locale.languageCode);

  List<Locale> getSupportedLocales() => List.generate(
        SupportedLocales.values.length,
        (index) => Locale(SupportedLocales.values[index].name),
      );

  Brightness get _deviceBrightness =>
      WidgetsBinding.instance.platformDispatcher.platformBrightness;

  Brightness _handleBrightnessTheme(ThemeType? themeType) {
    final savedBrightness = themeType?.let(
      (value) => switch (themeType) {
        ThemeType.light => Brightness.light,
        ThemeType.dark => Brightness.dark,
      },
    );
    return savedBrightness ?? _deviceBrightness;
  }
}
