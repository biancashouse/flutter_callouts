// import 'package:flutter/material.dart';
//
// // Rect? findGlobalRect(GlobalKey key) {
// //   if (key.currentContext?.mounted ?? false) {
// //     // Widget? w = key.currentWidget;
// //
// //     try {
// //       RenderObject? renderObject = key.currentContext?.findRenderObject();
// //       if (renderObject == null) {
// //         return null;
// //       }
// //       if (renderObject is RenderBox && renderObject.hasSize) {
// //         var globalOffset = renderObject.localToGlobal(Offset.zero);
// //
// //         Rect bounds = renderObject.paintBounds;
// //         bounds = bounds.translate(globalOffset.dx, globalOffset.dy);
// //         return bounds;
// //       } else {
// //         Rect bounds = renderObject.paintBounds;
// //         final translation = renderObject.getTransformTo(null).getTranslation();
// //         bounds = bounds.translate(translation.x, translation.y);
// //         return bounds;
// //       }
// //     } catch (e) {
// //       // debugPrint("findGlobalRect: ${e.toString()}");
// //       return null;
// //     }
// //   } else
// //     return null;
// // }
//
// class Measuring {
//   Measuring._();
//
//   static Rect? findGlobalRect(GlobalKey key) {
//     final RenderObject? renderObject = key.currentContext?.findRenderObject();
//
//     if (renderObject == null) {
//       return null;
//     }
//
//     if (renderObject is RenderBox) {
//       final Offset globalOffset = renderObject.localToGlobal(Offset.zero);
//
//       Rect bounds = renderObject.paintBounds;
//       bounds = bounds.translate(globalOffset.dx, globalOffset.dy);
//       return bounds;
//     } else {
//       Rect bounds = renderObject.paintBounds;
//       var translation = renderObject.getTransformTo(null).getTranslation();
//       bounds = bounds.translate(translation.x, translation.y);
//       return bounds;
//     }
//   }
//
// // static Future<Rect> measureWidgetRect({
// //   required BuildContext context,
// //   required Widget widget,
// //   required BoxConstraints boxConstraints,
// // }) {
// //   final Completer<Rect> completer = Completer<Rect>();
// //   OverlayEntry? entry;
// //   entry = OverlayEntry(builder: (BuildContext ctx) {
// //     debugPrint(Theme.of(context).platform);
// //     return Material(
// //       child: MeasureWidget(
// //         boxConstraints: boxConstraints,
// //         measureRect: (Rect? rect) {
// //           entry?.remove();
// //           completer.complete(rect);
// //         },
// //         child: widget,
// //       ),
// //     );
// //   });
// //
// //   Overlay.of(context).insert(entry);
// //   return completer.future;
// // }
// }
//
// // (Offset?, Rect?) measurePosAndRect() {
// //   GlobalKey gk = widget.key as GlobalKey;
// //
// //   Offset? globalPos;
// //   Rect? rect;
// //   try {
// //     globalPos = Useful.findGlobalPos(gk)?.translate(
// //       widget.ancestorHScrollController?.offset ?? 0.0,
// //       widget.ancestorVScrollController?.offset ?? 0.0,
// //     );
// //     rect = findGlobalRect(gk);
// //   } catch (e) {
// //     // ignore but then don't update pos
// //   }
// //   return (globalPos, rect);
// // }
