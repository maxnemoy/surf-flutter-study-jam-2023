import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_flutter_study_jam_2023/config/singleton.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/export.dart';

class BlocWrapper extends StatelessWidget {
  const BlocWrapper({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TicketCubit(singleton.get<ITicketRepository>()),
        ),
      ],
      child: child!,
    );
  }
}
