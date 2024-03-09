import '../model/theme_type.dart';

abstract interface class SettingsRepository {
  Future<void> saveThemeType(ThemeType themeType);
  Stream<ThemeType?> observeThemeType();
  Future<void> saveLocaleCode(String code);
  Stream<String?> observeLocaleCode();
}
