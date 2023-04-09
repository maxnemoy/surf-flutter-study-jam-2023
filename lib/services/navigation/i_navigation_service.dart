import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:go_router/go_router.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_detail/export.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/export.dart';

part './impl/navigation_service.dart';

abstract class INavigationService {
  GoRouter get router;
  GlobalKey<ScaffoldMessengerState> get massagerKey;
  GlobalKey<NavigatorState> get navigatorKey;

  void showToast(String text);

  Future<dynamic> showPopUpDialog(
    Widget dialog, {
    bool barrierDismissible = true,
  });
  void popDialog({dynamic ext});

  void push(String path, {Object? extra});
  void go(String path, {Object? extra});
  void pop();
}
