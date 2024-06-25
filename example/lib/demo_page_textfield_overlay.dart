import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

class DemoPage_TextFieldInAnOverlay extends StatefulWidget {
  const DemoPage_TextFieldInAnOverlay({super.key});

  static final _color = Colors.lime;

  @override
  State<DemoPage_TextFieldInAnOverlay> createState() =>
      _DemoPage_TextFieldInAnOverlayState();

  static Widget demoLaunchBtn(context) => FilledButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const DemoPage_TextFieldInAnOverlay()),
          );
        }, // _button1,
        style: FilledButton.styleFrom(backgroundColor: _color),
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'Textfield dialog in an Overlay',
            style: TextStyle(color: Colors.black),
          ),
        ),
      );

  static Widget bottomSheetContents(scaffoldChildContext) => const Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Text('About this callout',
          //     style: TextStyle(
          //         fontWeight: FontWeight.bold, color: Colors.white70)),
          Text(
            '''
Invoked via Callouts.showOverlay(...)
Callout is an Overlay
Has a 25% opacity barrier
Tap barrier, or press Esc key, to close callout
Callout 'points' to its Target widget (button)
Pointer is animated
Pointer type is ArrowType.THIN''',
            textScaler: TextScaler.linear(.9),
            style: TextStyle(color: Colors.white, fontFamily: 'monospace'),
          ),
        ],
      );
}

class _DemoPage_TextFieldInAnOverlayState
    extends State<DemoPage_TextFieldInAnOverlay> with TickerProviderStateMixin {
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
                  const Text('TextField dialog in an Overlay'),
                ],
              ),
              actions: [
                // TODO - button to show page code on github
              ],
            ),
            body: Builder(builder: (scaffoldChildContext) {
              return Center(
                child: FilledButton(
                  key: _targetGK,
                  onPressed: () {
                    // show the callout
                    _buttonTapped(scaffoldChildContext);
                    // show info about this demo
                    showBottomSheet(
                        backgroundColor: Colors.black,
                        context: scaffoldChildContext,
                        builder: (_) {
                          return Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: DemoPage_TextFieldInAnOverlay
                                .bottomSheetContents(scaffoldChildContext),
                          );
                        });
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.all(10),
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                  child: const Text('tap me'),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Future<void> _buttonTapped(BuildContext scaffoldChildContext) async {
    CalloutConfig cc = CalloutConfig(
      feature: "textfield-callout",
      initialTargetAlignment: Alignment.bottomLeft,
      initialCalloutAlignment: Alignment.topRight,
      finalSeparation: 150,
      barrier: CalloutBarrier(
        opacity: .5,
        onTappedF: () {
          Callout.dismiss("textfield-callout");
        },
      ),
      suppliedCalloutW: 280,
      suppliedCalloutH: 200,
      borderRadius: 12,
      fillColor: DemoPage_TextFieldInAnOverlay._color,
      arrowColor: Colors.green,
      arrowType: ArrowType.POINTY,
      animate: true,
      toDelta: -20,
      resizeableH: true,
      resizeableV: true,
      vsync: this,
      onDismissedF: () {
        Navigator.pop(scaffoldChildContext);
      },
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
                  Callout.dismiss("textfield-callout");
                }
              },
              onEscapedF: (s) {
                Callout.dismiss("textfield-callout");
              },
              dontAutoFocus: false,
              isPassword: true,
              passwordHelp: "Clue: Elon Musk's favourite letter",
              onEditingCompleteF: (s) {
                Callout.dismiss("textfield-callout");
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

// class DemoPage_TextFieldInAnOverlay extends StatefulWidget {
//   static final _color = Colors.lime;
//
//   const DemoPage_TextFieldInAnOverlay({super.key});
//
//   @override
//   State<DemoPage_TextFieldInAnOverlay> createState() =>
//       _DemoPage_TextFieldInAnOverlayState();
//
//   static Widget demoLaunchBtn(context) => FilledButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => const DemoPage_TextFieldInAnOverlay()),
//           );
//         }, // _button1,
//         style: FilledButton.styleFrom(backgroundColor: _color),
//         child: const Padding(
//           padding: EdgeInsets.all(8),
//           child: Text(
//             'TextField Dialog in an Overlay',
//             style: TextStyle(color: Colors.black),
//           ),
//         ),
//       );
//
//   static Widget bottomSheetContents(scaffoldChildContext) => const Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           // Text('About this callout',
//           //     style: TextStyle(
//           //         fontWeight: FontWeight.bold, color: Colors.white70)),
//           Text(
//             '''
// Invoked via Callouts.showOverlay(...)
// Callout is an Overlay
// Has a 25% opacity barrier
// Tap barrier, or press Esc key, to close callout
// Callout 'points' to its Target widget (button)
// Pointer is animated
// Pointer type is ArrowType.THIN''',
//             textScaler: TextScaler.linear(.9),
//             style: TextStyle(color: Colors.white, fontFamily: 'monospace'),
//           ),
//         ],
//       );
// }
//
// class _DemoPage_TextFieldInAnOverlayState
//     extends State<DemoPage_TextFieldInAnOverlay> with TickerProviderStateMixin {
//   /// notifier used to trigger target and/or callout rebuilds on windows resize, or scrolling, or callout move/resize
//   final notifier = ValueNotifier<int>(0);
//
//   /// need a focus to handle Esc key
//   final focusNodeForEscapeKey = FocusNode();
//
//   /// giving the target widget a GlobalKey allows its pos and size to be measured
//   final _targetGK = GlobalKey();
//
//   @override
//   void didChangeDependencies() {
//     /// initialize the Callouts API with the root context
//     FCallouts().initWithContext(context);
//     super.didChangeDependencies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     /// detect window size changes
//     return NotificationListener<SizeChangedLayoutNotification>(
//       onNotification: (SizeChangedLayoutNotification notification) {
//         debugPrint("SizeChangedLayoutNotification - onNotification()");
//         // Callout.dismissAll();
//         notifier.value++;
//         return true;
//       },
//       child: SizeChangedLayoutNotifier(
//         child: KeyboardListener(
//           autofocus: true,
//           focusNode: focusNodeForEscapeKey, // <-- more magic
//           onKeyEvent: (KeyEvent event) {
//             if (event.logicalKey == LogicalKeyboardKey.escape) {
//               Callout.dismissAll();
//             }
//           },
//           child: Scaffold(
//             appBar: AppBar(
//               leading: BackButton(
//                 onPressed: () => Navigator.pop(context, true),
//               ),
//               title: const Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   const Text('TextField dialog'),
//                 ],
//               ),
//               actions: [
//                 // TODO - button to show page code on github
//               ],
//             ),
//             body: Builder(builder: (scaffoldChildContext) {
//               return Center(
//                 child: FilledButton(
//                   key: _targetGK,
//                   onPressed: () {
//                     // show the callout
//                     _buttonTapped(scaffoldChildContext);
//                     // show info about this demo
//                     showBottomSheet(
//                         backgroundColor: Colors.black,
//                         context: scaffoldChildContext,
//                         builder: (_) {
//                           return Padding(
//                             padding: const EdgeInsets.all(18.0),
//                             child: DemoPage_TextFieldInAnOverlay
//                                 .bottomSheetContents(scaffoldChildContext),
//                           );
//                         });
//                   },
//                   style: FilledButton.styleFrom(
//                     backgroundColor: Colors.black,
//                     padding: const EdgeInsets.all(10),
//                     textStyle: const TextStyle(color: Colors.white),
//                   ),
//                   child: const Text('tap me'),
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _buttonTapped(BuildContext scaffoldChildContext) {
//     /// showing an overlay requires:
//     ///
//     ///   1. a Target GlobalKey (set on the target widget as its key)
//     ///   2. an optional notifier object
//     ///   3. the callout content widget
//     ///   4. the callout configuration object
//     ///
//     // callout configuration object
//     final calloutConfig = CalloutConfig(
//       feature: "textfield-callout",
//       initialTargetAlignment: Alignment.topRight,
//       initialCalloutAlignment: Alignment.bottomLeft,
//       finalSeparation: 300,
//       barrier: CalloutBarrier(
//         opacity: .25,
//         onTappedF: () {
//           Callout.dismiss("textfield-callout");
//         },
//       ),
//       suppliedCalloutW: 240,
//       suppliedCalloutH: 220,
//       borderRadius: 12,
//       fillColor: DemoPage_TextFieldInAnOverlay._color,
//       animate: true,
//       toDelta: -20,
//       arrowType: ArrowType.THIN,
//       vsync: this,
//       onDismissedF: () {
//         Navigator.pop(scaffoldChildContext);
//       },
//     );
//     final calloutContent = Column(
//       mainAxisSize: MainAxisSize.max,
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         FCallouts().purpleText("Example Callout\nwith a TextEditor",
//             fontSize: 24, family: 'Merriweather'),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           width: 240,
//           height: 100,
//
//           /// only need feature when wanting to dismiss the editor callout in a callback
//           child: FC_TextField(
//             inputType: String,
//             prompt: () => 'password',
//             originalS: '',
//             onTextChangedF: (s) async {
//               if (s.toLowerCase() == "x") {
//                 Callout.dismiss("textfield-callout");
//               }
//             },
//             onEscapedF: (s) {
//               Callout.dismiss("textfield-callout");
//             },
//             dontAutoFocus: false,
//             isPassword: true,
//             passwordHelp: "Clue: Elon Musk's favourite letter",
//             onEditingCompleteF: (s) {
//               Callout.dismiss("textfield-callout");
//             },
//           ),
//         ),
//         const Text("(this callout is draggable)"),
//       ],
//     );
//     // create and show the callout in an overlay
//     Callout.showOverlay(
//       targetGkF: () => _targetGK,
//       targetChangedNotifier: notifier,
//       boxContentF: (ctx) => calloutContent,
//       calloutConfig: calloutConfig,
//     );
//   }
// }
