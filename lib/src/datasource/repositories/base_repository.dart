import 'package:dio/dio.dart';
import 'package:sequence/src/datasource/http/exceptions/custom_http_exception.dart';
import 'package:sequence/src/datasource/models/responses/network_response.dart';

abstract class BaseRepository {
  Future<NetworkResponse<T, CustomHttpException>> runApiCall<T>(
      {required Future<NetworkResponse<T, CustomHttpException>> Function() call}) async {
    try {
      return await call();
    } on DioError catch (e) {
      return NetworkResponse.error(CustomHttpException(
        code: e.type.name,
        details: e.message,
        errorType: CustomHttpError.http,
      ));
    } on Exception catch (e) {
      return NetworkResponse.error(CustomHttpException(
        code: e.toString(),
        errorType: CustomHttpError.parsing,
        details: 'Response',
      ));
    }
  }
}
