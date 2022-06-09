import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final dynamic msg;

  const Failure({this.msg = ''});
  @override
  List<Object> get props => [];
}



class ServerFailure extends Failure {
  const ServerFailure({required String msg}) : super(msg: msg);
}
class NoInternetFailure extends Failure {
  const NoInternetFailure({required String msg}) : super(msg: msg);
}

class CacheFailure extends Failure {
  const CacheFailure({required String msg}) : super(msg: msg);
}

class HiveFailure extends Failure {
  const HiveFailure({required String msg}) : super(msg: msg);
}

class LocalFilesFailure extends Failure {
  const LocalFilesFailure({required String msg}) : super(msg: msg);
}

class NoPermissionFailure extends Failure {
  const NoPermissionFailure({required String msg}) : super(msg: msg);
}

class GeneralFailure extends Failure {
  const GeneralFailure({required String msg}) : super(msg: msg);
}

class CodeNumAlreadyFoundFailure extends Failure {
  final num codeNum;

  const CodeNumAlreadyFoundFailure(this.codeNum) : super(msg: codeNum);
}
