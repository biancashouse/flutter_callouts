// import 'dart:async';
//
// import 'package:flutter/widgets.dart';
//
// import 'measure_size_render_object.dart';
//
// class MeasurableWidgetWrapper extends SingleChildRenderObjectWidget {
//   final void Function(Size size) onChange;
//
//   const MeasurableWidgetWrapper({
//     super.key,
//     required this.onChange,
//     required Widget child,
//   });
//
//   @override
//   RenderObject createRenderObject(BuildContext context) =>
//       MeasureSizeRenderObject(onChange);
// }
//
// class MeasurableWidget extends StatefulWidget {
//   final Widget child;
//   final void Function(Size size) onSized;
//
//   const MeasurableWidget(
//       {super.key, required this.child, required this.onSized});
//
//   @override
//   _MeasurableWidgetState createState() => _MeasurableWidgetState();
// }
//
// class _MeasurableWidgetState extends State<MeasurableWidget> {
//   bool _hasMeasured = false;
//
//   @override
//   Widget build(BuildContext context) {
//     fca.logger.i('MeasurableWidget.build()');
//     Size? size = (context.findRenderObject() as RenderBox?)?.size;
//     if (size != Size.zero) {
//       if (size != null) {
//         widget.onSized.call(size);
//       }
//     } else if (!_hasMeasured) {
//       // Need to build twice in order to get size
//       scheduleMicrotask(() => setState(() => _hasMeasured = true));
//     }
//     return widget.child;
//   }
// }
