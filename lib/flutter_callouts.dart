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
export 'src/model/decoration_shape_enum.dart';
export 'src/api/callouts/arrow_type.dart';
export 'src/api/callouts/zoomer.dart';
export 'src/typedefs.dart';
export 'src/callout_useful.dart';

class FCallouts with CalloutUseful, BaseUseful, WidgetHelper, BrowserStorage {
  FCallouts._();

  // Static instance variable
  static FCallouts? _instance;

  // Factory method to provide access to the singleton instance
  factory FCallouts() {
    // If the instance doesn't exist, create it
    _instance ??= FCallouts._();
    return _instance!;
  }

  // must be called from a widget build
  void initWithContext(BuildContext context) {
    if (super.rootContext == null) {
      initDeviceInfoAndPlatform();
      afterNextBuildDo(() {
        createOffstageOverlay(context);
      });
    }
    rootContext = context;
  }
}
