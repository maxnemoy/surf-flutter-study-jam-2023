import 'package:flutter/material.dart';
import 'package:surf_flutter_study_jam_2023/config/app_config.dart';
import 'package:surf_flutter_study_jam_2023/services/export.dart';

import '../../export.dart';

class TicketListView extends StatelessWidget {
  final Iterable<TicketData>? items;
  final bool tryAllUpload;
  const TicketListView(
      {super.key, required this.items, required this.tryAllUpload});

  @override
  Widget build(BuildContext context) {
    if (items == null || items!.isEmpty) {
      return const _NoElementsView();
    }

    return SelectableListWrapper<int>(
      selectedItems: ValueNotifier([]),
      child: ListView(
        children: items!
            .map(
              (e) => CustomListTileItem(
                tryUploadAfterDraw: tryAllUpload,
                data: e,
                onTap: () {
                  singleton
                      .get<INavigationService>()
                      .push("/ticketDetail", extra: {"item": e});
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

class _NoElementsView extends StatelessWidget {
  const _NoElementsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: .6,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.airplane_ticket_outlined,
              size: 100,
            ),
            Text(
              "Здесь пока ничего нет",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
