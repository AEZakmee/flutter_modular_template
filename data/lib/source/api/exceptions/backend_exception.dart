import 'package:dio/dio.dart';

class BackendException extends DioException {
  BackendException({required DioException super.error})
    : super(requestOptions: error.requestOptions, response: error.response);

  @override
  //todo:
  String get message => response?.statusMessage ?? 'Something went wrong';
}
