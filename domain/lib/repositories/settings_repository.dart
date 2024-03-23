import '../model/settings/theme_type.dart';

abstract interface class SettingsRepository {
  ThemeType? getThemeType();
  Future<void> updateThemeType(ThemeType themeType);
  Stream<ThemeType?> observeThemeType();
  Future<void> updateLocaleCode(String code);
  Stream<String?> observeLocaleCode();
  Future<void> clearCache();
}
