import 'package:core/model/user_tokens.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({required UserTokens Function() tokens}) : _tokens = tokens;

  final UserTokens Function() _tokens;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Authorization'] = 'Bearer ${_tokens().accessToken}';

    return handler.next(options);
  }
}
