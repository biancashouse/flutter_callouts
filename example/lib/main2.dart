import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';
import 'package:window_manager/window_manager.dart';

// conditional import for webview ------------------
import 'alignment_picker_demo.dart';
import 'register_ios_or_android_webview.dart'
if (dart.library.html) 'register_web_webview.dart';

import 'intro_page.dart';

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      if (fca.isMac || fca.isWindows) {
        await windowManager.ensureInitialized();

        // Define the window options
        WindowOptions windowOptions = const WindowOptions(
          size: Size(1280, 1190),
          // Set your desired width and height
          center: true,
          // Center the window on the screen
          backgroundColor: Colors.transparent,
          skipTaskbar: false,
          titleBarStyle: TitleBarStyle.normal,
          title: "My Awesome Flutter App", // Optional: Set a window title
        );

        // Wait until the window is ready to show, then apply options and show
        windowManager.waitUntilReadyToShow(windowOptions, () async {
          await windowManager.show();
          await windowManager.focus();
        });
      }

      // see conditional imports for web or mobile
      registerWebViewImplementation();

      runApp(
        const FlutterCalloutsApp(
          title: 'flutter_callouts demo',
          home: AlignmentPickerDemo(),
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
