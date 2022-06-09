import 'package:equatable/equatable.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/monitory_requests/domain/entities/request_entity.dart';
import 'package:app_sostegno/features/monitory_requests/domain/usecases/accept_monitory.dart';
import 'package:app_sostegno/features/monitory_requests/domain/usecases/get_requested_monitories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'monitory_requests_event.dart';
part 'monitory_requests_state.dart';

class MonitoryRequestsBloc
    extends Bloc<MonitoryRequestsEvent, MonitoryRequestsState> {
  final AcceptMonitory acceptMonitory;
  final GetRequestedMonitories getRequestedMonitories;

  MonitoryRequestsBloc({
    required this.acceptMonitory,
    required this.getRequestedMonitories,
  }) : super(MonitoryRequestsInitial()) {
    on<InitialPageEvent>((event, emit) => _getInitialData(event, emit));
  }

  Future<void> _getInitialData(
      InitialPageEvent event, Emitter<MonitoryRequestsState> emit) async {
    emit(LoadingState());
    final failOrRequests = await getRequestedMonitories();

    emit(
      failOrRequests.fold(
        (fail) => ErrorState(
          msg: fail is ServerFailure
              ? 'Ops... server failure getting monitor materias'
              : 'Ops... Cache failure getting monitor materias',
        ),
        (requests) => RequestsRetrieved(requests: requests),
      ),
    );
  }
}
