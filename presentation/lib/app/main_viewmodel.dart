import 'package:domain/services/auth.dart';
import 'package:domain/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:utils/let_extension.dart';

import '../controllers/theme_controller.dart';
import '../utils/base_viewmodel.dart';
import '../utils/extensions.dart';

final class MainViewModel extends BaseViewModel {
  MainViewModel({
    required ThemeController themeController,
    required LocalizationService localizationService,
    required Auth auth,
    required GoRouter router,
  })  : _themeController = themeController,
        _localizationService = localizationService,
        _auth = auth,
        _router = router;

  final ThemeController _themeController;
  final LocalizationService _localizationService;
  final Auth _auth;
  final GoRouter _router;

  Locale? _locale;
  Locale? get locale => _locale;

  Brightness _brightness = Brightness.light;
  Brightness get brightness => _brightness;

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
      _router.refresh();
    }).disposeWith(this);
  }
}
