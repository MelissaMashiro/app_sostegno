import 'package:equatable/equatable.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/authentication/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUser loginUser;
  final LogoutUser logoutUser;

  AuthenticationBloc({
    required this.loginUser,
    required this.logoutUser,
  }) : super(AuthenticationInitial()) {
    on<DoLoginEvent>((event, emit) => _loginUser(event, emit));
  }
  UserEntity? _userEntity;
  UserEntity? get userEntity {
    print(_userEntity);
    return _userEntity;
  }

  Future<void> _loginUser(
    DoLoginEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(LoadingState());

    final result = await loginUser(
        email: event.email, password: event.password, userType: event.userType);

    emit(
      result.fold(
          (fail) => ErrorState(
                msg: fail is ServerFailure
                    ? 'Ops... server failure logiing'
                    : 'Ops... Cache failure logining',
              ), (userEntity) {
        _userEntity = userEntity;
        return SuccessfullAuthenticatedState();
      }),
    );
  }
}
