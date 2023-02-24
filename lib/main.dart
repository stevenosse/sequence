import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sequence/src/core/app_initializer.dart';
import 'package:sequence/src/core/application.dart';
import 'package:sequence/src/datasource/local/database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final AppInitializer appInitializer = AppInitializer();
  final AppDatabase appDatabase = AppDatabase();

  runZonedGuarded(
    () async {
      await appInitializer.preAppRun();

      runApp(const Application());

      await appInitializer.postAppRun(appDatabase);
    },
    (error, stack) {},
  );
}
