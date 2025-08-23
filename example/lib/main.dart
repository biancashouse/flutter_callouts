import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

import 'callouts_intro.dart';

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      runApp(
        const FlutterCalloutsApp(
          title: 'flutter_callouts demo',
          home: IntroPage(),
        ),
      );
    },
    (Object error, StackTrace stack) {
      // Handle the error here, e.g., log it, show a dialog, etc.
      print('Caught error in runZonedGuarded: $error');
      print('Stack trace: $stack');
      // Optionally, send the error to a crash reporting service like Sentry or Firebase Crashlytics
    },
  );
}
