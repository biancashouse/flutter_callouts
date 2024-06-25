import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

class DemoPage_AnimatedCallout extends StatefulWidget {
  const DemoPage_AnimatedCallout({super.key});

  static final _color = Colors.blue;

  @override
  State<DemoPage_AnimatedCallout> createState() =>
      _DemoPage_AnimatedCalloutState();

  static Widget demoLaunchBtn(context) => FilledButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const DemoPage_AnimatedCallout()),
          );
        }, // _button1,
        style: FilledButton.styleFrom(backgroundColor: _color),
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'animated callout',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
}

class _DemoPage_AnimatedCalloutState extends State<DemoPage_AnimatedCallout>
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
                  Text('Animated, Resizing, callout using an Overlay'),
                ],
              ),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: FilledButton(
                  key: _targetGK,
                  onPressed: _buttonTapped,
                  style: FilledButton.styleFrom(backgroundColor: Colors.black),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'tap me',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _buttonTapped() async {
    CalloutConfig cc = CalloutConfig(
      feature: "animated-callout",
      initialTargetAlignment: Alignment.bottomLeft,
      initialCalloutAlignment: Alignment.topRight,
      finalSeparation: 150,
      barrier: CalloutBarrier(
        opacity: .5,
        onTappedF: () {
          Callout.dismiss("animated-callout");
        },
      ),
      suppliedCalloutW: 280,
      suppliedCalloutH: 200,
      borderRadius: 12,
      fillColor: DemoPage_AnimatedCallout._color,
      arrowColor: Colors.green,
      arrowType: ArrowType.POINTY,
      animate: true,
      toDelta: -20,
      resizeableH: true,
      resizeableV: true,
      vsync: this,
    );
    Callout.showOverlay(
      targetGkF: () => _targetGK,
      targetChangedNotifier: notifier,
      boxContentF: (ctx) => Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FCallouts().purpleText("Example Callout\nwith a TextEditor",
              fontSize: 24, family: 'Merriweather'),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            width: 240,
            height: 100,

            /// only need feature when wanting to dismiss the editor callout in a callback
            child: FC_TextField(
              inputType: String,
              prompt: () => 'password',
              originalS: '',
              onTextChangedF: (s) async {
                if (s.toLowerCase() == "x") {
                  Callout.dismiss("animated-callout");
                }
              },
              onEscapedF: (s) {
                Callout.dismiss("animated-callout");
              },
              dontAutoFocus: false,
              isPassword: true,
              passwordHelp: "Clue: Elon Musk's favourite letter",
              onEditingCompleteF: (s) {
                Callout.dismiss("animated-callout");
              },
            ),
          ),
          const Text("(this callout is draggable)"),
        ],
      ),
      calloutConfig: cc,
    );
    await Future.delayed(Duration(seconds: 1));
    await cc.animateResizeByCornerMove(Alignment.topLeft, -50, -50,
        duration: 1.seconds);
    await cc.animateResizeByCornerMove(Alignment.topRight, 50, 0, duration: 1.seconds);
    await cc.animateResizeByCornerMove(Alignment.bottomLeft, -50, 50,
        duration: 1.seconds);
    await cc.animateResizeByCornerMove(Alignment.bottomRight, 0, 100,
        duration: 1.seconds);
    await cc.animateCalloutBy(0, 100, durationMs: 500.ms);
    //         afterAnimationF: () => cc.animateCalloutBy(100, 0,
    //             durationMs: 500.ms,
    //             afterAnimationF: () => cc.animateCalloutBy(-200, 200,
    //                 durationMs: 900.ms,
    //                 afterAnimationF: () => cc.animateCalloutBy(200, -200,
    //                     durationMs: 500.ms, afterAnimationF: () => {
    //                   cc.animateCornerBy(Alignment.topLeft, -50, -50, durationMs: 500.ms)
    //                     })))));
  }
}
