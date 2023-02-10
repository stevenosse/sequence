import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequence/src/datasource/models/requests/recognize/recognize_request.dart';
import 'package:sequence/src/shared/locator.dart';

import '../../repositories/music_recognition_repository.dart';
import 'music_recognizer_state.dart';

class MusicRecognizerCubit extends Cubit<MusicRecognizerState> {
  final MusicRecognitionRepository _musicRecognitionRepository;

  MusicRecognizerCubit({
    MusicRecognitionRepository? musicRecognitionRepository,
  })  : _musicRecognitionRepository = musicRecognitionRepository ?? locator<MusicRecognitionRepository>(),
        super(MusicRecognizerState.idle());

  void recognize({required String filePath}) async {
    final request = RecognizeRequest(
      returnOutput: 'apple_music,spotify',
      filePath: filePath,
    );

    emit(MusicRecognizerState.recognitionLoading(request: request));

    final response = await _musicRecognitionRepository.recognize(request);
    response.when(
      success: (data) {
        if (data.result != null) {
          emit(MusicRecognizerState.recognitionSucceeded(request: request, response: data));
        } else {
          emit(MusicRecognizerState.recognitionFailed(request: request)); // FIXME: add reason
        }
      },
      error: (error) => emit(MusicRecognizerState.recognitionFailed(request: request)),
    );
  }
}
