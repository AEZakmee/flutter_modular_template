import 'package:domain/services/auth.dart';
import 'package:domain/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:utils/let_extension.dart';

import '../controllers/theme_controller.dart';
import '../utils/base_viewmodel.dart';
import '../utils/extensions.dart';
import 'router.dart';

final class MainViewModel extends BaseViewModel {
  MainViewModel({
    required ThemeController themeController,
    required LocalizationService localizationService,
    required Auth auth,
  })  : _themeController = themeController,
        _localizationService = localizationService,
        _auth = auth;

  final ThemeController _themeController;
  final LocalizationService _localizationService;
  final Auth _auth;

  Locale? _locale;
  Locale? get locale => _locale;

  Brightness _brightness = Brightness.light;
  Brightness get brightness => _brightness;

  bool _authenticated = false;

  @override
  Future<void> init() async {
    _localizationService.observeLocaleCode().listen((event) {
      event?.let((code) {
        _locale = Locale(code);
        notifyListeners();
      });
    }).disposeWith(this);

    _themeController.observeBrightness().listen((brightness) {
      _brightness = brightness;
      notifyListeners();
    }).disposeWith(this);

    _auth.observeAuthenticated().listen((newAuthStatus) {
      if (_authenticated && !newAuthStatus) {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          Routes.initial,
          (r) => false,
        );
      }
      _authenticated = newAuthStatus;
    }).disposeWith(this);
  }
}
