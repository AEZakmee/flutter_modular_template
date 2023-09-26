import '../../app/model/cocktail/cocktail_list.dart';
import '../../app/model/handler/data_response.dart';
import '../../datasource/api/cocktails/cocktails_api_client.dart';
import '../handler/extensions.dart';
import '../handler/request_handler.dart';
import 'mappers/cocktails_mapper.dart';

class CocktailsRepository {
  CocktailsRepository({
    required CocktailsApiClient cocktailsApiClient,
    required RequestHandler requestHandler,
  })  : _cocktailsApiClient = cocktailsApiClient,
        _requestHandler = requestHandler;

  final CocktailsApiClient _cocktailsApiClient;
  final RequestHandler _requestHandler;

  Future<DataResponse<CocktailList>> fetchAllCocktails() async {
    final result = await _requestHandler.safeApiCall(
      _cocktailsApiClient.fetchAll,
    );

    return result.toDataResponse((data) => data.toDomain());
  }
}
