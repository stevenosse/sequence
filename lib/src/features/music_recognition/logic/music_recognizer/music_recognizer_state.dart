import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sequence/src/datasource/models/requests/recognize/recognize_request.dart';
import 'package:sequence/src/datasource/models/responses/recognition_response/recognition_response.dart';
import 'package:sequence/src/features/music_recognition/enums/recognition_failure_reason.dart';

part 'music_recognizer_state.freezed.dart';

@freezed
class MusicRecognizerState with _$MusicRecognizerState {
  factory MusicRecognizerState.idle({
    RecognizeRequest? request,
  }) = _Idle;

  factory MusicRecognizerState.recognitionLoading({
    required RecognizeRequest request,
  }) = _RecognitionLoading;

  factory MusicRecognizerState.recognitionSucceeded({
    required RecognizeRequest request,
    required RecognitionResponse response,
  }) = _RecognitionSucceeded;

  factory MusicRecognizerState.recognitionFailed({
    required RecognizeRequest request,
    required RecognitionFailureReason reason,
  }) = _RecognitionFailed;
}
