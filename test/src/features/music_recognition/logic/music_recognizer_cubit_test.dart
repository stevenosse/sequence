import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sequence/src/datasource/http/exceptions/custom_http_exception.dart';
import 'package:sequence/src/datasource/models/requests/recognize/recognize_request.dart';
import 'package:sequence/src/datasource/models/responses/network_response.dart';
import 'package:sequence/src/features/music_recognition/enums/recognition_failure_reason.dart';
import 'package:sequence/src/features/music_recognition/logic/music_recognizer/music_recognizer_cubit.dart';
import 'package:sequence/src/features/music_recognition/logic/music_recognizer/music_recognizer_state.dart';
import 'package:sequence/src/features/music_recognition/repositories/music_recognition_repository.dart';

import '../../../../fixtures/recognition_response.dart';

class _MockMusicRecognitionRepository extends Mock implements MusicRecognitionRepository {}

void main() {
  late _MockMusicRecognitionRepository mockMusicRecognitionRepository;

  final defaultRequest = RecognizeRequest(
    returnOutput: 'apple_music,spotify',
    filePath: 'path.mp3',
  );

  setUp(() {
    mockMusicRecognitionRepository = _MockMusicRecognitionRepository();
  });

  blocTest(
    'Final state is [recognitionSucceeded] when response is success ',
    setUp: () {
      when(() => mockMusicRecognitionRepository.recognize(defaultRequest))
          .thenAnswer((_) async => NetworkResponse.success(defaultRecognitionResponse));
    },
    build: () => MusicRecognizerCubit(
      musicRecognitionRepository: mockMusicRecognitionRepository,
    ),
    act: (bloc) => bloc.recognize(filePath: 'path.mp3'),
    expect: () => [
      MusicRecognizerState.recognitionLoading(request: defaultRequest),
      MusicRecognizerState.recognitionSucceeded(request: defaultRequest, response: defaultRecognitionResponse),
    ],
  );

  blocTest(
    'Error is [NO_MATCH_FOUND] when result is null on response ',
    setUp: () {
      when(() => mockMusicRecognitionRepository.recognize(defaultRequest))
          .thenAnswer((_) async => NetworkResponse.success(defaultRecognitionResponse.copyWith(result: null)));
    },
    build: () => MusicRecognizerCubit(
      musicRecognitionRepository: mockMusicRecognitionRepository,
    ),
    act: (bloc) => bloc.recognize(filePath: 'path.mp3'),
    expect: () => [
      MusicRecognizerState.recognitionLoading(request: defaultRequest),
      MusicRecognizerState.recognitionFailed(request: defaultRequest, reason: RecognitionFailureReason.noMatchFound),
    ],
  );

  blocTest(
    'Final state is [recognitionSucceeded] when response is error ',
    setUp: () {
      when(() => mockMusicRecognitionRepository.recognize(defaultRequest)).thenAnswer((_) async =>
          NetworkResponse.error(CustomHttpException(code: '', details: '', errorType: CustomHttpError.parsing)));
    },
    build: () => MusicRecognizerCubit(
      musicRecognitionRepository: mockMusicRecognitionRepository,
    ),
    act: (bloc) => bloc.recognize(filePath: 'path.mp3'),
    expect: () => [
      MusicRecognizerState.recognitionLoading(request: defaultRequest),
      MusicRecognizerState.recognitionFailed(request: defaultRequest, reason: RecognitionFailureReason.other),
    ],
  );
}
