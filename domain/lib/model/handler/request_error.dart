sealed class RequestError {
  RequestError({this.message});
  String? message;
}

class ConnectionError extends RequestError {}

class UnauthorizedError extends RequestError {}

class GenericError extends RequestError {
  GenericError({super.message});
}
