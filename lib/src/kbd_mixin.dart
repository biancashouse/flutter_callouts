// ignore_for_file: constant_identifier_names

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_callouts/flutter_callouts.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:universal_platform/universal_platform.dart';

import 'logger_filter.dart';

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

