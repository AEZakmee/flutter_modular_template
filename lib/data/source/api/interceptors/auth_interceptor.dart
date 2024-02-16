import 'package:dio/dio.dart';

import '../../../../domain/services/auth/auth.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({required Auth auth}) : _auth = auth;

  final Auth _auth;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _auth.accessToken();
    options.headers['Authorization'] = 'Bearer $token';

    return handler.next(options);
  }
}
