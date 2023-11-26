import 'package:dependencies/exposer.dart';

class ConnectionException extends DioException {
  ConnectionException({
    required DioException super.error,
    required this.errorMessage,
  }) : super(requestOptions: error.requestOptions);

  String errorMessage;

  @override
  String get message => errorMessage;
}
