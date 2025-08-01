// ignore_for_file: constant_identifier_names


import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

import 'api/app_keys.dart';

mixin RootContextMixin {

  BuildContext get rootContext {
    // This gives the context of the Navigator, which is what you usually want for overlays
    var rc = navigatorKey.currentContext;
    if (rc == null) {
      throw Exception("NULL rootContext ! - you must use FC_MaterialApp instead of MaterialApp");
    }
    return rc;
  }

  OverlayState? get overlayState {
    // This is often more direct for inserting OverlayEntry widgets
    return navigatorKey.currentState?.overlay;
  }
}