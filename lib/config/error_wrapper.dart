import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppWrapper {
  final List<AsyncCallback> _initializeFunctions = [];

  AppWrapper({List<AsyncCallback>? initializers}) {
    _initializeFunctions.addAll(initializers ?? []);
  }

  void addInitializer(AsyncCallback initializer) {
    _initializeFunctions.add(initializer);
  }

  void _syncErrorWrapper(FlutterErrorDetails errorDetails) {
    debugPrint("""Sync ERROR LOG: ${errorDetails.library}
    EXCEPTION: ${errorDetails.exception}
    STACK: ${errorDetails.stack}
    
    """);
    // debugPrint("""
    // EXCEPTION: ${errorDetails.exception}
    // """);
  }

  void _asyncErrorWrapper(Object error, StackTrace stackTrace) {
    debugPrint('Async ERROR LOG: $error');
    debugPrint('Async ERROR LOG: $stackTrace');
  }

  void runApplication(Widget widget) {
    runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();

      for (var initializer in _initializeFunctions) {
        debugPrint("Init APP");
        await initializer.call();
      }

      FlutterError.onError = _syncErrorWrapper;

      runApp(widget);
    }, _asyncErrorWrapper);
  }
}
