import 'dart:developer';

import 'network_result.dart';

class RequestHandler {
  Future<NetworkResult<T>> safeApiCall<T>(Future<T> Function() apiCall) async {
    try {
      final data = await apiCall();
      return SuccessResult(data);
    } on Exception catch (e) {
      log('API call error: $e');
      return ErrorResult(e);
    }
  }
}
