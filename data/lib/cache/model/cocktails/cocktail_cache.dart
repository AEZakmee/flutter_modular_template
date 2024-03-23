import 'package:hive/hive.dart';

part 'cocktail_cache.g.dart';

@HiveType(typeId: 10)
class CocktailCache {
  const CocktailCache({
    required this.id,
    required this.title,
    required this.favorite,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final bool favorite;
}
