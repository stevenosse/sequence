import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:sequence/src/datasource/http/api/music_recognition_api_controller.dart';
import 'package:sequence/src/datasource/http/typedefs.dart';
import 'package:sequence/src/datasource/models/requests/recognize/recognize_request.dart';

import '../../../../fixtures/music_recognition.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late MusicRecognitionApiController musicRecognitionApiController;

  final request = defaultRequest.copyWith(filePath: 'test_resources/file_mocks/test.mp3');

  const path = 'https://myapi.com';

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: path));
    dioAdapter = DioAdapter(dio: dio);
    musicRecognitionApiController = MusicRecognitionApiController(dio: dio);
  });

  tearDown(() {
    dioAdapter.reset();
  });

  test('Call on /recognize returns valid data', () async {
    final jsonResponse = json.decode(File('test_resources/mocks/recognition_response.json').readAsStringSync());
    dioAdapter.onPost(
      '/recognize',
      data: await request.toFormData(),
      (server) => server.reply(
        200,
        jsonResponse,
        delay: const Duration(seconds: 1),
      ),
    );

    final Response<Json> response = await musicRecognitionApiController.recognize(
      request: request,
    );

    expect(response.data, equals(jsonResponse));
  });

  test('Call on /recognize throws DioError when call fails', () async {
    dioAdapter.onPost(
      '/recognize',
      data: await request.toFormData(),
      (server) => server.reply(
        400,
        {'status': 'failed', 'result': null},
        delay: const Duration(seconds: 1),
      ),
    );

    final apiCall = musicRecognitionApiController.recognize(request: request);
    expectLater(apiCall, throwsA(isA<DioError>()));
  });
}
