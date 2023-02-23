import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_recognition_state.freezed.dart';

@freezed
class LocalRecognitionState with _$LocalRecognitionState {
  factory LocalRecognitionState.idle() = _Idle;

  factory LocalRecognitionState.loading() = _Loading;

  factory LocalRecognitionState.succeeded() = _Succeeded;

  factory LocalRecognitionState.failed() = _Failed;
}
