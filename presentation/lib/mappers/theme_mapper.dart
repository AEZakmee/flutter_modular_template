import 'dart:ui';

import 'package:domain/model/settings/theme_type.dart';

extension BrightnessMapper on Brightness {
  ThemeType toThemeType() => switch (this) {
    Brightness.dark => ThemeType.dark,
    Brightness.light => ThemeType.light,
  };
}

extension ThemeTypeMapper on ThemeType {
  Brightness toBrightness() => switch (this) {
    ThemeType.dark => Brightness.dark,
    ThemeType.light => Brightness.light,
  };
}
