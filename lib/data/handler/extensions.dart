import '../../domain/model/handler/data_response.dart';
import '../../domain/model/handler/request_error.dart';
import '../source/api/exceptions/bad_request_exception.dart';
import '../source/api/exceptions/connection_exception.dart';
import 'network_result.dart';

extension NetworkResultExtensions<U> on NetworkResult<U> {
  DataResponse<T> toDataResponse<T>(T Function(U) mapper) {
    return switch (this) {
      SuccessResult<U>() => DataResponse(
          data: mapper((this as SuccessResult<U>).data),
        ),
      ErrorResult<U>() => DataResponse(
          error: (this as ErrorResult<U>).exception.toRequestError(),
        ),
    };
  }
}

extension ExceptionToDomainExtension on Exception {
  RequestError toRequestError() {
    final exception = this;

    if (exception is BadRequestException) {
      return GenericError(message: exception.message);
    } else if (exception is ConnectionException) {
      return ConnectionError();
    } else {
      return GenericError();
    }
  }
}
