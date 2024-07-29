// ignore_for_file: constant_identifier_names

library flutter_callouts;

import 'package:bh_shared/bh_shared.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'flutter_callouts.dart';

export 'src/api/callouts/arrow_type.dart';
export 'src/api/callouts/callout.dart';
export 'src/api/callouts/callout_config.dart';
export 'src/api/callouts/dotted_decoration.dart';
export 'src/api/callouts/decoration_shape_enum.dart';
export 'src/api/callouts/callout_using_overlayportal.dart';

// export mixin
export 'src/callout_mixin.dart';
export 'src/feature_discovery/flat_icon_button_with_callout_player.dart';
export 'src/gotits/gotits_helper.dart';
export 'src/measuring/measure_sizebox.dart';
export 'src/measuring_mixin.dart';
export 'src/mq_mixin.dart';
export 'src/scrolling_mixin.dart';
export 'src/rootcontext_mixin.dart';
export 'src/text_editing/fc_textfield_T.dart';
export 'src/typedefs.dart';

// client apps will only access this functionality thru this global instance
FlutterCalloutMixins fca = FlutterCalloutMixins.instance;

class FlutterCalloutMixins
    with
        MeasuringMixin,
        CalloutMixin,
        ScrollingMixin,
        RootContextMixin,
        MQMixin,
        SystemMixin,
        WidgetHelperMixin,
        LocalStorageMixin {
  FlutterCalloutMixins._internal() // Private constructor
  {
    debugPrint('FlutterCallouts._internal()');
  }

  static final FlutterCalloutMixins _instance = FlutterCalloutMixins._internal();

  static FlutterCalloutMixins get instance {
    return _instance;
  }
}
