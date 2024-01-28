import 'package:dio/dio.dart';

class ApiRequests {
  ApiRequests({required Dio dio}) : _dio = dio;

  final Dio _dio;

  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.get(
      url,
      queryParameters: queryParameters,
    );

    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> post(
    String url,
    Object body,
  ) async {
    final response = await _dio.post(
      url,
      data: body,
    );
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> put(
    String url,
    Object body,
  ) async {
    final response = await _dio.put(
      url,
      data: body,
    );
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> patch(
    String url,
    Object body,
  ) async {
    final response = await _dio.patch(
      url,
      data: body,
    );
    return response.data as Map<String, dynamic>;
  }
}
