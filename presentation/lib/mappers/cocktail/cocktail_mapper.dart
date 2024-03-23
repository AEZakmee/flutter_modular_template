import 'package:domain/model/cocktails/cocktail.dart';

import '../../model/cocktails/cocktail_ui.dart';

extension CocktailMapper on Cocktail {
  CocktailUI toUI() => CocktailUI(
        id: id,
        title: title,
        favorite: favorite,
      );
}

extension CocktailUIMapper on CocktailUI {
  Cocktail toDomain() => Cocktail(
        id: id,
        title: title,
        favorite: favorite,
      );
}
