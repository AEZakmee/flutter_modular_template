import '../../../domain/model/cocktail/cocktail_list.dart';
import '../../../domain/model/handler/data_response.dart';

abstract interface class CocktailsRepository {
  Future<DataResponse<CocktailList>> fetchAllCocktails();
}
