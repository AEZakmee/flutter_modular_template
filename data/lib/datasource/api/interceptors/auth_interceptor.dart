import 'package:dependencies/exposer.dart';
import 'package:domain/services/auth_service.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({required Auth auth}) : _auth = auth;

  final  Auth _auth;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Authorization'] = 'Bearer ${_auth.accessToken}';

    return handler.next(options);
  }
}
