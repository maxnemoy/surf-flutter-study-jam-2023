part of 'cubit.dart';

abstract class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object> get props => [];
}

class TicketInitState extends TicketState {}

class TicketLoadState extends TicketState {}

class TicketShowState extends TicketState {
  final Iterable<TicketData>? tickets;
  final bool isTryAllUpload;

  const TicketShowState({this.tickets, this.isTryAllUpload = false});
}
