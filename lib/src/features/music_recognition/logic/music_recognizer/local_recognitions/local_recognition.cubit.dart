import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequence/src/datasource/models/responses/recognition_response/recognition_result.dart';
import 'package:sequence/src/features/music_recognition/logic/music_recognizer/local_recognitions/local_recognition_state.dart';
import 'package:sequence/src/features/music_recognition/repositories/local_recognition_repository.dart';
import 'package:sequence/src/shared/locator.dart';

class LocalRecognitionCubit extends Cubit<LocalRecognitionState> {
  final LocalRecognitionRepository _localRecognitionRepository;

  LocalRecognitionCubit({
    LocalRecognitionRepository? localRecognitionRepository,
  })  : _localRecognitionRepository =
            localRecognitionRepository ?? locator<LocalRecognitionRepository>(),
        super(LocalRecognitionState.idle());

  void saveRecognition({required RecognitionResult recognitionResponse}) async {
    emit(LocalRecognitionState.loading());
    final result =
        await _localRecognitionRepository.saveRecognitions(recognitionResponse);

    if(result == 'successful') {
      emit(LocalRecognitionState.succeeded());
    }
  }

  // void getRecognitions() {}
}
