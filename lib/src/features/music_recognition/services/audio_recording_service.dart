import 'package:record/record.dart';

class AudioRecordingService {
  final Record _record;

  AudioRecordingService({Record? record}) : _record = record ?? Record();

  Future<void> record() async {
    // Check and request permission
    if (await _record.hasPermission()) {
      // Start recording
      await _record.start(
        encoder: AudioEncoder.aacLc,
        bitRate: 128000,
      );
    }
  }

  Future<String?> stopRecording() async {
    if (!await _record.isRecording()) {
      return null;
    }

    return _record.stop();
  }
}
