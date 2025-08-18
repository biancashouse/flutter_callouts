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
            "NULL rootContext ! - you must have passed globalNavigatorKey to your MaterialApp or to your router constructor:\n\n"
            "MaterialApp(navigatorKey: fca.globalNavigatorKey,)\n\n"
            " or\n\n"
            "router = GoRouter.routingConfig(navigatorKey: fco.globalNavigatorKey,...\n\n"
                "NOTE - flutter_content uses this pkg and introduces go_router usage"
      );
    }
    return rc;
  }

  // callouts get created in the context of the navigator
  OverlayState? get overlayState {
    // This is often more direct for inserting OverlayEntry widgets
    var cs = _navigatorKey.currentState;
    return cs?.overlay;
  }
}
