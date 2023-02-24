// ignore_for_file: always_declare_return_types

import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

mixin NetworkAwareState<T extends StatefulWidget> on State<T> {
  bool _isDisconnected = false;
  bool firstCallback = true;

  late StreamSubscription<ConnectivityResult> _networkSubscription;
  final Connectivity _connectivity = Connectivity();

  void cancelSubscription() {
    try {
      _networkSubscription.cancel();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void dispose() {
    cancelSubscription();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on Exception catch (e) {
      log(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _networkSubscription = _connectivity.onConnectivityChanged.listen((result) {
      _updateConnectionStatus(result);
    });
  }

  void onDisconnected() {}

  void onReconnected() {}

  _updateConnectionStatus(ConnectivityResult result) {
    if (result != ConnectivityResult.none) {
      if (_isDisconnected) {
        onReconnected();
        _isDisconnected = false;
      } else {
        _isDisconnected = true;
        onDisconnected();
      }
    }
  }
}
