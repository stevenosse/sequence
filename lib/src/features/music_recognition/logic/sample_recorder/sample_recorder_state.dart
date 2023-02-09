import 'package:freezed_annotation/freezed_annotation.dart';

part 'sample_recorder_state.freezed.dart';

@freezed
class SampleRecorderState with _$SampleRecorderState {
  factory SampleRecorderState.idle() = _Idle;

  factory SampleRecorderState.recordPending() = _RecordPending;

  factory SampleRecorderState.recordFailed({
    required Exception exception,
  }) = _RecordFailed;

  factory SampleRecorderState.recordSuccessful({
    required String filePath,
  }) = _RecordSuccessful;
}
