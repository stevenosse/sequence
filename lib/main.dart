import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sequence/src/core/app_initializer.dart';
import 'package:sequence/src/core/application.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final AppInitializer appInitializer = AppInitializer();
  
  runZonedGuarded(
    () async {
      await appInitializer.preAppRun();

      runApp(const Application());

      await appInitializer.postAppRun();
    },
    (error, stack) {},
  );
}
