import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:domain/services/auth.dart';

class RefreshTokenInterceptor extends Interceptor {
  RefreshTokenInterceptor({required Auth auth, required Dio dio})
    : _auth = auth,
      _dio = dio;

  //Auth should have client with different Dio impl. Otherwise stack overflow
  final Auth _auth;
  //This is the dio impl this interceptor is used on
  final Dio _dio;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    //This is not needed for firebase auth, but if custom auth impl it is
    //When using custom authentication
    //New API client is required for authentication only
    //This interceptor should be used only on the other clients, not AUTH
    //Auth -> Auth Repository -> Auth Client -> Dio

    if (err.response?.statusCode == 401) {
      log('Token expired, refreshing tokens');
      // final newTokens = await _auth.refreshTokens();

      // if (newTokens.areValid()) {
      //   err.requestOptions.headers[HttpHeaders.authorizationHeader] =
      //   '${newTokens.tokenType} ${newTokens.accessToken}';
      //
      //   return handler.resolve(await _dio.fetch(err.requestOptions));
      // }
    }

    return handler.next(err);
  }
}
