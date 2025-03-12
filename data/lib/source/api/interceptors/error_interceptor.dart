import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../exceptions/backend_exception.dart';
import '../exceptions/connection_exception.dart';
import '../exceptions/other_exception.dart';
import '../exceptions/unauthorized_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (_isConnectionError(err)) {
      log('Connection error');
      return handler.next(ConnectionException(error: err));
    }

    log('Dio error: ${err.response?.statusCode}');

    return handler.next(switch (err.response?.statusCode) {
      null => OtherException(error: err),
      401 => UnauthorizedException(error: err),
      >= 400 && <= 500 => BackendException(error: err),
      _ => OtherException(error: err),
    });
  }

  bool _isConnectionError(DioException error) {
    return error.error is SocketException ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout;
  }
}
