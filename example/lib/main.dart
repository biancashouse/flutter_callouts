import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

import 'callouts-intro.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  fca.logger.d('Running example app');
  fca.loggerNs.i('Info message');
  fca.loggerNs.w('Just a warning!');
  fca.logger.e('Error! Something bad happened', error: 'Test Error');
  fca.loggerNs.t({'key': 5, 'value': 'something'});

  await fca.initLocalStorage();

  runApp(const MaterialApp(title: 'flutter_callouts demo', home: IntroPage()));
}

