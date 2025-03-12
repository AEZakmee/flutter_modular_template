import 'dart:io';

import 'package:dio/dio.dart';
import 'package:domain/services/auth.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({required Auth auth}) : _auth = auth;

  final Auth _auth;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final bearer = options.headers[HttpHeaders.authorizationHeader] as String?;

    if (bearer == null) {
      final token = await _auth.accessToken();

      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }

    return handler.next(options);
  }
}
