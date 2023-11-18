import 'dart:developer';

import 'package:core/di/locator.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:hive/hive.dart';

import 'datasource/api/api_requests.dart';
import 'datasource/api/cocktails/cocktails_api_client.dart';
import 'datasource/api/interceptors/auth_interceptor.dart';
import 'datasource/api/interceptors/error_interceptor.dart';
import 'datasource/cache/answer/answer_cache_client.dart';
import 'datasource/cache/settings/settings_cache_client.dart';
import 'datasource/cache/user/user_tokens_cache_client.dart';
import 'datasource/const/storage_consts.dart';
import 'repository/answer/answer_repo.dart';
import 'repository/cocktalis/cocktails_repo.dart';
import 'repository/handler/request_handler.dart';
import 'repository/settings/settings_repo.dart';
import 'repository/user/user_repo.dart';
import 'storage.dart';

Future<void> setupData() async {
  await setupStorage();

  locator

    ///Api
    ..registerLazySingleton(
      () => Dio(
        BaseOptions(
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
          connectTimeout: const Duration(seconds: 30),

          ///Should be loaded from env
          baseUrl: 'https://www.thecocktaildb.com/api/json/v1/1/',
        ),
      ),
    )
    ..registerLazySingleton(
      () => RetryInterceptor(
        dio: locator(),
        logPrint: log,
        retryDelays: const [
          Duration(seconds: 1),
          Duration(seconds: 2),
          Duration(seconds: 3),
        ],
        retryableExtraStatuses: {401, 403},
      ),
    )
    ..registerLazySingleton(ErrorInterceptor.new)
    ..registerLazySingleton(
      () => AuthInterceptor(
        tokens: () => locator<UserRepository>().getUserTokens(),
      ),
    )
    ..registerLazySingleton(
      () => ApiRequests(
        dio: locator<Dio>()
          ..interceptors.add(
            locator<AuthInterceptor>(),
          )
          ..interceptors.add(
            locator<ErrorInterceptor>(),
          )
          ..interceptors.add(
            locator<RetryInterceptor>(),
          ),
      ),
    )

    //Api Clients
    ..registerLazySingleton<CocktailsApiClient>(
      () => CocktailsApiClient(
        requests: locator(),
      ),
    )

    //Cache Clients
    ..registerLazySingleton(
      () => UserTokensCacheClient(
        box: Hive.box(StorageConsts.hiveEncryptedStorageKey),
      ),
    )
    ..registerLazySingleton(
      () => SettingsCacheClient(
        box: Hive.box(StorageConsts.hiveStorageKey),
      ),
    )
    ..registerLazySingleton(
      () => AnswerCacheClient(
        box: Hive.box(StorageConsts.hiveAnswerStorageKey),
      ),
    )

    ///Repository
    ..registerLazySingleton(RequestHandler.new)
    ..registerLazySingleton(
      () => UserRepository(
        tokensCacheClient: locator(),
      ),
    )
    ..registerLazySingleton(
      () => CocktailsRepository(
        cocktailsApiClient: locator(),
        requestHandler: locator(),
      ),
    )
    ..registerLazySingleton(
      () => SettingsRepository(
        settingsCacheClient: locator(),
      ),
    )
    ..registerLazySingleton(
      () => AnswerRepository(
        answerCacheClient: locator(),
      ),
    );
}
