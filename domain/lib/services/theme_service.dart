import 'package:core/model/theme_type.dart';
import 'package:data/repository/settings/settings_repo.dart';

class ThemeService {
  ThemeService({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  final SettingsRepository _settingsRepository;

  ThemeType? get themeType => _settingsRepository.getThemeType();

  Future<void> saveThemeType(ThemeType themeType) =>
      _settingsRepository.saveThemeType(themeType);

  Stream<ThemeType?> observeThemeType() =>
      _settingsRepository.observeThemeType();
}
