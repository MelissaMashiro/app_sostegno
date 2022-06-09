import 'package:equatable/equatable.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/enroll_to_monitory_data.dart';
import 'package:app_sostegno/features/monitories/domain/usecases/cancel_monitory.dart';
import 'package:app_sostegno/features/monitories/domain/usecases/get_monitory_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'monitory_details_event.dart';
part 'monitory_details_state.dart';

class MonitoryDetailsBloc
    extends Bloc<MonitoryDetailsEvent, MonitoryDetailsState> {
  final GetMonitoryDetails getMonitoryDetails;
  final CancelMonitory cancelMonitory;

  MonitoryDetailsBloc({
    required this.getMonitoryDetails,
    required this.cancelMonitory,
  }) : super(MonitoryDetailsInitial()) {
    on<SelectedMonitory>((event, emit) => _getMonitoryDetails(event, emit));
    on<CancelMonitoryEvent>((event, emit) => _cancelMonitory(event, emit));
  }

  _getMonitoryDetails(
      SelectedMonitory event, Emitter<MonitoryDetailsState> emit) async {
    emit(LoadingState());
    final failOrDetails =
        await getMonitoryDetails(codMonitory: event.codMonitory);

    emit(
      failOrDetails.fold(
          (fail) => ErrorState(
                msg: fail is ServerFailure
                    ? 'Ops... server failure getting monitory details'
                    : 'Ops... Cache failure getting  monitory details',
              ), (monitory) {
        return MonitoryDetailsRetrieved(monitory: monitory);
      }),
    );
  }

  _cancelMonitory(
      CancelMonitoryEvent event, Emitter<MonitoryDetailsState> emit) async {
    emit(LoadingState());
    final result = await cancelMonitory(codMonitory: event.codMonitory);

    emit(
      result.fold(
          (fail) => ErrorState(
                msg: fail is ServerFailure
                    ? 'Ops... server failure canceling monitory'
                    : 'Ops... Cache failure canceling monitory',
              ), (monitory) {
        return CanceledMonitory();
      }),
    );
  }
}
