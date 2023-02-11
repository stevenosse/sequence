import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sequence/src/features/music_recognition/exceptions/record_failed_exception.dart';
import 'package:sequence/src/features/music_recognition/logic/sample_recorder/sample_recorder_cubit.dart';
import 'package:sequence/src/features/music_recognition/logic/sample_recorder/sample_recorder_state.dart';
import 'package:sequence/src/features/music_recognition/services/audio_recording_service.dart';

class _MockAudioRecordingService extends Mock implements AudioRecordingService {}

void main() {
  const String filePath = 'path.mp3';

  late AudioRecordingService mockAudioRecordingService;

  setUp(() {
    mockAudioRecordingService = _MockAudioRecordingService();

    when(() => mockAudioRecordingService.record()).thenAnswer((invocation) async => {});
    when(() => mockAudioRecordingService.stopRecording()).thenAnswer((invocation) async => filePath);
  });

  blocTest(
    'Final state is [recordSuccessful] when record is launched',
    build: () => SampleRecorderCubit(audioRecordingService: mockAudioRecordingService),
    act: (bloc) => bloc.recordSample(),
    wait: SampleRecorderCubit.sampleDuration,
    expect: () => [
      SampleRecorderState.recordPending(),
      SampleRecorderState.recordSuccessful(filePath: filePath),
    ],
  );

  blocTest(
    'Final state is [idle] when reset is called',
    build: () => SampleRecorderCubit(audioRecordingService: mockAudioRecordingService),
    act: (bloc) => bloc.reset(),
    expect: () => [
      SampleRecorderState.idle(),
    ],
  );

  blocTest(
    'Final state is [recordFailed] when record is launched',
    setUp: () {
      when(() => mockAudioRecordingService.stopRecording()).thenAnswer((_) async => null);
    },
    build: () => SampleRecorderCubit(audioRecordingService: mockAudioRecordingService),
    act: (bloc) => bloc.recordSample(),
    wait: SampleRecorderCubit.sampleDuration,
    expect: () => [
      SampleRecorderState.recordPending(),
      SampleRecorderState.recordFailed(exception: RecordFailedException()),
    ],
  );
}
