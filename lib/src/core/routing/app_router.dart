import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sequence/src/features/music_recognition/ui/music_recognition_screen.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: MusicRecognitionScreen, initial: true),
  ],
)
class AppRouter extends _$AppRouter {}
