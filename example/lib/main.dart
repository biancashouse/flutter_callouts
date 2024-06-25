import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

import 'demos_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Callouts Package Demos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: FCallouts().FUCHSIA_X),
        useMaterial3: true,
      ),
      home: const CalloutDemosHome(),
    );
  }
}

// class DemoHomePage extends StatelessWidget {
//   const DemoHomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             const Text('Flutter Callouts - Examples Home Page'),
//             Text(
//               'subTitlesubTitlesubTitlesubTitlesubTitle',
//               textScaler: TextScaler.linear(.7),
//             ),
//           ],
//         ),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(50.0),
//           child: Wrap(
//             children: [
//               FilledButton(
//                 key: _gk1,
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const CalloutDemoPage1()),
//                   );
//                 }, // _button1,
//                 style: FilledButton.styleFrom(backgroundColor: Colors.red),
//                 child: const Padding(
//                   padding: EdgeInsets.all(8),
//                   child: Text(
//                     'tap me',
//                     style: TextStyle(color: Colors.yellow),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _button1() {
//     Callout.showOverlay(
//       targetGkF: () => _gk1,
//       targetChangedNotifier: notifier,
//       boxContentF: (ctx) => Column(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           FCallouts().purpleText("Example Callout\nwith a TextEditor",
//               fontSize: 24, family: 'Merriweather'),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             width: 240,
//             height: 100,
//
//             /// only need feature when wanting to dismiss the editor callout in a callback
//             child: FC_TextField(
//               inputType: String,
//               prompt: () => 'password',
//               originalS: '',
//               onTextChangedF: (s) async {
//                 if (s.toLowerCase() == "x") {
//                   Callout.dismiss("top-left");
//                 }
//               },
//               onEscapedF: (s) {
//                 Callout.dismiss("top-left");
//               },
//               dontAutoFocus: false,
//               isPassword: true,
//               passwordHelp: "Clue: Elon Musk's favourite letter",
//               onEditingCompleteF: (s) {
//                 Callout.dismiss("top-left");
//               },
//             ),
//           ),
//           Text("(this callout is draggable)"),
//         ],
//       ),
//       calloutConfig: CalloutConfig(
//           feature: "top-left",
//           initialTargetAlignment: Alignment.bottomRight,
//           initialCalloutAlignment: Alignment.topLeft,
//           finalSeparation: 300,
//           barrier: CalloutBarrier(
//             opacity: .5,
//             onTappedF: () {
//               Callout.dismiss("top-left");
//             },
//           ),
//           suppliedCalloutW: 240,
//           suppliedCalloutH: 220,
//           borderRadius: 12,
//           fillColor: Colors.lime,
//           animate: true,
//           toDelta: -20,
//           arrowType: ArrowType.POINTY,
//           vsync: this),
//     );
//   }
//
//   Future<void> _button2() async {
//     CalloutConfig cc = CalloutConfig(
//       feature: "top-right",
//       initialTargetAlignment: Alignment.bottomLeft,
//       initialCalloutAlignment: Alignment.topRight,
//       finalSeparation: 150,
//       barrier: CalloutBarrier(
//         opacity: .5,
//         onTappedF: () {
//           Callout.dismiss("top-right");
//         },
//       ),
//       suppliedCalloutW: 280,
//       suppliedCalloutH: 200,
//       borderRadius: 12,
//       fillColor: Colors.blue[50],
//       arrowColor: Colors.green,
//       arrowType: ArrowType.POINTY,
//       animate: true,
//       toDelta: -20,
//       resizeableH: true,
//       resizeableV: true,
//       vsync: this,
//     );
//     Callout.showOverlay(
//       targetGkF: () => _gk2,
//       targetChangedNotifier: notifier,
//       boxContentF: (ctx) => Column(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           FCallouts()
//               .purpleText(
//                 "Animated.",
//                 fontSize: 24,
//                 family: 'Merriweather',
//               )
//               .animate()
//             ..swap(
//                 duration: 3400.ms,
//                 builder: (_, __) => FCallouts().purpleText(
//                       "Animated,\nand Resizeable",
//                       fontSize: 24,
//                       family: 'Merriweather',
//                     ))
//             ..swap(
//                 duration: 5.seconds,
//                 builder: (_, __) => FCallouts().purpleText(
//                       "Animated,\nand Resizeable,\nand Draggable",
//                       fontSize: 24,
//                       family: 'Merriweather',
//                     ))
//             ..swap(
//                 duration: 7.seconds,
//                 builder: (_, __) => FCallouts().purpleText(
//                       "Animated,\nand Resizeable,\nand Draggable,\ntry it...",
//                       fontSize: 24,
//                       family: 'Merriweather',
//                     )),
//         ],
//       ),
//       calloutConfig: cc,
//     );
//     Future.delayed(
//         1.seconds,
//         () => cc.animateCornerBy(Alignment.topLeft, -50, -50,
//             durationMs: 1.seconds));
//     Future.delayed(
//         3.seconds,
//         () => cc.animateCornerBy(Alignment.topRight, 50, 0,
//             durationMs: 1.seconds));
//     Future.delayed(
//         5.seconds,
//         () => cc.animateCornerBy(Alignment.bottomLeft, -50, 50,
//             durationMs: 1.seconds));
//     Future.delayed(
//         7.seconds,
//         () => cc.animateCornerBy(Alignment.bottomRight, 0, 100,
//             durationMs: 1.seconds));
//     // await Future.delayed(
//     //     1.seconds,
//     //     () => cc.animateCalloutBy(0, 100,
//     //         durationMs: 500.ms,
//     //         afterAnimationF: () => cc.animateCalloutBy(100, 0,
//     //             durationMs: 500.ms,
//     //             afterAnimationF: () => cc.animateCalloutBy(-200, 200,
//     //                 durationMs: 900.ms,
//     //                 afterAnimationF: () => cc.animateCalloutBy(200, -200,
//     //                     durationMs: 500.ms, afterAnimationF: () => {
//     //                   cc.animateCornerBy(Alignment.topLeft, -50, -50, durationMs: 500.ms)
//     //                     })))));
//   }
//
//   /// wrappedTarget does NOT need a GlobalKey
//   Widget _button3() => Callout.wrapTarget(
//         targetChangedNotifier: notifier,
//         calloutBoxContentBuilderF: (context) => Column(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             FCallouts().purpleText(
//               "Animated,\nResizeable,\nDraggable,\nExample Callout",
//               fontSize: 24,
//               family: 'Merriweather',
//             ),
//           ],
//         ),
//         calloutConfig: CalloutConfig(
//           feature: "bottom-left",
//           initialTargetAlignment: Alignment.bottomLeft,
//           initialCalloutAlignment: Alignment.topRight,
//           finalSeparation: 150,
//           barrier: CalloutBarrier(
//             opacity: .5,
//             onTappedF: () {
//               Callout.hideParentCallout(context);
//             },
//           ),
//           suppliedCalloutW: 280,
//           suppliedCalloutH: 200,
//           borderRadius: 12,
//           fillColor: Colors.blue[50],
//           animate: true,
//           toDelta: -20,
//           resizeableH: true,
//           resizeableV: true,
//         ),
//         targetBuilderF: (ctx) => FilledButton(
//           // key: _blGk,
//           onPressed: () {
//             Callout.unhideParentCallout(ctx, animateSeparation: false);
//           },
//           style: FilledButton.styleFrom(backgroundColor: Colors.greenAccent),
//           child: const Padding(
//             padding: EdgeInsets.all(8),
//             child: Text(
//               'tap to see example callout',
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//         ),
//       );
//
//   void _button4() {
//     Callout.showOverlay(
//       targetGkF: () => _gk4,
//       targetChangedNotifier: notifier,
//       boxContentF: (ctx) => Column(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           FCallouts().purpleText("Example Callout\nwith a TextEditor",
//               fontSize: 24, family: 'Merriweather'),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             width: 240,
//             height: 100,
//             child: FC_TextField(
//               inputType: String,
//               prompt: () => 'password',
//               originalS: '',
//               onTextChangedF: (s) async {
//                 if (s.toLowerCase() == "x") {
//                   Callout.dismiss("top-left");
//                 }
//               },
//               dontAutoFocus: false,
//               isPassword: true,
//               passwordHelp: "Clue: Elon Musk's favourite letter",
//               onEditingCompleteF: (s) {},
//             ),
//           ),
//           Text("(this callout is draggable)"),
//         ],
//       ),
//       calloutConfig: CalloutConfig(
//         feature: "bottom-right",
//         initialTargetAlignment: Alignment.bottomRight,
//         initialCalloutAlignment: Alignment.topLeft,
//         finalSeparation: 150,
//         barrier: CalloutBarrier(
//           opacity: .5,
//           onTappedF: () {
//             Callout.dismiss("bottom-right");
//           },
//         ),
//         suppliedCalloutW: 240,
//         suppliedCalloutH: 220,
//         borderRadius: 12,
//         fillColor: Colors.lime,
//         animate: true,
//         toDelta: -20,
//       ),
//     );
//   }
// }
