import 'package:domain/model/settings/theme_type.dart';

extension ThemeTypeCacheExtensions on String? {
  ThemeType? toThemeType() {
    switch (this) {
      case 'light':
        return ThemeType.light;
      case 'dark':
        return ThemeType.dark;
      default:
        return null;
    }
  }
}
