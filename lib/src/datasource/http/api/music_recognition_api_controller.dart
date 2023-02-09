import 'package:dio/dio.dart';
import 'package:sequence/src/datasource/http/api/base_api_controller.dart';
import 'package:sequence/src/datasource/http/exceptions/custom_http_exception.dart';
import 'package:sequence/src/datasource/http/typedefs.dart';
import 'package:sequence/src/datasource/models/requests/recognize/recognize_request.dart';

import 'package:sequence/src/datasource/models/responses/network_response.dart';
import 'package:sequence/src/datasource/models/responses/recognition_response/recognition_response.dart';

class MusicRecognitionApiController extends BaseApiController {
  MusicRecognitionApiController({required super.dio});

  // TODO: fix error handling
  Future<NetworkResponse<RecognitionResponse, CustomHttpException>> recognize({
    required RecognizeRequest request,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response<Json> response = await dio.post(
        '/recognize',
        options: Options(
          contentType: 'multipart/form-data',
        ),
        data: await request.toFormData(),
      );

      return NetworkResponse.success(RecognitionResponse.fromJson(response.data!));
    } on DioError catch (e) {
      return NetworkResponse.error(CustomHttpException(
        code: '',
        details: e.response?.statusMessage ?? '',
      ));
    } on Exception catch (e) {
      return NetworkResponse.error(CustomHttpException(
        code: '',
        details: e.toString(),
      ));
    }
  }
}
