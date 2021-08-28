import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class ConnectivityChangeNotifier extends ChangeNotifier {
  ConnectivityChangeNotifier() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      resultHandler(result);
    });
  }
  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  //String _svgUrl = 'assets/serverDown.svg';
  String _pageText = 'No Internet connection.!';
  bool _isNetorkConnected = false;

  ConnectivityResult get connectivity => _connectivityResult;
  bool get isConnected => _isNetorkConnected;
  //String get svgUrl => _svgUrl;
  String get pageText => _pageText;

  void resultHandler(ConnectivityResult result) {
    _connectivityResult = result;
    if (result == ConnectivityResult.none) {
      _pageText = 'No Internet connection.!';
      _isNetorkConnected = false;
    } else if (result == ConnectivityResult.mobile) {
      _isNetorkConnected = true;
    } else if (result == ConnectivityResult.wifi) {
      _isNetorkConnected = true;
    }
    notifyListeners();
  }

  void initialLoad() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    resultHandler(connectivityResult);
  }
}
