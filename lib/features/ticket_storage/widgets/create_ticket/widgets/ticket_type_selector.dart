import 'package:flutter/material.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/export.dart';

typedef OnTicketTypeChanged = void Function(TicketType? type);

class TicketTypeSelector extends StatelessWidget {
  final TicketType selected;
  final OnTicketTypeChanged onChanged;
  const TicketTypeSelector(
      {super.key, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Тип билета"),
        DropdownButton<TicketType>(
            value: selected,
            items: TicketType.values
                .map((e) => DropdownMenuItem<TicketType>(
                    value: e,
                    child: Row(
                      children: [
                        Icon(const IconData(0).fromTicketType(e)),
                        Text(e.name)
                      ],
                    )))
                .toList(),
            onChanged: onChanged),
      ],
    );
  }
}
