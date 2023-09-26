import 'request_error.dart';

class DataResponse<T> {
  DataResponse({
    this.data,
    this.error,
  });

  final RequestError? error;
  final T? data;
}
