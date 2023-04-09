import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:surf_flutter_study_jam_2023/config/singleton.dart';
import 'package:surf_flutter_study_jam_2023/services/export.dart';

import '../export.dart';

part 'state.dart';

class TicketCubit extends Cubit<TicketState> {
  final ITicketRepository _repository;

  TicketCubit(this._repository) : super(TicketInitState()) {
    _repository.tickets.addListener(() {
      emit(TicketShowState(tickets: _repository.tickets.value ?? []));
    });
  }

  Future<void> getTickets() async {
    emit(TicketLoadState());
    _repository.getTickets();
  }

  Future<void> createTicket(TicketData ticket) async {
    emit(TicketLoadState());
    await _repository.createTicket(ticket);
    try {
      singleton.get<INavigationService>().showToast("Билет успешно добавлен");
    } catch (_) {
      singleton
          .get<INavigationService>()
          .showToast("Ошибка при добавлении билета");
    }
  }

  Future<void> updateTicket(TicketData ticket) async {
    emit(TicketLoadState());
    _repository.updateTicket(ticket);
  }

  Future<void> removeTicket(TicketData ticket) async {
    emit(TicketLoadState());
    _repository.removeTicket(ticket);
  }
}
