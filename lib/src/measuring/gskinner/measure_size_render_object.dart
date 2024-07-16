// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
//
// class MeasureSizeRenderObject extends RenderProxyBox {
//   MeasureSizeRenderObject(this.onChange);
//
//   void Function(Size size) onChange;
//
//   Size? _prevSize;
//   @override
//   void performLayout() {
//     super.performLayout();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Size? newSize = child?.size;
//       _prevSize = newSize;
//       onChange(newSize??Size.zero);
//     });
//   }
// }