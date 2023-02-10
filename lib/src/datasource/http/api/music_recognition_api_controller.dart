import 'package:dio/dio.dart';
import 'package:sequence/src/datasource/http/api/base_api_controller.dart';
import 'package:sequence/src/datasource/http/typedefs.dart';
import 'package:sequence/src/datasource/models/requests/recognize/recognize_request.dart';

class MusicRecognitionApiController extends BaseApiController {
  MusicRecognitionApiController({required super.dio});

  Future<Response<Json>> recognize({
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

      return response;
    } on DioError catch (_) {
      rethrow;
    }
  }
}
