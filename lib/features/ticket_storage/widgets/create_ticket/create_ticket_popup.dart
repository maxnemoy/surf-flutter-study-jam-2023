import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_flutter_study_jam_2023/config/app_config.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/export.dart';
import 'package:surf_flutter_study_jam_2023/services/export.dart';

import 'export.dart';

class CreateTicketPopup extends StatefulWidget {
  const CreateTicketPopup({
    super.key,
  });

  @override
  State<CreateTicketPopup> createState() => _CreateTicketPopupState();
}

class _CreateTicketPopupState extends State<CreateTicketPopup> {
  late final TextEditingController _urlController;
  late final ValueNotifier<String?> _validateLink;
  late final FocusNode _focusNode;

  late TicketType type;

  @override
  void initState() {
    _urlController = TextEditingController();
    _validateLink = ValueNotifier<String?>(null);
    _focusNode = FocusNode();
    type = TicketType.airplane;
    super.initState();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        if (Uri.parse(_urlController.text).isAbsolute) {
          _validateLink.value = null;
          return;
        }
        _validateLink.value = "Ссылка некорректна";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BottomSheet(
        enableDrag: false,
        onClosing: () {},
        builder: (context) => SizedBox(
          height: 250,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 3,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.black.withOpacity(.3)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ValueListenableBuilder(
                    valueListenable: _validateLink,
                    builder: (context, value, _) => TextField(
                        focusNode: _focusNode,
                        controller: _urlController,
                        decoration: InputDecoration(
                            label: const Text("Введите url"),
                            errorText: value,
                            border: const OutlineInputBorder())),
                  ),
                  TicketTypeSelector(
                    selected: type,
                    onChanged: (v) {
                      setState(() {
                        type = v ?? type;
                      });
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: _validateLink,
                    builder: (context, value, _) => ElevatedButton(
                      onPressed: _urlController.text.isEmpty || value != null
                          ? null
                          : () {
                              context.read<TicketCubit>().createTicket(
                                  TicketData(
                                      type: type,
                                      externalPath: _urlController.text));
                              singleton.get<INavigationService>().pop();
                            },
                      child: const Text('Добавить'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
