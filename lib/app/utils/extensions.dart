import '../../domain/model/handler/data_response.dart';
import '../../domain/model/handler/request_error.dart';

extension LetExtension<T> on T {
  R? let<R>(R? Function(T) block) => this != null ? block(this) : null;
}

extension DataResponseExtension<T> on DataResponse<T> {
  TResult? fold<TResult>({
    required TResult Function(T data) onSuccess,
    TResult Function(RequestError error)? onError,
  }) {
    if (data != null) {
      return onSuccess(data as T);
    }
    return onError?.call(error ?? GenericError());
  }
}
