import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

class PointingLine extends StatefulWidget {
  final Offset from;
  final Offset to;
  final ArrowTypeEnum arrowThickness;
  final Color arrowColor;
  final double lengthDeltaPc; // between 0 and 1.0
  final bool animate;
  final int pointingAnimationDuration;

  const PointingLine(this.from, this.to, this.arrowThickness, this.arrowColor, {this.lengthDeltaPc=0.0, this.animate = false, this.pointingAnimationDuration=300, super.key});

  @override
  State<StatefulWidget> createState() => _PointingLineState();
}

class _PointingLineState extends State<PointingLine> with TickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? controller;

  @override
  void initState() {
    if (widget.animate) {
      controller = AnimationController(duration: Duration(milliseconds: widget.pointingAnimationDuration), vsync: this);

      animation = Tween(begin: 0.95, end: 1.0).animate(controller!)
        ..addListener(() {
          setState(() {
            //fca.logger.i('value: ${animation.value}');
          });
        });

      controller!.repeat(reverse: true);
      //controller.forward();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: PointingLinePainter(
          widget.from, widget.to, widget.lengthDeltaPc, widget.arrowThickness, widget.arrowColor, animation),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class PointingLinePainter extends CustomPainter {
  final Offset from;
  final Offset to;
  final double lengthDeltaPc;
  final ArrowTypeEnum arrowThickness;
  final Color arrowColor;
  final Animation<double>? animation;

  PointingLinePainter(this.from, this.to, this.lengthDeltaPc, this.arrowThickness, this.arrowColor, this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    // Rect r = Rect.fromLTWH(0, 0, size.width, size.height);
    // canvas.drawRect(r, bgPaint(Colors.purple.withValues(alpha:.3)));

    // line must be shortened by radius before drawing starts
    Coord toBefore = Coord.fromOffset(to);
    double radius = arrowTypeToHeadRadius(arrowThickness);
    Coord toAfter = Coord.changeDistanceBetweenPoints(Coord.fromOffset(from), toBefore, -radius)!;

    // adjust line length by delta %
    toAfter = Coord(
      x: from.dx + lengthDeltaPc * (toAfter.x - from.dx),
      y: from.dy + lengthDeltaPc * (toAfter.y - from.dy),
    );

    // adjust line length by animation %
    if (animation != null) {
      toAfter = Coord(
        x: from.dx + animation!.value * (toAfter.x - from.dx),
        y: from.dy + animation!.value * (toAfter.y - from.dy),
      );
    }

    // fca.logger.i('to: (${toAfter.x}, ${toAfter.y})');

    canvas.drawLine(
      from,
      toAfter.asOffset,
      _linePaint(arrowColor, arrowTypeToLineThickness(arrowThickness)),
    );
    _drawArrowhead(canvas, toAfter, radius);
  }

  _drawArrowhead(Canvas canvas, Coord lineEnd, double radius) {
    var xCenter = lineEnd.x;
    var yCenter = lineEnd.y;

    double angle;
    double x;
    double y;

    Path path = Path();

    angle = Math.atan2(lineEnd.y - from.dy, lineEnd.x - from.dx);
    x = radius * Math.cos(angle) + xCenter;
    y = radius * Math.sin(angle) + yCenter;

    path.moveTo(x, y);

    angle += (1.0 / 3.0) * (2 * Math.pi);
    x = radius * Math.cos(angle) + xCenter;
    y = radius * Math.sin(angle) + yCenter;

    path.lineTo(x, y);

    angle += (1.0 / 3.0) * (2 * Math.pi);
    x = radius * Math.cos(angle) + xCenter;
    y = radius * Math.sin(angle) + yCenter;

    path.lineTo(x, y);

    path.close();

    canvas.drawPath(path, _linePaint(arrowColor, arrowTypeToLineThickness(arrowThickness)));
    canvas.drawPath(path, fca.bgPaint(arrowColor));
  }

  double arrowTypeToHeadRadius(ArrowTypeEnum size) {
    switch (size) {
      case ArrowTypeEnum.VERY_THIN:
      case ArrowTypeEnum.VERY_THIN_REVERSED:
        return 6;
      case ArrowTypeEnum.THIN:
      case ArrowTypeEnum.THIN_REVERSED:
        return 10;
      case ArrowTypeEnum.MEDIUM:
      case ArrowTypeEnum.MEDIUM_REVERSED:
        return 20;
      case ArrowTypeEnum.LARGE:
      case ArrowTypeEnum.LARGE_REVERSED:
        return 30;
      // case ArrowType.HUGE:
      // case ArrowType.HUGE_REVERSED:
      //   return 40;
      case ArrowTypeEnum.NONE:
        return 0;
      case ArrowTypeEnum.POINTY:
        return 0;
    }
  }

  double arrowTypeToLineThickness(ArrowTypeEnum size) {
    switch (size) {
      case ArrowTypeEnum.VERY_THIN:
      case ArrowTypeEnum.VERY_THIN_REVERSED:
        return 1;
      case ArrowTypeEnum.THIN:
      case ArrowTypeEnum.THIN_REVERSED:
        return 3;
      case ArrowTypeEnum.MEDIUM:
      case ArrowTypeEnum.MEDIUM_REVERSED:
        return 10;
      case ArrowTypeEnum.LARGE:
      case ArrowTypeEnum.LARGE_REVERSED:
        return 15;
      // case ArrowType.HUGE:
      // case ArrowType.HUGE_REVERSED:
      //   return 20;
      case ArrowTypeEnum.NONE:
      case ArrowTypeEnum.POINTY:
      return 1;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Paint _linePaint(Color theColor, double theThickness) =>
      Paint()
        ..color = theColor
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = theThickness;
}
