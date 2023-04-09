import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:surf_flutter_study_jam_2023/config/app_config.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_detail/export.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/export.dart';
import 'package:surf_flutter_study_jam_2023/services/export.dart';

class TicketDetailPage extends StatelessWidget {
  final TicketData? data;
  const TicketDetailPage({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Информация"),
        actions: [
          TextButton(
              onPressed: () {
                singleton
                    .get<INavigationService>()
                    .showPopUpDialog(RemoveFileDialog(
                      onCancelAction: () {
                        singleton.get<INavigationService>().popDialog();
                      },
                      onOkAction: () {
                        context.read<TicketCubit>().removeTicket(data!);
                        singleton.get<INavigationService>().go("/");
                      },
                    ));
              },
              child: const Text("Удалить"))
        ],
      ),
      body: data != null
          ? Column(
              children: [
                if (data?.localPath != null)
                  Expanded(
                    child: PDFView(
                      filePath: data!.localPath,
                      enableSwipe: true,
                      swipeHorizontal: false,
                      autoSpacing: false,
                      pageFling: false,
                    ),
                  )
              ],
            )
          : const Center(
              child: Text("Нет элементов для отображения"),
            ),
    );
  }
}
