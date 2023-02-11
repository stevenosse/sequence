import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sequence/src/datasource/http/api/music_recognition_api_controller.dart';
import 'package:sequence/src/datasource/http/exceptions/custom_http_exception.dart';
import 'package:sequence/src/datasource/models/responses/network_response.dart';
import 'package:sequence/src/datasource/models/responses/recognition_response/recognition_response.dart';
import 'package:sequence/src/features/music_recognition/repositories/music_recognition_repository.dart';

import '../../../../fixtures/music_recognition.dart';

class _MockMusicRecognitionApiController extends Mock implements MusicRecognitionApiController {}

void main() {
  late MusicRecognitionApiController mockMusicRecognitionApiController;
  late MusicRecognitionRepository musicRecognitionRepository;

  setUp(() {
    mockMusicRecognitionApiController = _MockMusicRecognitionApiController();
    musicRecognitionRepository = MusicRecognitionRepository(
      musicRecognitionApiController: mockMusicRecognitionApiController,
    );
  });

  test('Returns [NetworkResponse.error] when API call fails', () async {
    when(() => mockMusicRecognitionApiController.recognize(request: defaultRequest)).thenThrow(DioError(
      requestOptions: RequestOptions(
        path: '/recognize',
      ),
      type: DioErrorType.other,
    ));

    final NetworkResponse<RecognitionResponse, CustomHttpException> response =
        await musicRecognitionRepository.recognize(defaultRequest);

    expect(
      response,
      equals(NetworkResponse<RecognitionResponse, CustomHttpException>.error(CustomHttpException(
        code: DioErrorType.other.name,
        details: '',
        errorType: CustomHttpError.http,
      ))),
    );
  });

  test('Returns [NetworkResponse.error] when API call fails with parsing error', () async {
    // Should throw 'type 'Null' is not a subtype of type 'String' in type cast' because status cannot be null
    when(() => mockMusicRecognitionApiController.recognize(request: defaultRequest)).thenAnswer(
      (_) async => Response(requestOptions: RequestOptions(path: '/recognize'), data: {
        'result': '',
      }),
    );

    final NetworkResponse<RecognitionResponse, CustomHttpException> response =
        await musicRecognitionRepository.recognize(defaultRequest);

    expect(
      response,
      equals(NetworkResponse<RecognitionResponse, CustomHttpException>.error(CustomHttpException(
        code: CustomHttpError.parsing.name,
        details: 'type \'Null\' is not a subtype of type \'String\' in type cast',
        errorType: CustomHttpError.parsing,
      ))),
    );
  });

  test('Returns [NetworkResponse.success] when API Call succeeds', () async {
    when(() => mockMusicRecognitionApiController.recognize(request: defaultRequest)).thenAnswer(
      (_) async => Response(
          requestOptions: RequestOptions(path: '/recognize'),
          data: json.decode(File('test_resources/mocks/recognition_response.json').readAsStringSync())),
    );

    final NetworkResponse<RecognitionResponse, CustomHttpException> response =
        await musicRecognitionRepository.recognize(defaultRequest);

    expect(
      response,
      equals(NetworkResponse<RecognitionResponse, CustomHttpException>.success(defaultRecognitionResponse)),
    );
  });
}
