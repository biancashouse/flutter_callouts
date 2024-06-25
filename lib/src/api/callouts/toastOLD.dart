// import 'package:flutter/material.dart';
// import 'package:flutter_callouts/flutter_callouts.dart';
// import 'package:flutter_callouts/src/overlays/callouts/callout_o.dart';
// import 'package:flutter_callouts/src/callout_useful.dart';
//
// class ToastCallout extends Callout {
//   ToastCallout({
//     // super.context,
//     required super.feature,
//     required Alignment gravity,
//     required ContentFunc contents,
//     super.widthF,
//     super.heightF,
//     super.color,
//     super.gotitAxis,
//     super.onGotitPressedF,
//     super.onlyOnce,
//     super.elevation = 3,
//     super.showcpi = false,
//     super.showCloseButton,
//     super.closeButtonColor,
//   }) : super(
//           contents: contents,
//           modal: false,
//           noBorder: true,
//           animate: true,
//           roundedCorners: 10,
//           alwaysReCalcSize: true,
//           arrowType: ArrowType.NO_CONNECTOR,
//           draggable: false,
//         ) {
//     super.initialCalloutPos = _initialOffsetFromGravity(gravity, widthF?.call() ?? Useful.scrW, heightF?.call() ?? 60);
//   }
//
//   Offset _initialOffsetFromGravity(Alignment alignment, double w, double h) {
//     late Offset initialOffset;
//     if (alignment == Alignment.topCenter) {
//       initialOffset = Offset((Useful.scrW - w) / 2, 0);
//     } else if (alignment == Alignment.topRight) {
//       initialOffset = Offset(Useful.scrW - w - 10, 10);
//     } else if (alignment == Alignment.bottomCenter) {
//       initialOffset = Offset((Useful.scrW - w) / 2, Useful.scrH - h);
//     } else if (alignment == Alignment.bottomRight) {
//       initialOffset = Offset(Useful.scrW - w - 10, Useful.scrH - h - 10);
//     } else if (alignment == Alignment.center) {
//       initialOffset = Offset(Useful.scrW / 2 - w / 2 - 10, Useful.scrH / 2 - h / 2 - 10);
//     } else {
//       initialOffset = Offset(Useful.scrW - -10, Useful.scrH / 2 - h / 2 - 10);
//     }
//     // debugPrint('initialOffset (${initialOffset.dx}, ${initialOffset.dy}), and Useful.screenW is ${Useful.scrW} and screenH is ${Useful.scrH}');
//     return initialOffset;
//   }
//
// // void showText(String msgText,
// //     {Color backgroundColor = Colors.black,
// //     Color textColor = Colors.white,
// //     double textScaleFactor = 1,
// //     Alignment gravity = Alignment.topCenter,
// //     double elevation = 3,
// //     required int secs,
// //     Function? onDismissF,
// //     Axis? gotitAxis,
// //     Function? onGotitPressedF,
// //     bool? onlyOnce,
// //     bool showCPI = false,
// //     bool notUsingHydratedStorage = false}) {
// //   var sw = Useful.screenW();
// //   double w = (width ?? sw);
// //   if (width != null && height == null) height = 60;
// //   showWidget(
// //     feature,
// //     contents: () => ConstrainedBox(
// //       constraints: BoxConstraints(maxWidth: w),
// //       child: Center(
// //         child: ConstrainedBox(
// //           constraints: BoxConstraints(minHeight: 32, minWidth: Useful.screenW() * .8),
// //           child: Container(
// //             //width: w,
// //             // decoration: BoxDecoration(
// //             //   color: background,
// //             //   borderRadius: BorderRadius.circular(backgroundRadius),
// //             // ),
// //             margin: const EdgeInsets.symmetric(horizontal: 20),
// //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //             child: Center(
// //               child: Text(
// //                 msgText,
// //                 softWrap: true,
// //                 textScaler: TextScaler.linear(textScaleFactor),
// //                 style: TextStyle(fontSize: 24, color: textColor),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     ),
// //     width: width,
// //     height: height,
// //     secs: secs,
// //     gravity: gravity,
// //     backgroundColor: backgroundColor,
// //     onDismissF: onDismissF,
// //     gotitAxis: gotitAxis,
// //     elevation: elevation,
// //     onGotitPressedF: onGotitPressedF,
// //     onlyOnce: onlyOnce,
// //     showCPI: showCPI,
// //     notUsingHydratedStorage: notUsingHydratedStorage,
// //   );
// // }
//
// // void showWidget(int feature,
// //     {required ContentFunc contents,
// //     double? width,
// //     double? height,
// //     required int secs,
// //     Alignment gravity = Alignment.bottomCenter,
// //     required Color backgroundColor,
// //     double elevation = 3,
// //     Function? onDismissF,
// //     Axis? gotitAxis,
// //     Function? onGotitPressedF,
// //     bool? onlyOnce,
// //     bool showCPI = false,
// //     bool notUsingHydratedStorage = false}) {
// //   ToastCallout toast = ToastCallout(
// //     feature: feature,
// //     contents: contents,
// //     width: width,
// //     height: height,
// //     elevation: elevation,
// //     gravity: gravity,
// //     color: backgroundColor,
// //     gotitAxis: gotitAxis,
// //     onGotitPressedF: onGotitPressedF,
// //     onlyOnce: onlyOnce,
// //     showcpi: showCPI,
// //     notUsingHydratedStorage: notUsingHydratedStorage,
// //   );
// //   show(
// //     removeAfterMs: secs * 1000,
// //     notUsingHydratedStorage: notUsingHydratedStorage,
// //   );
// // }
// }
//
// class TextToast extends ToastCallout {
//   TextToast({
//     // super.context,
//     required super.feature,
//     required String msgText,
//     Color backgroundColor = Colors.black,
//     Color textColor = Colors.white,
//     double textScaleFactor = 1,
//     super.widthF,
//     super.heightF,
//     super.gravity = Alignment.topCenter,
//     super.gotitAxis,
//     super.onGotitPressedF,
//     super.onlyOnce,
//     super.elevation,
//     super.showcpi,
//   }) : super(
//             color: backgroundColor,
//             contents: () => ConstrainedBox(
//                   constraints: BoxConstraints(maxWidth: widthF?.call() ?? Useful.scrW),
//                   child: Center(
//                     child: ConstrainedBox(
//                       constraints: BoxConstraints(minHeight: 32, minWidth: Useful.scrW * .8),
//                       child: Container(
//                         //width: w,
//                         // decoration: BoxDecoration(
//                         //   color: background,
//                         //   borderRadius: BorderRadius.circular(backgroundRadius),
//                         // ),
//                         margin: const EdgeInsets.symmetric(horizontal: 20),
//                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                         child: Center(
//                           child: Text(
//                             msgText,
//                             softWrap: true,
//                             textScaler: TextScaler.linear(textScaleFactor),
//                             style: TextStyle(fontSize: 24, color: textColor),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )) {
//     if (width != null && height == null) height = 60;
//   }
// }
//
// class WidgetToast extends ToastCallout {
//   WidgetToast({
//     // super.context,
//     required super.feature,
//     required super.contents,
//     super.widthF,
//     super.heightF,
//     super.gravity = Alignment.bottomCenter,
//     required Color backgroundColor,
//     super.elevation,
//     super.gotitAxis,
//     super.onGotitPressedF,
//     super.onlyOnce,
//     super.showcpi,
//     super.showCloseButton,
//     super.closeButtonColor,
//   }) : super(
//           color: backgroundColor,
//         );
// }
//
// void explainPopupsAreDraggable() =>    TextToast(
//     feature: 'explainPopupsAreDraggable',
//     msgText: "NOTE - popups can be moved around the screen",
//     backgroundColor: Colors.purpleAccent,
//     textColor: Colors.yellowAccent,
//     gravity: Alignment.bottomCenter,
//     width: Useful.scrW*2 / 3,
//     heightF: ()=>60,
//     gotitAxis: Axis.horizontal)
//     .show(removeAfterMs: SECS(5));
