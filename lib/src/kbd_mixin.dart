// ignore_for_file: constant_identifier_names

import 'package:flutter/services.dart';
import 'package:flutter_callouts/flutter_callouts.dart';


mixin KeystrokesMixin {
  Map<String, KeystrokeHandler> keystrokeHandlers = {};

  void registerKeystrokeHandler(String handlerId, KeystrokeHandler handler) {
    if (keystrokeHandlers.containsKey(handlerId)) return;
    keystrokeHandlers[handlerId] = handler;
    ServicesBinding.instance.keyboard.addHandler(handler);
  }

  void removeKeystrokeHandler(String handlerId) {
    if (keystrokeHandlers.containsKey(handlerId)) {
      ServicesBinding.instance.keyboard.removeHandler(keystrokeHandlers[handlerId]!);
      keystrokeHandlers.remove(handlerId);
    }
  }

}

