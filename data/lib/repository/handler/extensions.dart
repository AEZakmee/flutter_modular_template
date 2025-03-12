import 'package:domain/model/handler/data_response.dart';
import 'package:domain/model/handler/request_error.dart';

import '../../source/api/exceptions/backend_exception.dart';
import '../../source/api/exceptions/connection_exception.dart';
import '../../source/api/exceptions/unauthorized_exception.dart';
import 'network_result.dart';

extension NetworkResultExtensions<U> on NetworkResult<U> {
  DataResponse<T> toDataResponse<T>([T Function(U)? mapper]) {
    return switch (this) {
      SuccessResult<U>() => SuccessfulDataResponse<T>(
        data:
            mapper?.call((this as SuccessResult<U>).data) ??
            (this as SuccessResult<U>).data as T,
      ),
      ErrorResult<U>() => FailureDataResponse<T>(
        error: (this as ErrorResult<U>).exception.toRequestError(),
      ),
    };
  }

  Future<DataResponse<T>> toDataResponseAsync<T>([
    Future<T> Function(U)? mapper,
  ]) async {
    return switch (this) {
      SuccessResult<U>() => SuccessfulDataResponse<T>(
        data:
            await mapper?.call((this as SuccessResult<U>).data) ??
            (this as SuccessResult<U>).data as T,
      ),
      ErrorResult<U>() => FailureDataResponse<T>(
        error: (this as ErrorResult<U>).exception.toRequestError(),
      ),
    };
  }
}

extension ExceptionToDomainExtension on Exception {
  RequestError toRequestError() {
    final exception = this;

    if (exception is BackendException) {
      return GenericError(message: exception.message);
    } else if (exception is UnauthorizedException) {
      return UnauthorizedError();
    } else if (exception is ConnectionException) {
      return ConnectionError();
    } else {
      return GenericError();
    }
  }
}
