// library pkg_flutter_callout;

// ignore_for_file: constant_identifier_names

// import 'flutter_callouts.dart';
import 'package:flutter_callouts/src/kbd_mixin.dart';
import 'package:flutter_callouts/src/ls_mixin.dart';
import 'package:flutter_callouts/src/measuring_mixin.dart';
import 'src/api/callouts/callout_mixin.dart';
import 'src/canvas/canvas_mixin.dart';
import 'src/feature_discovery/discovery_mixin.dart';
import 'src/gotits_mixin.dart';
import 'src/root_context_mixin.dart';
import 'src/system_mixin.dart';
import 'src/widget/widget_helper_mixin.dart';

export 'src/api/callouts/callout_config.dart';

// export mixin
export 'src/api/callouts/callout_mixin.dart';
export 'src/api/callouts/callout_using_overlayportal.dart';
export 'src/api/callouts/color_values.dart';
export 'src/api/callouts/coord.dart';
export 'src/api/callouts/dotted_decoration.dart';
export 'src/api/callouts/globalkey_extn.dart';
export 'src/api/callouts/line.dart';
export 'src/api/callouts/model/alignment_enum.dart';
export 'src/api/callouts/model/arrow_type_enum.dart';
export 'src/api/callouts/model/color_model.dart';
export 'src/api/callouts/model/decoration_shape_enum.dart';
export 'src/api/callouts/model/offset_model.dart';
export 'src/api/callouts/named_sc.dart';
export 'src/canvas/canvas_mixin.dart';
export 'src/debouncer/debouncer.dart';
export 'src/feature_discovery/discovery_controller.dart';
export 'src/feature_discovery/discovery_mixin.dart';
export 'src/feature_discovery/discovery_overlay.dart';
export 'src/feature_discovery/featured_widget.dart';
export 'src/feature_discovery/flat_icon_button_with_callout_player.dart';
export 'src/feature_discovery/overlay_builder.dart';
export 'src/feature_discovery/play_callout_button.dart';
export 'src/feature_discovery/play_overlays_button.dart';
export 'src/gotits_mixin.dart';
export 'src/kbd_mixin.dart';
export 'src/ls_mixin.dart';
export 'src/measuring/measure_sizebox.dart';
export 'src/measuring_mixin.dart';
export 'src/root_context_mixin.dart';
export 'src/system_mixin.dart';
export 'src/typedefs.dart';
export 'src/widget/blink.dart';
export 'src/widget/constant_scroll_behavior.dart';
export 'src/widget/error.dart';
export 'src/widget/widget_helper_mixin.dart';

// re-export
export 'package:logger/src/logger.dart';
export 'package:logger/src/log_filter.dart';
export 'package:logger/src/printers/pretty_printer.dart';

// client apps will only access this functionality thru this global instance
FlutterCalloutMixins fca = FlutterCalloutMixins.instance;

class FlutterCalloutMixins
    with
        MeasuringMixin,
        CalloutMixin,
        DiscoveryMixin,
        RootContextMixin,
        SystemMixin,
        KeystrokesMixin,
        LocalStorageMixin,
        WidgetHelperMixin,
        GotitsMixin,
        CanvasMixin {
  FlutterCalloutMixins._internal() // Private constructor
  {
    // BaseMixins.instance;
    // logger.i('FlutterCallouts._internal()');
  }

  static FlutterCalloutMixins get instance {
    return FlutterCalloutMixins._internal();
  }

  // Storage get localStorage {
  //   return HydratedBloc.storage;
  // }
  //
  // Future<void> init() async {
  //   HydratedBloc.storage = await HydratedStorage.build(
  //     storageDirectory: kIsWeb
  //         ? HydratedStorageDirectory.web
  //         : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  //   );
  // }
}
