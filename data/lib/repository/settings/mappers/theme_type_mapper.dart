import 'package:domain/model/settings/theme_type.dart';

import '../../../cache/model/settings/theme_type_cache.dart';

extension ThemeTypeCacheExtensions on ThemeTypeCache {
  ThemeType toDomain() {
    switch (this) {
      case ThemeTypeCache.light:
        return ThemeType.light;
      case ThemeTypeCache.dark:
        return ThemeType.dark;
    }
  }
}

extension ThemeTypeExtensions on ThemeType {
  ThemeTypeCache toCache() {
    switch (this) {
      case ThemeType.light:
        return ThemeTypeCache.light;
      case ThemeType.dark:
        return ThemeTypeCache.dark;
    }
  }
}
