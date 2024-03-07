import 'package:data/repository/answer/answer_repo.dart';
import 'package:data/repository/cocktalis/local_cocktails_repo.dart';
import 'package:data/repository/cocktalis/remote_cocktails_repo.dart';
import 'package:data/repository/handler/request_handler.dart';
import 'package:data/repository/settings/settings_repo.dart';
import 'package:data/repository/user/user_repo.dart';
import 'package:domain/model/api_type.dart';
import 'package:domain/repositories/answer_repository.dart';
import 'package:domain/repositories/cocktails_repository.dart';
import 'package:domain/repositories/settings_repository.dart';
import 'package:domain/repositories/user_repository.dart';
import 'package:domain/services/remote_config.dart';

import '../locator.dart';

void repository() {
  locator

    ///Repository
    ..registerLazySingleton(RequestHandler.new)
    ..registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        tokensCacheClient: locator(),
      ),
    )
    ..registerLazySingleton<CocktailsRepository>(() {
      return switch (locator<RemoteConfig>().apiType) {
        ApiType.local => LocalCocktailsRepository(
            cocktailsAssetClient: locator(),
          ),
        ApiType.remote => RemoteCocktailsRepository(
            cocktailsApiClient: locator(),
            requestHandler: locator(),
          )
      };
    })
    ..registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(
        settingsCacheClient: locator(),
      ),
    )
    ..registerLazySingleton<AnswerRepository>(
      () => AnswerRepositoryImpl(
        answerCacheClient: locator(),
      ),
    );
}
