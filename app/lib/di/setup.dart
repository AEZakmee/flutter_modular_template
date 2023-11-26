import 'dart:developer';

import 'package:data/datasource/api/api_requests.dart';
import 'package:data/datasource/api/cocktails/cocktails_api_client.dart';
import 'package:data/datasource/api/interceptors/auth_interceptor.dart';
import 'package:data/datasource/api/interceptors/error_interceptor.dart';
import 'package:data/datasource/cache/answer/answer_cache_client.dart';
import 'package:data/datasource/cache/settings/settings_cache_client.dart';
import 'package:data/datasource/cache/user/user_tokens_cache_client.dart';
import 'package:data/datasource/const/storage_consts.dart';
import 'package:data/repository/answer/answer_repo.dart';
import 'package:data/repository/cocktalis/cocktails_repo.dart';
import 'package:data/repository/handler/request_handler.dart';
import 'package:data/repository/settings/settings_repo.dart';
import 'package:data/repository/user/user_repo.dart';
import 'package:data/storage.dart';
import 'package:dependencies/exposer.dart';
import 'package:domain/repositories/answer_repository.dart';
import 'package:domain/repositories/cocktails_repository.dart';
import 'package:domain/repositories/settings_repository.dart';
import 'package:domain/repositories/user_repository.dart';
import 'package:domain/services/answers_service.dart';
import 'package:domain/services/auth_service.dart';
import 'package:domain/services/localization_service.dart';
import 'package:domain/services/theme_service.dart';
import 'package:domain/usecases/cocktails/fetch_coctails_use_case.dart';
import 'package:presentation/app/main_viewmodel.dart';
import 'package:presentation/home/home_viewmodel.dart';
import 'package:presentation/welcome/welcome_viewmodel.dart';

import 'locator.dart';

Future<void> setupDependencies() async {
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
        auth: locator(),
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

    ///Api Clients
    ..registerLazySingleton(
      () => CocktailsApiClient(
        requests: locator(),
      ),
    )

    ///Cache Clients
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
    ..registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        tokensCacheClient: locator(),
      ),
    )
    ..registerLazySingleton<CocktailsRepository>(
      () => CocktailsRepositoryImpl(
        cocktailsApiClient: locator(),
        requestHandler: locator(),
      ),
    )
    ..registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(
        settingsCacheClient: locator(),
      ),
    )
    ..registerLazySingleton<AnswerRepository>(
      () => AnswerRepositoryImpl(
        answerCacheClient: locator(),
      ),
    )

    ///Services
    ..registerLazySingleton(
      () => Auth(
        userRepository: locator(),
      ),
    )
    ..registerLazySingleton(
      () => ThemeService(
        settingsRepository: locator(),
      ),
    )
    ..registerLazySingleton(
      () => LocalizationService(
        settingsRepository: locator(),
      ),
    )
    ..registerLazySingleton(
      () => AnswersService(
        answerRepository: locator(),
      ),
    )

    ///Use Cases
    ..registerLazySingleton(
      () => FetchCocktailsUseCase(
        cocktailsRepo: locator(),
      ),
    )

    ///View models
    ..registerFactory(
      () => MainViewModel(
        localizationService: locator(),
        themeService: locator(),
        auth: locator(),
      ),
    )
    ..registerFactory(
      () => HomeViewModel(
        fetchCocktailsUseCase: locator(),
        answersService: locator(),
        auth: locator(),
      ),
    )
    ..registerFactory(
      () => WelcomeViewModel(
        auth: locator(),
      ),
    );
}
