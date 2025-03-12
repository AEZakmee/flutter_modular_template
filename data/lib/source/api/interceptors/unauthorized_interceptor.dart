import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:domain/services/auth.dart';

class UnauthorizedInterceptor extends Interceptor {
  const UnauthorizedInterceptor({required Auth auth}) : _auth = auth;

  final Auth _auth;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    log('Dio error: ${err.response?.statusCode}');
    if (err.response?.statusCode == 401) {
      await _auth.signOut();
    }

    return handler.next(err);
  }
}
