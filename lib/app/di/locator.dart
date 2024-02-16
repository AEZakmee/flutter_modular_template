import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../data/cache/answer/answer_cache_client.dart';
import '../../data/cache/settings/settings_cache_client.dart';
import '../../data/cache/user/user_tokens_cache_client.dart';
import '../../data/constants/storage_consts.dart';
import '../../data/handler/request_handler.dart';
import '../../data/repository/answer/answer_repo.dart';
import '../../data/repository/cocktalis/cocktails_repo.dart';
import '../../data/repository/cocktalis/local_cocktails_repo.dart';
import '../../data/repository/cocktalis/remote_cocktails_repo.dart';
import '../../data/repository/settings/settings_repo.dart';
import '../../data/repository/user/user_repo.dart';
import '../../data/source/api/api_requests.dart';
import '../../data/source/api/cocktails/cocktails_api_client.dart';
import '../../data/source/api/interceptors/auth_interceptor.dart';
import '../../data/source/api/interceptors/error_interceptor.dart';
import '../../data/source/assets/cocktails/cocktails_asset_client.dart';
import '../../domain/constants/remote_config_constants.dart';
import '../../domain/model/api_type.dart';
import '../../domain/model/login_type.dart';
import '../../domain/services/answers_service.dart';
import '../../domain/services/auth/auth.dart';
import '../../domain/services/auth/custom_auth_impl.dart';
import '../../domain/services/auth/firebase_auth_impl.dart';
import '../../domain/services/localization_service.dart';
import '../../domain/services/remote_config.dart';
import '../../domain/services/theme_service.dart';
import '../../domain/usecases/cocktails/fetch_coctails_use_case.dart';
import '../../firebase_options.dart';
import '../../presentation/app/main_viewmodel.dart';
import '../../presentation/home/home_viewmodel.dart';
import '../../presentation/welcome/welcome_viewmodel.dart';
import 'storage.dart';

final locator = GetIt.instance;

Future<void> setupDependencies() async {
  await setupStorage();

  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  locator
    ..registerLazySingleton(() => app)
    ..registerLazySingleton(
      () => FirebaseRemoteConfig.instanceFor(
        app: locator(),
      ),
    )
    ..registerLazySingleton(
      () => FirebaseAuth.instanceFor(
        app: locator(),
      ),
    )
    ..registerLazySingleton(
      () => FirebaseAnalytics.instanceFor(
        app: locator(),
      ),
    );

  await locator<FirebaseRemoteConfig>().setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 12),
    ),
  );
  await locator<FirebaseRemoteConfig>().setDefaults({
    RemoteConfigConsts.loginType: LoginType.custom.id,
    RemoteConfigConsts.apiType: ApiType.local.id,
  });
  await locator<FirebaseRemoteConfig>().fetchAndActivate();

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

    //Asset Clients
    ..registerLazySingleton(
      CocktailsAssetClient.new,
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
      () => RemoteConfig(
        firebaseRemoteConfig: locator(),
      ),
    )
    ..registerLazySingleton<Auth>(() {
      return switch (locator<RemoteConfig>().loginType) {
        LoginType.custom => CustomAuthImpl(
            userRepository: locator(),
          ),
        LoginType.firebase => FirebaseAuthImpl(
            firebaseAuth: locator(),
          )
      };
    })
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
