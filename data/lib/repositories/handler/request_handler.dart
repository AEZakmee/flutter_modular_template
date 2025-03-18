import 'dart:developer';

import 'network_result.dart';

class RequestHandler {
  final Map<String, dynamic> _inMemoryCache = {};

  Future<NetworkResult<T>> safeApiCall<T>(
    Future<T> Function() apiCall, {
    String? cacheKey,
    bool useCache = false,
  }) async {
    if (useCache && cacheKey != null && _inMemoryCache.containsKey(cacheKey)) {
      return SuccessResult(_inMemoryCache[cacheKey]);
    }

    try {
      final data = await apiCall();
      if (cacheKey != null) {
        _inMemoryCache[cacheKey] = data;
      }
      return SuccessResult(data);
    } on Exception catch (e, stacktrace) {
      log('Caught an Exception: $e');
      log('Stacktrace: $stacktrace');
      return ErrorResult(e);
    }
  }

  void clearCache([String? cacheKey]) {
    if (cacheKey != null) {
      _inMemoryCache.remove(cacheKey);
    } else {
      _inMemoryCache.clear();
    }
  }
}
