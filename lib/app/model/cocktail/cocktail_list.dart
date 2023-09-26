import 'cocktail.dart';

class CocktailList {
  const CocktailList({
    required this.drinks,
  });

  factory CocktailList.empty() => const CocktailList(drinks: []);

  final List<Cocktail> drinks;
}
