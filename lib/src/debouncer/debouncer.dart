import 'dart:async';

import 'package:flutter/foundation.dart';

class DebounceTimer {
  int delayMs;
  Timer? _timer;

  DebounceTimer({required this.delayMs});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: delayMs), action);
  }

  void cancel() {
    _timer?.cancel();
  }
}
