import 'package:sequence/src/datasource/http/api/music_recognition_api_controller.dart';
import 'package:sequence/src/datasource/http/exceptions/custom_http_exception.dart';
import 'package:sequence/src/datasource/models/requests/recognize/recognize_request.dart';
import 'package:sequence/src/datasource/models/responses/network_response.dart';
import 'package:sequence/src/datasource/models/responses/recognition_response/recognition_response.dart';
import 'package:sequence/src/datasource/repositories/base_repository.dart';
import 'package:sequence/src/shared/locator.dart';

class MusicRecognitionRepository extends BaseRepository {
  final MusicRecognitionApiController _musicRecognitionApiController;

  MusicRecognitionRepository({
    MusicRecognitionApiController? musicRecognitionApiController,
  }) : _musicRecognitionApiController = musicRecognitionApiController ?? locator<MusicRecognitionApiController>();

  Future<NetworkResponse<RecognitionResponse, CustomHttpException>> recognize(RecognizeRequest request) async {
    return runApiCall(
      call: () async {
        final response = await _musicRecognitionApiController.recognize(request: request);
        return NetworkResponse.success(RecognitionResponse.fromJson(response.data!));
      },
    );
  }
}
