import '../model/handler/data_response.dart';
import '../model/handler/request_error.dart';

extension DataResponseExtension<T> on DataResponse<T> {
  TResult? fold<TResult>({
    required TResult Function(T data) onSuccess,
    TResult Function(RequestError error)? onError,
  }) {
    return switch (this) {
      SuccessfulDataResponse() => onSuccess(
          (this as SuccessfulDataResponse).data as T,
        ),
      FailureDataResponse() => onError?.call(
          (this as FailureDataResponse).error ?? GenericError(),
        )
    };
  }

  bool isSuccessful() => this is SuccessfulDataResponse;
}
