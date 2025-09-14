import 'dart:async';

import 'package:flutter/foundation.dart';

class Debouncer {
  int delayMs;
  Timer? _timer;

  Debouncer({required this.delayMs});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: delayMs), action);
  }

  void cancel() {
    _timer?.cancel();
  }
}
