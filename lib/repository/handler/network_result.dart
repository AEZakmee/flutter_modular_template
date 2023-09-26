sealed class NetworkResult<T> {}

class SuccessResult<T> implements NetworkResult<T> {
  SuccessResult(this.data);

  T data;
}

class ErrorResult<T> implements NetworkResult<T> {
  ErrorResult(this.exception);

  Exception exception;
}
