import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/core/storage/shared_preferences.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/enroll_to_monitory_data.dart';
import 'package:app_sostegno/features/monitories/domain/usecases/get_materias_by_monitor_with_code.dart';
import 'package:app_sostegno/features/monitory_creation/domain/usecases/create_monitory.dart';

part 'monitory_creation_event.dart';
part 'monitory_creation_state.dart';

class MonitoryCreationBloc
    extends Bloc<MonitoryCreationEvent, MonitoryCreationState> {
  final CreateMonitory createMonitory;
  final GetMateriasByMonitorWithCode getMateriasByMonitor;
  final MySharedPreferences sharedPreferences;

  MonitoryCreationBloc({
    required this.createMonitory,
    required this.getMateriasByMonitor,
    required this.sharedPreferences,
  }) : super(MonitoryCreationInitial()) {
    on<InitialMonitoryCreationEvent>(
        (event, emit) => _getMateriasList(event, emit));
    on<DoCreateMonitory>((event, emit) => _createMonitory(event, emit));
  }

  Map<String, dynamic> newMonitoryData = {};

  Future<void> _getMateriasList(
    InitialMonitoryCreationEvent event,
    Emitter<MonitoryCreationState> emit,
  ) async {
    emit(LoadingState());
    final userData = await sharedPreferences.getUser();

    final failOrMaterias = await getMateriasByMonitor(
      codMonitor: userData!.person.id,
    );

    emit(
      failOrMaterias.fold(
          (fail) => ErrorState(
                msg: fail is ServerFailure
                    ? 'Ops... server failure getting monitor materias'
                    : 'Ops... Cache failure getting monitor materias',
              ), (materias) {
        return MateriasRetrieved(materias: materias);
      }),
    );
  }

  Future<void> _createMonitory(
    DoCreateMonitory event,
    Emitter<MonitoryCreationState> emit,
  ) async {
    emit(LoadingState());
    print('DATA  MONITORIA=> $newMonitoryData');
    print('DATA  MONITORIA=> $newMonitoryData');
    final result = await createMonitory(body: newMonitoryData);

    emit(
      result.fold(
          (fail) => ErrorState(
                msg: fail is ServerFailure
                    ? 'Ops... server failure creating monitory'
                    : 'Ops... Cache failure creating monitory',
              ), (materias) {
        return SuccessMonitoryCreation();
      }),
    );
  }
}
