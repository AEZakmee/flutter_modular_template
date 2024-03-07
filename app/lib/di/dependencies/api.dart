import 'dart:developer';

import 'package:data/source/api/api_requests.dart';
import 'package:data/source/api/cocktails/cocktails_api_client.dart';
import 'package:data/source/api/interceptors/auth_interceptor.dart';
import 'package:data/source/api/interceptors/error_interceptor.dart';
import 'package:data/source/api/interceptors/refresh_token_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

import '../../env/environment_reader.dart';
import '../locator.dart';

void api() {
  locator

    ///Api
    ..registerLazySingleton(
      () => Dio(
        BaseOptions(
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
          connectTimeout: const Duration(seconds: 30),
          baseUrl: locator<EnvironmentReader>().baseUrl,
        ),
      ),
    )
    ..registerLazySingleton(
      () => ApiRequests(
        dio: locator()
          ..interceptors.add(
            AuthInterceptor(
              auth: locator(),
            ),
          )
          ..interceptors.add(
            RefreshTokenInterceptor(
              auth: locator(),
              dio: locator(),
            ),
          )
          ..interceptors.add(
            RetryInterceptor(
              dio: locator(),
              logPrint: log,
            ),
          )
          ..interceptors.add(
            ErrorInterceptor(),
          ),
      ),
    )

    //Clients
    ..registerLazySingleton(
      () => CocktailsApiClient(
        requests: locator(),
      ),
    );
}
