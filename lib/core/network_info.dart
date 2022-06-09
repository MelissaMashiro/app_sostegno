import 'package:connectivity/connectivity.dart';
import 'package:logger/logger.dart';
import 'package:app_sostegno/core/error/exception.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectionChecker;

  NetworkInfoImpl(this._connectionChecker);
  @override
  Future<bool> get isConnected async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectionChecker.checkConnectivity();
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        return true;
      }
    } on NoInternetException catch (e) {
      Logger().w(e.toString());
    }

    return false;
  }
}
