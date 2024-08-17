// ignore_for_file: constant_identifier_names


import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

mixin RootContextMixin {

  static BuildContext? _rootContext;

  BuildContext get rootContext {
    if (_rootContext == null) {
      throw (Exception("NULL rootContext !"));
    } else {
      return _rootContext!;
    }
  }

  set rootContext(BuildContext? newContext) {
    if (newContext == null) {
      throw (Exception("setting rootContext NULL !"));
    }
    _rootContext = newContext;
  }

  // must be called from a widget build
  void initWithContext(BuildContext context) {
    fca.logi('initWithContext');
    rootContext = context;
    fca.initDeviceInfoAndPlatform();
    // fca.createOffstageOverlay(context);
  }
}