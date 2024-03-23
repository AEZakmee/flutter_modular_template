import '../model/settings/theme_type.dart';
import '../repositories/settings_repository.dart';

class ThemeService {
  ThemeService({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  final SettingsRepository _settingsRepository;

  Future<void> switchTheme({required ThemeType currentTheme}) {
    final newTheme = switch (currentTheme) {
      ThemeType.light => ThemeType.dark,
      ThemeType.dark => ThemeType.light,
    };
    return _settingsRepository.updateThemeType(newTheme);
  }

  ThemeType? getThemeType() => _settingsRepository.getThemeType();

  Stream<ThemeType?> observeThemeType() =>
      _settingsRepository.observeThemeType();
}
