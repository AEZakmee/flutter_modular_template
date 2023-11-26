import '../model/theme_type.dart';

abstract interface class SettingsRepository {
  Future<void> saveThemeType(ThemeType themeType);
  ThemeType? getThemeType();
  Stream<ThemeType?> observeThemeType();
  Future<void> saveLocaleCode(String code);
  String? getLocaleCode();
  Stream<String?> observeLocaleCode();
}
