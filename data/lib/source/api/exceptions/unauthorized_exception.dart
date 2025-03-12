import 'package:dio/dio.dart';

class UnauthorizedException extends DioException {
  UnauthorizedException({required DioException super.error})
    : super(requestOptions: error.requestOptions);
}
