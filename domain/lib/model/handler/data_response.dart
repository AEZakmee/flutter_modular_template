import 'request_error.dart';

sealed class DataResponse<T> {}

class SuccessfulDataResponse<T> extends DataResponse<T> {
  SuccessfulDataResponse({this.data});

  final T? data;
}

class FailureDataResponse<T> extends DataResponse<T> {
  FailureDataResponse({this.error});

  final RequestError? error;
}
