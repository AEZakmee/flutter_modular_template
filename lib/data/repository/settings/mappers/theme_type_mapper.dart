import '../../../../domain/model/theme_type.dart';
import '../../../cache/model/theme_type_cache.dart';

extension ThemeTypeCacheExtensions on ThemeTypeCache? {
  ThemeType? toDomain() {
    switch (this) {
      case ThemeTypeCache.light:
        return ThemeType.light;
      case ThemeTypeCache.dark:
        return ThemeType.dark;
      default:
        return null;
    }
  }
}

extension ThemeTypeExtensions on ThemeType? {
  ThemeTypeCache? toCache() {
    switch (this) {
      case ThemeType.light:
        return ThemeTypeCache.light;
      case ThemeType.dark:
        return ThemeTypeCache.dark;
      default:
        return null;
    }
  }
}
