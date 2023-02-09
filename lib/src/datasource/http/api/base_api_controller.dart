import 'package:dio/dio.dart';

abstract class BaseApiController {
  final Dio dio;

  BaseApiController({required this.dio});
}
