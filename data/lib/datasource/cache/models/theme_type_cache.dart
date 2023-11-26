import 'package:dependencies/exposer.dart';

part 'theme_type_cache.g.dart';

@HiveType(typeId: 2)
enum ThemeTypeCache {
  @HiveField(0)
  light,
  @HiveField(1)
  dark
}
