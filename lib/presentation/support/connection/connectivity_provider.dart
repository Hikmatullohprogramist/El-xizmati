import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConnectivityProvider with ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  bool _isOnline = true; // Assume online initially

  ConnectivityProvider() {
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  bool get isOnline => _isOnline;

  void _updateConnectionStatus(ConnectivityResult result) {
    _isOnline = (result != ConnectivityResult.none);
    notifyListeners();
  }
}
