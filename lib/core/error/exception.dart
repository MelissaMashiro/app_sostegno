class ServerException implements Exception {}
class NoInternetException implements Exception {}

class CacheException implements Exception {}

class OneSignalException implements Exception {}

class HiveException implements Exception {}

class LocalFilesException implements Exception {}

class NoPermissionException implements Exception {}

class NoBluetoothException implements Exception {}

class GeneralException implements Exception {}

class CodeNumAlreadyFoundedException implements Exception {
  final num codeNum;

  CodeNumAlreadyFoundedException(this.codeNum);
}
