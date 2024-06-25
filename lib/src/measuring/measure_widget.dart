// import 'dart:async';
//
// import 'package:flutter_callouts/src/overlays/callouts/offstage_measuring_widget.dart';
// import 'package:flutter/material.dart';
//
// Future<Size> measureWidgetSize({
//   required BuildContext context,
//   required Widget widget,
// }) async {
//   Completer<Size> completer = Completer();
//   OverlayEntry? entry;
//   entry = OverlayEntry(builder: (BuildContext ctx) {
//     return OffstageMeasuringWidget(
//       onSized: (size) {
//         entry?.remove();
//         completer.complete(size);
//       },
//       child: widget,
//     );
//   });
//   Overlay.of(context).insert(entry);
//   return completer.future;
// }
