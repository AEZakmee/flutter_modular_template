import 'dart:io';

import '../repositories/settings_repository.dart';

class LocalizationService {
  LocalizationService({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  final SettingsRepository _settingsRepository;

  Future<void> saveLocaleCode(String code) =>
      _settingsRepository.saveLocaleCode(code);

  Stream<String?> observeLocaleCode() {
    final String deviceLocaleCode = Platform.localeName.split('_')[0];
    return _settingsRepository.observeLocaleCode().map(
          (event) => event ?? deviceLocaleCode,
        );
  }
}
