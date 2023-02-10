import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequence/src/features/music_recognition/logic/sample_recorder/sample_recorder_state.dart';
import 'package:sequence/src/features/music_recognition/services/audio_recording_service.dart';
import 'package:sequence/src/shared/locator.dart';

const Duration _sampleDuration = Duration(seconds: 5);

class SampleRecorderCubit extends Cubit<SampleRecorderState> {
  final AudioRecordingService _audioRecordingService;
  Timer? _recordTimer;

  SampleRecorderCubit({
    AudioRecordingService? audioRecordingService,
  })  : _audioRecordingService = audioRecordingService ?? locator<AudioRecordingService>(),
        super(SampleRecorderState.idle());

  void recordSample() async {
    await _startSampleRecording();
    emit(SampleRecorderState.recordPending());
    _recordTimer = Timer(_sampleDuration, () => _startRecognition());
  }

  void reset() {
    emit(SampleRecorderState.idle());
  }

  Future<void> _startSampleRecording() async {
    await _audioRecordingService.record();
  }

  Future<String?> _stopSampleRecording() async {
    return _audioRecordingService.stopRecording();
  }

  void _startRecognition() async {
    final path = await _stopSampleRecording();
    if (path != null) {
      log('Sample recording ended: path: $path');
      emit(SampleRecorderState.recordSuccessful(filePath: path));
    } else {
      emit(SampleRecorderState.recordFailed(exception: Exception())); // TODO: fix
    }
  }

  @override
  Future<void> close() {
    _recordTimer?.cancel();
    return super.close();
  }
}
