import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:record/record.dart';
import 'package:sequence/src/features/music_recognition/services/audio_recording_service.dart';

class _MockRecord extends Mock implements Record {}

void main() {
  late Record mockRecord;
  late AudioRecordingService audioRecordingService;

  setUp(() {
    mockRecord = _MockRecord();
    audioRecordingService = AudioRecordingService(record: mockRecord);

    when(() => mockRecord.start()).thenAnswer((_) async {});
  });

  test('Can Start Recording when permissions are granted', () async {
    when(() => mockRecord.hasPermission()).thenAnswer((_) async => true);

    await audioRecordingService.record();

    verify(() => mockRecord.start()).called(1);
    verify(() => mockRecord.hasPermission()).called(1);
  });

  test('Can\'t Start Recording when permissions are not granted', () async {
    when(() => mockRecord.hasPermission()).thenAnswer((_) async => false);

    await audioRecordingService.record();

    verifyNever(() => mockRecord.start());
    verify(() => mockRecord.hasPermission()).called(1);
  });

  test('Returns path when record pending', () async {
    const filePath = 'rsult.mp3';

    when(() => mockRecord.stop()).thenAnswer((_) async => filePath);
    when(() => mockRecord.isRecording()).thenAnswer((_) async => true);

    final String? resultPath = await audioRecordingService.stopRecording();

    expect(filePath, equals(resultPath));
  });

  test('Returns null when record pending', () async {
    const filePath = 'rsult.mp3';

    when(() => mockRecord.stop()).thenAnswer((_) async => filePath);
    when(() => mockRecord.isRecording()).thenAnswer((_) async => false);

    final String? resultPath = await audioRecordingService.stopRecording();

    expect(resultPath, isNull);
  });
}
