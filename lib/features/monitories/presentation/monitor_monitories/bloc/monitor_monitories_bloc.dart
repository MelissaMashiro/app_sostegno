import 'package:equatable/equatable.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/enroll_to_monitory_data.dart';
import 'package:app_sostegno/features/monitories/domain/usecases/get_materias_by_monitor.dart';
import 'package:app_sostegno/features/monitories/domain/usecases/get_monitor_monitories_by_materia.dart';
import 'package:app_sostegno/features/monitories/domain/usecases/get_monitories_by_monitor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'monitor_monitories_event.dart';
part 'monitor_monitories_state.dart';

class MonitorMonitoriesBloc
    extends Bloc<MonitorMonitoriesEvent, MonitorMonitoriesState> {
  final GetMateriasByMonitor getMateriasByMonitor;
  final GetMonitoriesByMonitor getMonitoriesByMonitor;
  final GetMonitorMonitoriesByMateria getMonitorMonitoriesByMateria;

  MonitorMonitoriesBloc({
    required this.getMateriasByMonitor,
    required this.getMonitoriesByMonitor,
    required this.getMonitorMonitoriesByMateria,
  }) : super(MonitorMonitoriesInitial()) {
    on<InitialPageEvent>((event, emit) => _getInitialData(event, emit));
    on<DoMateriaSelectedEvent>(
        (event, emit) => _getMonitoriesByMateriaAndMonitor(event, emit));
  }

  List<MonitorMonitoria> _monitorMaterias = [];
  List<AvailableMonitory> _monitories = [];

  Future<void> _getInitialData(
    InitialPageEvent event,
    Emitter<MonitorMonitoriesState> emit,
  ) async {
    emit(LoadingMonitoriesState());
    final failOrMaterias = await getMateriasByMonitor();

    var result1 = failOrMaterias.fold(
        (fail) => MonitoriesError(
              msg: fail is ServerFailure
                  ? 'Ops... server failure getting monitor materias'
                  : 'Ops... Cache failure getting monitor materias',
            ), (materias) {
      _monitorMaterias = materias;
    });

    if (result1 is Error) {
      emit(const MonitoriesError(
          msg: 'Error obteniendo la informacion de las monitorias'));
    } else {
      await _getAllMonitorMonitories(event, emit);
    }
  }

  Future<void> _getAllMonitorMonitories(
    InitialPageEvent event,
    Emitter<MonitorMonitoriesState> emit,
  ) async {
    emit(LoadingMonitoriesState());

    final failOrMonitories = await getMonitoriesByMonitor();

    emit(
      failOrMonitories.fold(
          (fail) => MonitoriesError(
                msg: fail is ServerFailure
                    ? 'Ops... server failure getting monitor monitories'
                    : 'Ops... Cache failure getting monitor monitories',
              ), (monitories) {
        _monitories = monitories;
        return InitialDataRetrieved(
          monitories: monitories,
          materias: _monitorMaterias,
        );
      }),
    );
  }

  Future<void> _getMonitoriesByMateriaAndMonitor(
    DoMateriaSelectedEvent event,
    Emitter<MonitorMonitoriesState> emit,
  ) async {
    List<AvailableMonitory> monitories = [];

    if (_monitories.isNotEmpty) {
      for (var m in _monitories) {
        if (m.monitorMonitoria.materia.id == event.codMateria) {
          monitories.add(m);
        }
      }
    }
    emit(MonitoriesByMateriaRetrieved(monitories: monitories));
  }
}
