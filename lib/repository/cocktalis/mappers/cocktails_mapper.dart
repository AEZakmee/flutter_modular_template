import '../../../app/model/cocktail/cocktail.dart';
import '../../../app/model/cocktail/cocktail_list.dart';
import '../../../datasource/api/cocktails/models/cocktail_response.dart';
import '../../../datasource/api/cocktails/models/cocktails_list_response.dart';

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
