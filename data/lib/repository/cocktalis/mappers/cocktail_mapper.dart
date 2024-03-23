import 'package:domain/model/cocktails/cocktail.dart';

import '../../../cache/model/cocktails/cocktail_cache.dart';
import '../../../source/model/cocktails/cocktail_response.dart';

extension CocktailResponseMapper on CocktailResponse {
  Cocktail toDomain() => Cocktail(
        id: idDrink,
        title: strDrink ?? '',
        favorite: false,
      );
}

extension CocktailCacheMapper on CocktailCache {
  Cocktail toDomain() => Cocktail(
        id: id,
        title: title,
        favorite: favorite,
      );
}

extension CocktailMapper on Cocktail {
  CocktailCache toCache() => CocktailCache(
        id: id,
        title: title,
        favorite: favorite,
      );
}
