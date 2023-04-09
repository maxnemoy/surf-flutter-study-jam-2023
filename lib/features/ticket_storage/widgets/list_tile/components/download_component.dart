import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:surf_flutter_study_jam_2023/config/singleton.dart';
import 'package:surf_flutter_study_jam_2023/services/navigation/i_navigation_service.dart';
import 'package:uuid/uuid.dart';

typedef OnFileUploaded = void Function(String path);

mixin TicketUploader {
  Dio dio = Dio();
  ValueNotifier<double> uploadProgress = ValueNotifier(0);
  ValueNotifier<double> uploadProgressPercent = ValueNotifier(0);
  ValueNotifier<double> totalSize = ValueNotifier(0);
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  OnFileUploaded? onDone;
  Response? _fileUploadResponse;

  upload(String url) async {
    isLoading.value = true;
    try {
      _fileUploadResponse = await dio.get(
        url,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return (status ?? 500) < 500;
            }),
        onReceiveProgress: (count, total) {
          uploadProgress.value = count / 1000000;
          totalSize.value = total / 1000000;
          uploadProgressPercent.value = (count / total);
        },
      );
    } catch (_) {
      singleton.get<INavigationService>().showPopUpDialog(AlertDialog(
            title: const Text("Ошибка загрузки файла"),
            content: const Text(
                "Во время загрузки файла, произошла ошибка. Попробуйте повторить попытку, либо проверьте корректность ссылки."),
            actions: [
              TextButton(
                  onPressed: () {
                    singleton.get<INavigationService>().popDialog();
                    upload(url);
                  },
                  child: const Text("Повторить")),
              TextButton(
                  onPressed: () {
                    singleton.get<INavigationService>().popDialog();
                  },
                  child: const Text("Отмена")),
            ],
          ));
    }

    if (_fileUploadResponse != null) {
      String path =
          await _cacheFile(Uint8List.fromList(_fileUploadResponse!.data));
      onDone?.call(path);
    }
    isLoading.value = false;
  }

  Future<String> _cacheFile(Uint8List rawFileData) async {
    var uuid = const Uuid();
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    String path = "${appDocumentsDir.path}/${uuid.v4()}.pdf";
    File file = File(path); // 1
    await file.writeAsBytes(rawFileData);
    return path;
  }
}
