import 'package:connectivity_plus/connectivity_plus.dart';

class AppConnectivity {
  AppConnectivity._();

  final Connectivity _connectivity = Connectivity();
  static final AppConnectivity instance = AppConnectivity._();

  Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
