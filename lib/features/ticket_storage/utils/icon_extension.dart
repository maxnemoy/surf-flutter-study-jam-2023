import 'package:flutter/material.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/export.dart';

extension IconFrom on IconData {
  IconData fromTicketType(TicketType type) {
    switch (type) {
      case TicketType.airplane:
        return Icons.airplane_ticket;
      case TicketType.train:
        return Icons.train;
      case TicketType.bus:
        return Icons.bus_alert;
      default:
        throw "$type don`t have icon data";
    }
  }
}
