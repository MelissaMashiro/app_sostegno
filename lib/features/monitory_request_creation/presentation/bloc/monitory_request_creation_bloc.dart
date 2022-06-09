import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/enroll_to_monitory/domain/entities/materia.dart';
import 'package:app_sostegno/features/enroll_to_monitory/domain/usecases/get_all_materias.dart';
import 'package:app_sostegno/features/monitory_request_creation/domain/usecases/create_monitory_request.dart';

part 'monitory_request_creation_event.dart';
part 'monitory_request_creation_state.dart';

class MonitoryRequestCreationBloc
    extends Bloc<MonitoryRequestCreationEvent, MonitoryRequestCreationState> {
  final CreateMonitoryRequest createMonitoryRequest;
  final GetAllMaterias getAllMaterias;

  MonitoryRequestCreationBloc(
      {required this.createMonitoryRequest, required this.getAllMaterias})
      : super(MonitoryRequestCreationInitial()) {
    on<InitialRequestCreationEvent>(
        (event, emit) => _getMateriasList(event, emit));
    on<DoCreateRequest>((event, emit) => _createRequest(event, emit));
  }

  Map<String, dynamic> newRquestData = {};

  Future<void> _getMateriasList(InitialRequestCreationEvent event,
      Emitter<MonitoryRequestCreationState> emit) async {
    emit(LoadingState());
    final failOrMaterias = await getAllMaterias();

    emit(
      failOrMaterias.fold(
        (fail) => ErrorState(
          msg: fail is ServerFailure
              ? 'Ops... server failure getting all materias'
              : 'Ops... Cache failure getting all materias',
        ),
        (materias) {
          return MateriasRetrieved(materias: materias);
        },
      ),
    );
  }

  Future<void> _createRequest(
    DoCreateRequest event,
    Emitter<MonitoryRequestCreationState> emit,
  ) async {
    emit(LoadingState());
    final result = await createMonitoryRequest(body: newRquestData);

    emit(
      result.fold(
          (fail) => ErrorState(
                msg: fail is ServerFailure
                    ? 'Ops... server failure creating monitory'
                    : 'Ops... Cache failure creating monitory',
              ), (materias) {
        return SuccessRequestCreation();
      }),
    );
  }
}
