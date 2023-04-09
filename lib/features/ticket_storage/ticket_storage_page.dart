import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'export.dart';

/// Экран “Хранения билетов”.
class TicketStoragePage extends StatefulWidget {
  const TicketStoragePage({Key? key}) : super(key: key);

  @override
  State<TicketStoragePage> createState() => _TicketStoragePageState();
}

class _TicketStoragePageState extends State<TicketStoragePage> {
  late bool _isFloatingHidden;

  @override
  void initState() {
    _isFloatingHidden = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Хранение билетов"),
      ),
      floatingActionButton: _isFloatingHidden ? null : const _FloatingMenu(),
      body: BlocBuilder<TicketCubit, TicketState>(
        bloc: context.read<TicketCubit>(),
        builder: (context, state) {
          if (state is TicketInitState) {
            context.read<TicketCubit>().getTickets();
            return const CircularProgressIndicator();
          }
          if (state is TicketLoadState) {
            return const CircularProgressIndicator();
          }
          if (state is TicketShowState) {
            return ScrollWrapper(
              onEndPosition: () {
                setState(() {
                  _isFloatingHidden = true;
                });
              },
              onStarPosition: () {
                setState(() {
                  _isFloatingHidden = false;
                });
              },
              child: TicketListView(
                items: state.tickets,
                tryAllUpload: state.isTryAllUpload,
              ),
            );
          }

          throw "Undefined TicketCubit state!";
        },
      ),
    );
  }
}

class _FloatingMenu extends StatelessWidget {
  const _FloatingMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton.extended(
            onPressed: () {
              showModalBottomSheet(
                  isDismissible: true,
                  enableDrag: true,
                  context: context,
                  isScrollControlled: true,
                  clipBehavior: Clip.hardEdge,
                  builder: (context) => const CreateTicketPopup());
            },
            label: const Text("Добавить")),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
