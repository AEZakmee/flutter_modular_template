import '../model/cocktail/cocktail_list.dart';
import '../model/handler/data_response.dart';

abstract interface class CocktailsRepository {
  Future<DataResponse<CocktailList>> fetchAllCocktails();
}
