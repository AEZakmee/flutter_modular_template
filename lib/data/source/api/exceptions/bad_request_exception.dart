import 'package:dio/dio.dart';

class BadRequestException extends DioException {
  BadRequestException({required DioException super.error})
      : super(
          requestOptions: error.requestOptions,
        );

  @override
  String get message => error.toString();
}
