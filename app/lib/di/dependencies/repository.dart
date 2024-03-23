import 'package:data/repository/cocktalis/cocktails_repository.dart';
import 'package:data/repository/handler/request_handler.dart';
import 'package:data/repository/settings/settings_repository.dart';
import 'package:domain/repositories/cocktails_repository.dart';
import 'package:domain/repositories/settings_repository.dart';

import '../locator.dart';

void repository() {
  locator

    ///Repository
    ..registerLazySingleton(RequestHandler.new)
    ..registerLazySingleton<CocktailsRepository>(
      () => CocktailsRepositoryImpl(
        cocktailsApiClient: locator(),
        cocktailsAssetClient: locator(),
        cocktailsCacheClient: locator(),
        requestHandler: locator(),
      ),
    )
    ..registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(
        localeCacheClient: locator(),
        themeTypeCacheClient: locator(),
        cacheHandler: locator(),
      ),
    );
}
