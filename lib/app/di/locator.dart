import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../datasource/api/api_requests.dart';
import '../../datasource/api/cocktails/cocktails_api_client.dart';
import '../../datasource/api/interceptors/auth_interceptor.dart';
import '../../datasource/api/interceptors/error_interceptor.dart';
import '../../datasource/cache/answer/answer_cache_client.dart';
import '../../datasource/cache/settings/settings_cache_client.dart';
import '../../datasource/cache/user/user_tokens_cache_client.dart';
import '../../domain/services/answers_service.dart';
import '../../domain/services/auth_service.dart';
import '../../domain/services/localization_service.dart';
import '../../domain/services/theme_service.dart';
import '../../domain/usecases/cocktails/fetch_coctails_use_case.dart';
import '../../presentation/app/main_viewmodel.dart';
import '../../presentation/home/home_viewmodel.dart';
import '../../presentation/welcome/welcome_viewmodel.dart';
import '../../repository/answer/answer_repo.dart';
import '../../repository/cocktalis/cocktails_repo.dart';
import '../../repository/handler/request_handler.dart';
import '../../repository/settings/settings_repo.dart';
import '../../repository/user/user_repo.dart';
import '../constants/storage_consts.dart';

final locator = GetIt.instance;

void setup() {
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
    ..registerLazySingleton(
      () => AuthInterceptor(
        auth: locator(),
      ),
    )
    ..registerLazySingleton(ErrorInterceptor.new)
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

    //Use Cases
    ..registerLazySingleton(
      () => FetchCocktailsUseCase(
        cocktailsRepo: locator(),
      ),
    )

    ///Presentation
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
