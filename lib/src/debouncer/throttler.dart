import 'dart:async';

import 'package:flutter/foundation.dart';

class Throttler {
  final int delayMs;

  Throttler({required this.delayMs});

  bool ready = true;

  void run({required VoidCallback action}) {
    if (ready) {
      action.call();
      ready = false;
    }
    Future.delayed(Duration(milliseconds: delayMs), () {
      ready = true;
    });
  }
}
