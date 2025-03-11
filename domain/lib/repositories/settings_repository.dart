import '../model/settings/theme_type.dart';

abstract interface class SettingsRepository {
  Future<ThemeType?> getThemeType();
  Future<void> updateThemeType(ThemeType themeType);
  Future<void> updateLocaleCode(String code);
  Future<String?> getLocaleCode();
  Future<void> clearStorageCache();
  void clearHandlerCache();
}
