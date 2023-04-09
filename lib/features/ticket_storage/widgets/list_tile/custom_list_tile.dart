import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:surf_flutter_study_jam_2023/config/app_config.dart';

import '../../export.dart';

class CustomListTileItem extends StatefulWidget {
  final TicketData data;
  final VoidCallback? onTap;
  final bool tryUploadAfterDraw;
  const CustomListTileItem(
      {super.key,
      this.onTap,
      required this.data,
      this.tryUploadAfterDraw = false});

  @override
  State<CustomListTileItem> createState() => _CustomListTileItemState();
}

class _CustomListTileItemState extends State<CustomListTileItem>
    with TicketUploader {
  CustomListTileTheme? theme;
  @override
  void initState() {
    onDone = (path) {
      context
          .read<TicketCubit>()
          .updateTicket(widget.data.copyWith(localPath: path));
    };
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.tryUploadAfterDraw) {
        upload(widget.data.externalPath);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context).extension<CustomListTileTheme>();
    SelectableListWrapper<int> selected =
        SelectableListWrapper.of<int>(context);

    return ListTile(
      onTap: widget.onTap,
      onLongPress: () {
        selected.change(widget.data.id!);
      },
      leading: IconTheme(
        data: theme?.leadingIconStyle ?? const IconThemeData(),
        child: Icon(
          const IconData(0).fromTicketType(widget.data.type),
          size: theme?.leadingIconStyle?.size,
          color: theme?.leadingIconStyle?.color,
        ),
      ),
      title: DefaultTextStyle(
          style: theme?.titleTextStyle ?? const TextStyle(),
          child: Text("Ticket ${widget.data.id}")),
      subtitle: _buildSubtitle(),
      trailing: _buildTrailing(),
    );
  }

  Widget _buildSubtitle() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.data.localPath == null
              ? ValueListenableBuilder(
                  valueListenable: uploadProgressPercent,
                  builder: (context, value, _) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: LinearProgressIndicator(
                      value: value,
                    ),
                  ),
                )
              : const LinearProgressIndicator(
                  value: 1,
                ),
          DefaultTextStyle(
            style: theme?.subTitleTextStyle ?? const TextStyle(),
            child: widget.data.localPath != null
                ? const Text("Файл загружен")
                : ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (context, value, _) => value
                        ? Row(
                            children: [
                              const Text("Загружается "),
                              ValueListenableBuilder(
                                  valueListenable: uploadProgress,
                                  builder: (context, value, _) =>
                                      Text(value.toStringAsFixed(2))),
                              const Text(" из "),
                              ValueListenableBuilder(
                                  valueListenable: totalSize,
                                  builder: (context, value, _) =>
                                      Text(value.toStringAsFixed(2))),
                            ],
                          )
                        : const Text("Ожидается загрузка"),
                  ),
          )
        ]);
  }

  Widget _buildTrailing() {
    SelectableListWrapper<int> selected =
        SelectableListWrapper.of<int>(context);

    return ValueListenableBuilder(
        valueListenable: selected.selectedItems,
        builder: (context, value, _) {
          if (value.isNotEmpty) {
            return Checkbox(
                value: value.contains(widget.data.id),
                onChanged: (v) {
                  selected.change(widget.data.id!);
                });
          }

          return widget.data.localPath == null
              ? ValueListenableBuilder(
                  valueListenable: isLoading,
                  builder: (context, value, _) {
                    if (value) {
                      return IconTheme(
                          data:
                              theme?.trailingIconStyle ?? const IconThemeData(),
                          child: const Icon(Icons.pause_circle_outline));
                    }
                    return InkWell(
                      onTap: () {
                        upload(widget.data.externalPath);
                      },
                      child: IconTheme(
                          data:
                              theme?.trailingIconStyle ?? const IconThemeData(),
                          child: const Icon(Icons.cloud_download_outlined)),
                    );
                  })
              : IconTheme(
                  data: theme?.trailingIconStyle ?? const IconThemeData(),
                  child: const Icon(Icons.cloud_done));
        });
  }
}
