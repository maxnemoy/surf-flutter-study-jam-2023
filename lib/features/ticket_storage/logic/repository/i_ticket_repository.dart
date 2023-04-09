import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart' hide singleton;
import 'package:surf_flutter_study_jam_2023/config/app_config.dart';
import 'package:surf_flutter_study_jam_2023/services/local_storage/i_local_storage.dart';

import '../export.dart';

part "./impl/ticket_repository.dart";

abstract class ITicketRepository {
  ValueListenable<Iterable<TicketData>?> get tickets;
  ValueListenable<Iterable<TicketData>?> get unLoadedTickets;
  Future<void> getTickets();
  Future<void> createTicket(TicketData ticketData);
  Future<void> updateTicket(TicketData ticketData);
  Future<void> removeTicket(TicketData ticketData);
}
