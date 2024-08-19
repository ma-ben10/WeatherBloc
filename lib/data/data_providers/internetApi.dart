import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetApi {
  Stream<List<ConnectivityResult>> checkConnectivity() async* {
    Connectivity connectivity = Connectivity();
    yield* connectivity.onConnectivityChanged;
  }
}
