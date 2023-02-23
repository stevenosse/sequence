import 'package:get_it/get_it.dart';
import 'package:sequence/src/datasource/http/api/music_recognition_api_controller.dart';
import 'package:sequence/src/datasource/http/dio_http_config.dart';
import 'package:sequence/src/features/music_details/services/open_in_player_service.dart';
import 'package:sequence/src/features/music_recognition/repositories/local_recognition_repository.dart';
import 'package:sequence/src/features/music_recognition/repositories/music_recognition_repository.dart';
import 'package:sequence/src/features/music_recognition/services/audio_recording_service.dart';

final GetIt locator = GetIt.instance
  ..registerLazySingleton(() => DioHttpConfig())
  ..registerLazySingleton(() => MusicRecognitionApiController(
      dio: locator<DioHttpConfig>().getDioInstance()))
  ..registerLazySingleton(() => MusicRecognitionRepository())
  ..registerLazySingleton(() => AudioRecordingService())
  ..registerLazySingleton(() => OpenInPlayerService())
  ..registerLazySingleton(() => LocalRecognitionRepository());
