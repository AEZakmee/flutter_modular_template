import 'package:dependencies/exposer.dart';

class OtherException extends DioException {
  OtherException({
    required DioException super.error,
  }) : super(requestOptions: error.requestOptions);
}
