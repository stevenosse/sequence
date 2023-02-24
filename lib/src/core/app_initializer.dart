import 'dart:developer';

import 'package:sequence/src/datasource/local/database.dart';

class AppInitializer {
  Future<void> preAppRun() async {}

  Future<void> run() async {}

  Future<void> postAppRun(AppDatabase appDatabase) async {
    List<RecognitionResultEntity> allRecognitions = [];

    appDatabase
        .select(appDatabase.recognitionResultEntityy)
        .get()
        .then((result) => allRecognitions = result);

    log('message: $allRecognitions');
  }
}
