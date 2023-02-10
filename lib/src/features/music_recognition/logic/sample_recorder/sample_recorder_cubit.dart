import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequence/src/features/music_recognition/exceptions/record_failed_exception.dart';
import 'package:sequence/src/features/music_recognition/logic/sample_recorder/sample_recorder_state.dart';
import 'package:sequence/src/features/music_recognition/services/audio_recording_service.dart';
import 'package:sequence/src/shared/locator.dart';

class SampleRecorderCubit extends Cubit<SampleRecorderState> {
  final AudioRecordingService _audioRecordingService;
  Timer? _recordTimer;

  static const Duration sampleDuration = Duration(seconds: 5);

  SampleRecorderCubit({
    AudioRecordingService? audioRecordingService,
  })  : _audioRecordingService = audioRecordingService ?? locator<AudioRecordingService>(),
        super(SampleRecorderState.idle());

  void recordSample() async {
    try {
      await _startSampleRecording();
      emit(SampleRecorderState.recordPending());
      _recordTimer = Timer(sampleDuration, () => _stopSampleRecording());
    } catch (e) {
      log('Record failed', error: e);
    }
  }

  void reset() {
    emit(SampleRecorderState.idle());
  }

  Future<void> _startSampleRecording() async {
    await _audioRecordingService.record();
  }

  Future<String?> _getRecordedSample() async {
    return _audioRecordingService.stopRecording();
  }

  void _stopSampleRecording() async {
    final path = await _getRecordedSample();
    if (path != null) {
      log('Sample recording ended: path: $path');
      emit(SampleRecorderState.recordSuccessful(filePath: path));
    } else {
      emit(SampleRecorderState.recordFailed(
        exception: RecordFailedException(),
      ));
    }
  }

  @override
  Future<void> close() {
    _recordTimer?.cancel();
    return super.close();
  }
}
