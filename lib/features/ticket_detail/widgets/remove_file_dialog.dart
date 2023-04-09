import 'package:flutter/material.dart';

class RemoveFileDialog extends StatelessWidget {
  final VoidCallback? onOkAction;
  final VoidCallback? onCancelAction;
  const RemoveFileDialog({super.key, this.onOkAction, this.onCancelAction});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Внимание!"),
      content: const Text("Вы действительно хотите удалить билет?"),
      actions: [
        TextButton(
            onPressed: onOkAction,
            child: Text(
              "Удалить",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.red),
            )),
        TextButton(
            onPressed: onOkAction,
            child: Text(
              "Отмена",
              style: Theme.of(context).textTheme.bodyMedium,
            )),
      ],
    );
  }
}
