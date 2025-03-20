import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lyqx/core/constants/app_endpoints.dart';

@lazySingleton
class ApiClient {
  final Dio _dio;

  ApiClient(this._dio) {
    // Configure default Dio options
    _dio.options = BaseOptions(
      baseUrl: AppEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );

    // Add interceptors
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  Future<Response> get(String path) async {
    return _dio.get(path);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return _dio.post(path, data: data);
  }
}
