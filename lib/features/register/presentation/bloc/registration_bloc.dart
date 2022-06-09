import 'package:equatable/equatable.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/register/domain/entities/university_entity.dart';
import 'package:app_sostegno/features/register/domain/usecases/get_barranquilla_universities.dart';
import 'package:app_sostegno/features/register/domain/usecases/register_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final GetBarranquillaUniversities getBarranquillaUniversities;
  final RegisterUser registerUser;

  RegistrationBloc({
    required this.getBarranquillaUniversities,
    required this.registerUser,
  }) : super(RegistrationInitial()) {
    on<InitialPageEvent>((event, emit) => _getUniversities(event, emit));

    on<DoRegisterEvent>((event, emit) => _registerUser(event, emit));
  }

  Map<String, dynamic> newUserData = {};
  @override
  Future<void> close() async {
    newUserData = {};
    super.close();
  }

  Future<void> _getUniversities(
    InitialPageEvent event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(LoadingState());
    final failOrUniversities = await getBarranquillaUniversities();

    emit(
      failOrUniversities.fold((fail) {
        newUserData = {};
        return ErrorState(
          msg: fail is ServerFailure
              ? 'Ops... server failure getting lista universidades'
              : 'Ops... Cache failure getting lista universidades',
        );
      }, (unis) {
        return UniversitiesRetrieved(universities: unis);
      }),
    );
  }

  Future<void> _registerUser(
    DoRegisterEvent event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(LoadingState());
    final result = await registerUser(body: newUserData);

    emit(
      result.fold(
          (fail) => ErrorState(
                msg: fail is ServerFailure
                    ? 'Ops... server failure creando estudiante'
                    : 'Ops... Cache failure creando estudiante',
              ), (unis) {
        return SuccessfullRegistration();
      }),
    );
  }
}
