import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sequence/src/datasource/http/dio_http_config.dart';

void main() {
  late DioHttpConfig dioHttpConfig;

  test('Dio instance is built when no Dio instance is provided', () {
    final expected = Dio(BaseOptions(baseUrl: ''));

    dioHttpConfig = DioHttpConfig();

    expect(expected.options.baseUrl, equals(dioHttpConfig.getDioInstance().options.baseUrl));
  });

  test('Dio instance is overriden', () {
    final Dio dio = Dio(BaseOptions(baseUrl: 'https://myapi.com'));

    dioHttpConfig = DioHttpConfig(dioOverride: dio);
    expect(dio.options.baseUrl, equals(dioHttpConfig.getDioInstance().options.baseUrl));
  });
}
