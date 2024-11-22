// ignore_for_file: constant_identifier_names

import 'package:bh_shared/bh_shared.dart';

import 'flutter_callouts.dart';

// re-export
export 'package:bh_shared/src/debouncer/debouncer.dart';
export 'package:bh_shared/src/widget/error.dart';
export 'package:bh_shared/src/widget/blink.dart';
export 'package:bh_shared/src/widget/constant_scroll_behavior.dart';
export 'package:bh_shared/src/system_mixin.dart';
export 'package:bh_shared/src//canvas/canvas_mixin.dart';
export 'package:bh_shared/src/widget/widget_helper_mixin.dart';
export 'package:bh_shared/src/gotits_mixin.dart';
export 'package:bh_shared/src/local_storage_mixin.dart';

export 'src/api/callouts/arrow_type.dart';
export 'src/api/callouts/callout_config.dart';
export 'src/api/callouts/named_sc.dart';
// export mixin
export 'src/api/callouts/callout_mixin.dart';
export 'src/api/callouts/callout_using_overlayportal.dart';
export 'src/api/callouts/decoration_shape_enum.dart';
export 'src/api/callouts/coord.dart';
export 'src/api/callouts/dotted_decoration.dart';
export 'src/api/callouts/line.dart';
export 'src/api/callouts/globalkey_extn.dart';
export 'src/feature_discovery/discovery_controller.dart';
export 'src/feature_discovery/discovery_overlay.dart';
export 'src/feature_discovery/featured_widget.dart';
export 'src/feature_discovery/flat_icon_button_with_callout_player.dart';
export 'src/feature_discovery/overlay_builder.dart';
export 'src/feature_discovery/play_callout_button.dart';
export 'src/feature_discovery/play_overlays_button.dart';
export 'src/mq_mixin.dart';
export 'src/rootcontext_mixin.dart';

export 'src/measuring/measure_sizebox.dart';
export 'src/measuring_mixin.dart';
export 'src/text_editing/string_editor.dart';
export 'src/text_editing/textfield_callout.dart';
export 'src/api/callouts/color_values.dart';

export 'src/typedefs.dart';

// client apps will only access this functionality thru this global instance
FlutterCalloutMixins fca = FlutterCalloutMixins.instance;

class FlutterCalloutMixins
    with
        MeasuringMixin,
        CalloutMixin,
        RootContextMixin,
        MQMixin,
        SystemMixin,
        WidgetHelperMixin,
        GotitsMixin,
        CanvasMixin,
        LocalStorageMixin {
  FlutterCalloutMixins._internal() // Private constructor
  {
    BaseMixins.instance;
    logi('FlutterCallouts._internal()');
  }

  static final FlutterCalloutMixins _instance =
      FlutterCalloutMixins._internal();

  static FlutterCalloutMixins get instance {
    return _instance;
  }

}
