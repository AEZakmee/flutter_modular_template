import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:domain/services/auth/auth.dart';

class RefreshTokenInterceptor extends Interceptor {
  RefreshTokenInterceptor({
    required Auth auth,
    required Dio dio,
  })  : _auth = auth,
        _dio = dio;

  final Auth _auth;
  final Dio _dio;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      //no refresh at the moment
      await _auth.signOut();

      log('Token expired, refreshing tokens');
      // final newTokens = await _auth.refreshTokens();
      // No implementation for that at the moment.
      final newTokens = null;

      if (newTokens.areValid()) {
        err.requestOptions.headers[HttpHeaders.authorizationHeader] =
            '${newTokens.tokenType} ${newTokens.accessToken}';

        return handler.resolve(await _dio.fetch(err.requestOptions));
      }
    }

    return handler.next(err);
  }
}
