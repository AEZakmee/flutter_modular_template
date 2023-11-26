import 'package:domain/model/cocktail/cocktail_list.dart';
import 'package:domain/model/handler/data_response.dart';
import 'package:domain/repositories/cocktails_repository.dart';

import '../../datasource/api/cocktails/cocktails_api_client.dart';
import '../handler/extensions.dart';
import '../handler/request_handler.dart';
import 'mappers/cocktails_mapper.dart';

class CocktailsRepositoryImpl implements CocktailsRepository {
  CocktailsRepositoryImpl({
    required CocktailsApiClient cocktailsApiClient,
    required RequestHandler requestHandler,
  })  : _cocktailsApiClient = cocktailsApiClient,
        _requestHandler = requestHandler;

  final CocktailsApiClient _cocktailsApiClient;
  final RequestHandler _requestHandler;

  @override
  Future<DataResponse<CocktailList>> fetchAllCocktails() async {
    final result = await _requestHandler.safeApiCall(
      _cocktailsApiClient.fetchAll,
    );

    return result.toDataResponse((data) => data.toDomain());
  }
}
