part of 'monitory_details_bloc.dart';

abstract class MonitoryDetailsState extends Equatable {
  const MonitoryDetailsState();

  @override
  List<Object> get props => [];
}

class MonitoryDetailsInitial extends MonitoryDetailsState {}

class MonitoryDetailsRetrieved extends MonitoryDetailsState {
  final AvailableMonitory monitory;

  const MonitoryDetailsRetrieved({required this.monitory});
}
class CanceledMonitory extends MonitoryDetailsState {}

class LoadingState extends MonitoryDetailsState {}

class ErrorState extends MonitoryDetailsState {
  final String msg;

  const ErrorState({required this.msg});

  @override
  List<Object> get props => [msg];
}
