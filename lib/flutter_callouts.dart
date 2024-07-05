// ignore_for_file: constant_identifier_names

library flutter_callouts;

import 'package:bh_shared/bh_shared.dart';
import 'package:flutter/material.dart';

import 'flutter_callouts.dart';

export 'src/api/callouts/callout.dart';
export 'src/api/callouts/callout_using_overlayportal.dart';
export 'src/api/callouts/callout_config.dart';
export 'src/feature_discovery/flat_icon_button_with_callout_player.dart';
export 'src/gotits/gotits_helper.dart';
export 'src/measuring/find_global_rect.dart';
export 'src/measuring/measure_sizebox.dart';
export 'src/measuring/text_measuring.dart';
export 'src/text_editing/fc_textfield_T.dart';
export 'src/api/callouts/arrow_type.dart';
export 'src/api/callouts/zoomer.dart';
export 'src/typedefs.dart';
export 'src/callout_useful.dart';

// client apps will only access this functionality thru this global instance
FlutterCallouts fca = FlutterCallouts.instance;

class FlutterCallouts extends BaseGlobal with CalloutUseful {

  FlutterCallouts._internal() // Private constructor
  {
    debugPrint('FlutterCallouts._internal()');
  }

  static final FlutterCallouts _instance = FlutterCallouts._internal();

  static FlutterCallouts get instance {
    return _instance;
  }

  // must be called AFTER a first widget build
  @override
  void initWithContext(BuildContext context, {VoidCallback? f}) {
    super.initWithContext(context, f: ()=>createOffstageOverlay(context));
  }
}
