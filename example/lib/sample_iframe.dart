import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class SampleIFrame extends StatelessWidget {
  const SampleIFrame({super.key});

  @override
  Widget build(BuildContext context) {
    // var navigationParams = const PlatformNavigationDelegateCreationParams();
    var controllerParams = const PlatformWebViewControllerCreationParams();
    var controller = PlatformWebViewController(controllerParams)
      // ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        LoadRequestParams(
          uri: Uri.parse(
            "https://docs.google.com/document/d/e/2PACX-1vQs8513mgRcxNUcf2TcIv5EY_nCCjUrdWt7_OooiVLdTslDSnQYY31IEWKROTCaki0MwdHDWFunu6ix/pub?embedded=true",
          ),
        ),
      );
    var gestureRecognizers = <Factory<OneSequenceGestureRecognizer>>{
      Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
    };
    var widgetParams = PlatformWebViewWidgetCreationParams(
      controller: controller,
      gestureRecognizers: gestureRecognizers,
    );
    var webViewWidget = PlatformWebViewWidget(widgetParams);

    return webViewWidget.build(context);
  }
}
