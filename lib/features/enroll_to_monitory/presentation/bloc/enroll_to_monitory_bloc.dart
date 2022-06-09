import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/models/available_monitory.dart';
import 'package:app_sostegno/features/enroll_to_monitory/domain/entities/materia.dart';
import 'package:app_sostegno/features/enroll_to_monitory/domain/entities/monitor.dart';
import 'package:app_sostegno/features/enroll_to_monitory/domain/usecases/enroll_to_monitory.dart';
import 'package:app_sostegno/features/enroll_to_monitory/domain/usecases/get_all_materias.dart';
import 'package:app_sostegno/features/enroll_to_monitory/domain/usecases/get_available_monitories.dart';
import 'package:app_sostegno/features/enroll_to_monitory/domain/usecases/get_monitores_by_materia.dart';
import 'package:app_sostegno/features/monitories/domain/usecases/get_monitory_details.dart';

part 'enroll_to_monitory_event.dart';
part 'enroll_to_monitory_state.dart';

class EnrollToMonitoryBloc
    extends Bloc<EnrollToMonitoryEvent, EnrollToMonitoryState> {
  final GetAvailableMonitories getAvailableMonitories;
  final EnrollToMonitory enrollToMonitory;
  final GetAllMaterias getAllMaterias;
  final GetMonitoresByMateria getMonitoresByMateria;
  final GetMonitoryDetails getMonitoryDetails;

  EnrollToMonitoryBloc({
    required this.getAvailableMonitories,
    required this.enrollToMonitory,
    required this.getAllMaterias,
    required this.getMonitoresByMateria,
    required this.getMonitoryDetails,
  }) : super(EnrollToMonitoryInitial()) {
    on<InitialPageEvent>((event, emit) => _getMateriasList(event, emit));
    on<DoMateriaSelectedEvent>((event, emit) => _getMonitoresList(event, emit));
    on<DoSearchEvent>((event, emit) => _doSearch(event, emit));
    on<DoEnrollEvent>((event, emit) => _doEnroll(event, emit));
  }

  Future<void> _getMateriasList(
      InitialPageEvent event, Emitter<EnrollToMonitoryState> emit) async {
    emit(LoadingState());
    final failOrMaterias = await getAllMaterias();

    emit(
      failOrMaterias.fold(
          (fail) => ErrorState(
                msg: fail is ServerFailure
                    ? 'Ops... server failure getting all materias'
                    : 'Ops... Cache failure getting all materias',
              ), (materias) {
        return MateriasRetrieved(materias: materias);
      }),
    );
  }

  Future<void> _getMonitoresList(
      DoMateriaSelectedEvent event, Emitter<EnrollToMonitoryState> emit) async {
    emit(LoadingState());

    final failOrMonitores =
        await getMonitoresByMateria(codigoMateria: event.materia.materia.id);

    emit(
      failOrMonitores.fold(
          (fail) => ErrorState(
                msg: fail is ServerFailure
                    ? 'Ops... server failure getting monitores por materia'
                    : 'Ops... Cache failure getting monitores por materia',
              ), (monitores) {
        return MonitoresRetrieved(monitores: monitores);
      }),
    );
  }

  Future<void> _doSearch(
      DoSearchEvent event, Emitter<EnrollToMonitoryState> emit) async {
    emit(LoadingState());
    final failOrMonitories = await getAvailableMonitories(
      materia: event.materia,
      monitor: event.monitor,
    );
    emit(
      failOrMonitories.fold(
        (fail) => ErrorState(
            msg: fail is ServerFailure
                ? 'Ops... server failure getting availab. monitories'
                : 'Ops... Cache failure getting availab. the monitories'),
        (monitories) => MonitoriesRetrieved(monitories: monitories),
      ),
    );
  }

  Future<void> _doEnroll(
      DoEnrollEvent event, Emitter<EnrollToMonitoryState> emit) async {
    emit(LoadingState());
    final result = await enrollToMonitory(
      codMonitory: event.codMonitory,
    );
    emit(
      result.fold(
        (fail) => ErrorState(
            msg: fail is ServerFailure
                ? 'Ops... server failure enroling student to monitory'
                : 'Ops... Cache failure enroling student to monitory'),
        (monitories) => EnrolledStudentState(),
      ),
    );
  }
}
