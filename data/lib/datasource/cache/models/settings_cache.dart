import 'package:hive/hive.dart';

import 'theme_type_cache.dart';

part 'settings_cache.g.dart';

@HiveType(typeId: 1)
class SettingsCache extends HiveObject {
  SettingsCache({this.localeCode, this.themeType});

  @HiveField(0)
  String? localeCode;

  @HiveField(1)
  ThemeTypeCache? themeType;
}
