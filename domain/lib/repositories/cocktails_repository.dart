import '../model/cocktails/cocktail.dart';
import '../model/handler/data_response.dart';

abstract interface class CocktailsRepository {
  Stream<Iterable<Cocktail>> observeCocktails();
  DataResponse<Cocktail> getCocktail(String id);
  Future<void> updateCocktail(Cocktail cocktail);
}
