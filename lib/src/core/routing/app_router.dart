import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sequence/src/datasource/models/responses/recognition_response/recognition_result.dart';
import 'package:sequence/src/features/music_details/services/open_in_player_service.dart';
import 'package:sequence/src/features/music_details/ui/music_details_screen.dart';
import 'package:sequence/src/features/music_recognition/ui/music_recognition_screen.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: MusicRecognitionScreen, initial: true),
    AutoRoute(page: MusicDetailsScreen),
  ],
)
class AppRouter extends _$AppRouter {}
