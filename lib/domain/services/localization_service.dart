import 'dart:io';

import '../../data/repository/settings/settings_repo.dart';

class LocalizationService {
  LocalizationService({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  final SettingsRepository _settingsRepository;

  String get localeCode {
    final String deviceLocaleCode = Platform.localeName.split('_')[0];
    return _settingsRepository.getLocaleCode() ?? deviceLocaleCode;
  }

  Future<void> saveLocaleCode(String code) =>
      _settingsRepository.saveLocaleCode(code);

  Stream<String?> observeLocaleCode() =>
      _settingsRepository.observeLocaleCode();
}
