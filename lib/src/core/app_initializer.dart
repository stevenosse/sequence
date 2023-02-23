import 'dart:developer';

import 'package:sequence/src/datasource/local/database.dart';

class AppInitializer {
  Future<void> preAppRun() async {}

  Future<void> run() async {}

  Future<void> postAppRun() async {
    final db = AppDatabase();

    final allRecognitions = await db.select(db.recognitionResultDb).get();

    log('message: $allRecognitions');
  }
}
