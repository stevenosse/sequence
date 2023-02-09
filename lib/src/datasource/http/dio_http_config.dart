import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:sequence/src/core/environment.dart';

class DioHttpConfig {
  final Dio _dio;

  DioHttpConfig({
    Dio? dioOverride,
  }) : _dio = dioOverride ?? _buildDioClient();

  static Dio _buildDioClient() {
    Dio dio = Dio(BaseOptions(
      baseUrl: Environment.apiBaseUrl,
    ));

    dio.interceptors.addAll([
      LogInterceptor(
        responseHeader: false,
        responseBody: true,
        requestBody: true,
        logPrint: (object) => log(object.toString()),
      ),
    ]);

    return dio;
  }

  Dio getDioInstance() => _dio;
}
