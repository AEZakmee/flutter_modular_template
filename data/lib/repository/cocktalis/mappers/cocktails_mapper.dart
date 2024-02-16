import 'package:domain/model/cocktail/cocktail.dart';
import 'package:domain/model/cocktail/cocktail_list.dart';

import '../../../source/model/cocktails/cocktail_response.dart';
import '../../../source/model/cocktails/cocktails_list_response.dart';

extension CocktailListMapper on CocktailListResponse {
  CocktailList toDomain() => CocktailList(
        drinks: drinks.map((e) => e.toDomain()).toList(),
      );
}

extension CocktailMapper on CocktailResponse {
  Cocktail toDomain() => Cocktail(
        idDrink: idDrink ?? '',
        strDrink: strDrink ?? '',
      );
}
