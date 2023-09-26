sealed class RequestError {}

class ConnectionError extends RequestError {}

class GenericError extends RequestError {
  GenericError({this.message});

  String? message;
}
