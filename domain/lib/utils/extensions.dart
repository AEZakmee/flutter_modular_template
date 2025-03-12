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
      ),
    };
  }

  DataResponse<R> mapData<R>(R Function(T data) mapper) {
    return switch (this) {
      SuccessfulDataResponse() => SuccessfulDataResponse<R>(
        data: mapper((this as SuccessfulDataResponse).data as T),
      ),
      FailureDataResponse() => this as FailureDataResponse<R>,
    };
  }

  T? unfold() {
    return switch (this) {
      SuccessfulDataResponse() => (this as SuccessfulDataResponse).data as T,
      FailureDataResponse() => null,
    };
  }

  T safeUnfold({required T defaultValue}) {
    return switch (this) {
      SuccessfulDataResponse() => (this as SuccessfulDataResponse).data as T,
      FailureDataResponse() => defaultValue,
    };
  }

  bool isSuccessful() => this is SuccessfulDataResponse;
}

extension ListUtils<T> on List<T> {
  List<T> addOrRemove(T item) {
    final newList = [...this];
    if (newList.contains(item)) {
      newList.remove(item);
    } else {
      newList.add(item);
    }
    return newList;
  }
}
