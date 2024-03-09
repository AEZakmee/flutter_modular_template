import '../model/theme_type.dart';
import '../repositories/settings_repository.dart';

class ThemeService {
  ThemeService({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  final SettingsRepository _settingsRepository;

  Future<void> saveThemeType(ThemeType themeType) =>
      _settingsRepository.saveThemeType(themeType);

  Stream<ThemeType?> observeThemeType() =>
      _settingsRepository.observeThemeType();
}
