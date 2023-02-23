import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sequence/src/core/i18n/l10n.dart';
import 'package:sequence/src/core/network%20aware/network_aware.dart';
import 'package:sequence/src/core/routing/app_router.dart';
import 'package:sequence/src/core/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final AppRouter _appRouter = AppRouter();

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> with NetworkAwareState {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Sequence',
      routerDelegate: _appRouter.delegate(),
      routeInformationProvider: _appRouter.routeInfoProvider(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        I18n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
      ],
    );
  }

  @override
  void onDisconnected() {
    log('Disconnected');
  }

  @override
  void onReconnected() {
    log('Connected');
  }
}
