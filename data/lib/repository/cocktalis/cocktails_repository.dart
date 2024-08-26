import 'package:domain/model/cocktails/cocktail.dart';
import 'package:domain/model/handler/data_response.dart';
import 'package:domain/repositories/cocktails_repository.dart';
import 'package:domain/utils/extensions.dart';

import '../../cache/cocktails/cocktails_cache_client.dart';
import '../../source/api/cocktails/cocktails_api_client.dart';
import '../../source/assets/cocktails/cocktails_asset_client.dart';
import '../handler/extensions.dart';
import '../handler/request_handler.dart';
import 'mappers/cocktail_mapper.dart';

class CocktailsRepositoryImpl implements CocktailsRepository {
  CocktailsRepositoryImpl({
    required CocktailsApiClient cocktailsApiClient,
    required CocktailsCacheClient cocktailsCacheClient,
    required CocktailsAssetClient cocktailsAssetClient,
    required RequestHandler requestHandler,
  })  : _cocktailsApiClient = cocktailsApiClient,
        _cocktailsCacheClient = cocktailsCacheClient,
        _cocktailsAssetClient = cocktailsAssetClient,
        _requestHandler = requestHandler;

  final CocktailsApiClient _cocktailsApiClient;
  final CocktailsCacheClient _cocktailsCacheClient;
  final CocktailsAssetClient _cocktailsAssetClient;
  final RequestHandler _requestHandler;

  @override
  Stream<Iterable<Cocktail>> observeCocktails() async* {
    yield _cocktailsCacheClient.entries.map((entry) => entry.toDomain());

    await _fetchAndCacheCocktails();

    if (_cocktailsCacheClient.isEmpty()) {
      yield await _fetchFromAssets();
    }

    yield* _cocktailsCacheClient.observeAll().map(
          (data) => data.map((e) => e.toDomain()),
        );
  }

  Future<void> _fetchAndCacheCocktails() async {
    final response = await _requestHandler.safeApiCall(
      _cocktailsApiClient.fetchAll,
    );

    await response
        .toDataResponse((data) => data.drinks.map((e) => e.toDomain()))
        .fold(
      onSuccess: (cocktails) async {
        final existingCocktails = _cocktailsCacheClient.keys;

        final cocktailsToAdd = {
          for (final cocktail in cocktails)
            if (!existingCocktails.contains(cocktail.id))
              cocktail.id: cocktail.toCache(),
        };

        await _cocktailsCacheClient.putAll(cocktailsToAdd);
      },
    );
  }

  Future<Iterable<Cocktail>> _fetchFromAssets() async {
    final cocktails = await _cocktailsAssetClient.fetchAll();
    return cocktails.drinks.map((entry) => entry.toDomain());
  }

  @override
  DataResponse<Cocktail> getCocktail(String id) {
    final data = _cocktailsCacheClient.get(id)?.toDomain();

    return data != null
        ? SuccessfulDataResponse(
            data: _cocktailsCacheClient.get(id)?.toDomain(),
          )
        : FailureDataResponse();
  }

  @override
  Future<void> updateCocktail(Cocktail cocktail) async {
    await _cocktailsCacheClient.put(
      id: cocktail.id,
      data: cocktail.toCache(),
    );
  }
}
