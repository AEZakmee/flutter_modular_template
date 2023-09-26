import 'dart:io';

import 'package:dio/dio.dart';

import '../exceptions/bad_request_exception.dart';
import '../exceptions/connection_exception.dart';
import '../exceptions/other_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    switch (err.response?.statusCode ?? -1) {
      case 400:
        return handler.next(
          BadRequestException(
            error: err,
          ),
        );
    }

    if (err.error is SocketException) {
      return handler.next(
        ConnectionException(
          error: err,
          errorMessage: 'internet-exception',
        ),
      );
    }

    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      return handler.next(
        ConnectionException(
          error: err,
          errorMessage: 'timed-out',
        ),
      );
    }

    return handler.next(
      OtherException(
        error: err,
      ),
    );
  }
}
