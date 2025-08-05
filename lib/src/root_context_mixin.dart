// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

mixin RootContextMixin {
  static final _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get globalNavigatorKey => _navigatorKey;

  BuildContext get rootContext {
    // This gives the context of the Navigator, which is what you usually want for overlays
    var rc = _navigatorKey.currentContext;
    if (rc == null) {
      throw Exception(
        "NULL rootContext ! - you must use FC_MaterialApp instead of MaterialApp",
      );
    }
    return rc;
  }

  OverlayState? get overlayState {
    // This is often more direct for inserting OverlayEntry widgets
    var cs = _navigatorKey.currentState;
    return cs?.overlay;
  }
}
