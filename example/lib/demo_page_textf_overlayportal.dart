import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

class DemoPage_TextInAnOverlayPortal extends StatefulWidget {
  const DemoPage_TextInAnOverlayPortal({super.key});

  @override
  State<DemoPage_TextInAnOverlayPortal> createState() =>
      _DemoPage_TextInAnOverlayPortalState();

  static Widget demoLaunchBtn(context) => FilledButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const DemoPage_TextInAnOverlayPortal()),
          );
        }, // _button1,
        style: FilledButton.styleFrom(backgroundColor: Colors.orange),
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'Text in an OverlayPortal',
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
}

class _DemoPage_TextInAnOverlayPortalState
    extends State<DemoPage_TextInAnOverlayPortal>
    with TickerProviderStateMixin {
  /// notifier used to trigger target and/or callout rebuilds on windows resize, or scrolling, or callout move/resize
  final notifier = ValueNotifier<int>(0);

  /// need a focus to handle Esc key
  final focusNodeForEscapeKey = FocusNode();

  /// giving the target widget a GlobalKey allows its pos and size to be measured
  final _targetGK = GlobalKey();

  @override
  void didChangeDependencies() {
    /// initialize the Callouts API with the root context
    FCallouts().initWithContext(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    /// detect window size changes
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (SizeChangedLayoutNotification notification) {
        debugPrint("SizeChangedLayoutNotification - onNotification()");
        // Callout.dismissAll();
        notifier.value++;
        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: KeyboardListener(
          autofocus: true,
          focusNode: focusNodeForEscapeKey, // <-- more magic
          onKeyEvent: (KeyEvent event) {
            if (event.logicalKey == LogicalKeyboardKey.escape) {
              Callout.dismissAll();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () => Navigator.pop(context, true),
              ),
              title: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Text in an OverlayPortal'),
                ],
              ),
            ),
            body: Center(
              child: WrappedCallout(
                targetChangedNotifier: notifier,
                calloutBoxContentBuilderF: (context) => Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FCallouts().purpleText(
                      "Animated,\nResizeable,\nDraggable,\nExample Callout",
                      fontSize: 24,
                      family: 'Merriweather',
                    ),
                  ],
                ),
                calloutConfig: CalloutConfig(
                  vsync: this,
                  feature: "bottom-left",
                  initialTargetAlignment: Alignment.bottomLeft,
                  initialCalloutAlignment: Alignment.topRight,
                  finalSeparation: 150,
                  barrier: CalloutBarrier(
                    opacity: .5,
                    onTappedF: () {
                      Callout.hideParentCallout(context);
                    },
                  ),
                  suppliedCalloutW: 280,
                  suppliedCalloutH: 200,
                  borderRadius: 12,
                  fillColor: Colors.orange,
                  animate: true,
                  resizeableH: true,
                  resizeableV: true,
                ),
                targetBuilderF: (ctx) => FilledButton(
                  key: _targetGK,
                  onPressed: () => Callout.unhideParentCallout(ctx, animateSeparation: false),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.all(10),
                    textStyle: TextStyle(color: Colors.white),
                  ),
                  child: Text('tap me'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
