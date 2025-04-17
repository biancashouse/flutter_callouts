// import 'package:flutter/material.dart';
//
// class CutoutPainter extends CustomPainter {
//   final Rect cutoutRect;
//
//   CutoutPainter({required this.cutoutRect});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     // 1. Create the background paint
//     final backgroundPaint = Paint()
//       ..color = Colors.black.withValues(alpha: 0.6) // Semi-transparent black
//       ..style = PaintingStyle.fill;
//
//     // 2. Create the cutout path
//     final cutoutPath = Path()..addRect(cutoutRect);
//
//     // 3. Create the full canvas path
//     final fullCanvasPath = Path()
//       ..addRect(Offset.zero & size);
//
//     // 4. Combine the paths using difference
//     final combinedPath = Path.combine(
//       PathOperation.difference,
//       fullCanvasPath,
//       cutoutPath,
//     );
//
//     // 5. Draw the combined path
//     canvas.drawPath(combinedPath, backgroundPaint);
//     canvas.drawRect(cutoutRect, Paint()
//       ..color = Colors.transparent // Semi-transparent black
//       ..style = PaintingStyle.fill
//     );
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return oldDelegate is CutoutPainter && oldDelegate.cutoutRect != cutoutRect;
//   }
// }