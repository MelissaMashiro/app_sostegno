import 'package:equatable/equatable.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/models/available_monitory.dart';
import 'package:app_sostegno/features/monitor_details/domain/monitor_details_domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'monitor_details_event.dart';
part 'monitor_details_state.dart';

class MonitorDetailsBloc
    extends Bloc<MonitorDetailsEvent, MonitorDetailsState> {
  final GetMonitorDetails getMonitorDetails;

  MonitorDetailsBloc({
    required this.getMonitorDetails,
  }) : super(InitialMonitorDetails()) {
    on<SelectedMonitor>((event, emit) => _getMonitorDetails(event, emit));
  }

  _getMonitorDetails(
    SelectedMonitor event,
    Emitter<MonitorDetailsState> emit,
  ) async {
    emit(LoadingState());
    final failOrDetails = await getMonitorDetails(codMonitor: event.codMonitor);

    emit(
      failOrDetails.fold(
          (fail) => ErrorState(
                msg: fail is ServerFailure
                    ? 'Ops... server failure getting monitor details'
                    : 'Ops... Cache failure getting  monitor details',
              ), (monitory) {
        return MonitorDetailsRetrieved(monitor: monitory);
      }),
    );
  }
}
