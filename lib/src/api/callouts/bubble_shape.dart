import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';
import 'package:flutter_callouts/src/api/callouts/path_util.dart';

// ignore: camel_case_types
class BubbleShape_OP extends CustomPainter {
  final CalloutConfig calloutConfig;

  BubbleShape_OP({required this.calloutConfig});

  @override
  void paint(Canvas canvas, Size size) {
    Path? pointerPath = _drawBubblePointer(calloutConfig);
    if (pointerPath != null) {
      Paint fillPaint = fca.bgPaint(
        calloutConfig.targetPointerColor ??
        calloutConfig.decorationUpTo6FillColors?.onlyColor ?? Colors.red,
      );
      canvas.drawPath(pointerPath, fillPaint);
      // in order to completely fill in the rounded rectangle
      if (false&&(calloutConfig.decorationBorderRadius ?? 0.0) > 0.0) {
        Rectangle calloutR = Rectangle.fromRect(calloutConfig.cR());
        Path rrPath = Path();
        PathUtil.roundedRect(
          rrPath,
          calloutR.left,
          calloutR.top,
          calloutR.width,
          calloutR.height,
          calloutConfig.decorationBorderRadius ?? 0.0,
        );
        canvas.drawPath(rrPath, fillPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  // for rounded corners, misses inside, so need to also fill using _drawBubble2()
  Path? _drawBubblePointer(CalloutConfig callout) {
    // print('drawBubble');
    Path path = Path();
    callout.calcEndpoints();
    // by deflating the rect of the callout, avoid gaps in the bubble from calc error
    Rectangle calloutR = Rectangle.fromRect(callout.cR().deflate(20));
    if (callout.tE == null || callout.cE == null) return null;
    Offset tE = callout.tE!.asOffset;
    // tE = tE.translate(callout.scrollOffsetX(), callout.scrollOffsetY());
    // print('drawBubble tE is ${tE} scrollOffset is (${callout.scrollOffsetX()},${callout.scrollOffsetY()})');

    if (callout.targetPointerType == TargetPointerTypeEnum.NONE ||
        calloutR.contains(tE)) {
      /*
			 * rectangle around calloutR
			 */
      //PathUtil.roundedRect(path, callout.top!, callout.left!, callout.cR().width, callout.cR().height, callout.roundedCorners);
      // fca.logger.i('no pointy');
    } else {
      Offset cspCentre = calloutR.center;

      // path.translate(-canvasOffset.left, -canvasOffset.top);

      /*
			 * line from tE centre to calloutR centre
			 */
      Line lineCentreToCentre = Line(callout.tE!, Coord.fromOffset(cspCentre));

      /*
			 * point where line intersects rectangle is the centre of the pointy's base. we draw through a
			 * point either side of that.
			 */
      Coord pointyBase = calloutR.snapToRect(
        Rectangle.getBubbleIntersectionPoint(lineCentreToCentre, calloutR),
      );
      if (Rectangle.NO_INTERSECTION_FOUND.samePointAs(pointyBase)) return null;

      double pointyThickness = calloutConfig.calloutH! <= 40
          ? PathUtil.DEFAULT_THICKNESS / 2
          : PathUtil.DEFAULT_THICKNESS;

      Coord pointyBase1 = calloutR.cleverTraverseClockwise(
        pointyBase,
        pointyThickness,
      );
      Coord pointyBase2 = calloutR.cleverTraverseAntiClockwise(
        pointyBase,
        pointyThickness,
      );

      /*
			 * draw clockwise, only drawing corners (if applicable) that would not intersect with the
			 * pointy
			 */

      path.moveTo(callout.tE!.x, callout.tE!.y);
      path.lineTo(pointyBase1.x, pointyBase1.y);
      path.lineTo(pointyBase2.x, pointyBase2.y);
      path.lineTo(callout.tE!.x, callout.tE!.y);
    }

    return path;
  }

  // // for rounded corners, misses inside, so need to also fill using _drawBubble2()
  // Path? _drawBubble(CalloutConfig callout, {int? pointyThickness, required bool skipArcs}) {
  //   // print('drawBubble');
  //   Path path = Path();
  //   callout.calcEndpoints();
  //   Rectangle calloutR = Rectangle.fromRect(callout.cR());
  //   if (callout.tE == null || callout.cE == null) return null;
  //   Offset tE = callout.tE!.asOffset;
  //   // tE = tE.translate(callout.scrollOffsetX(), callout.scrollOffsetY());
  //   // print('drawBubble tE is ${tE} scrollOffset is (${callout.scrollOffsetX()},${callout.scrollOffsetY()})');
  //
  //   if (callout.targetPointerType == TargetPointerTypeEnum.NONE ||
  //       calloutR.contains(tE)) {
  //     /*
  // 		 * rectangle around calloutR
  // 		 */
  //     //PathUtil.roundedRect(path, callout.top!, callout.left!, callout.cR().width, callout.cR().height, callout.roundedCorners);
  //     // fca.logger.i('no pointy');
  //   } else {
  //     Offset cspCentre = calloutR.center;
  //
  //     // path.translate(-canvasOffset.left, -canvasOffset.top);
  //
  //     /*
  // 		 * line from tE centre to calloutR centre
  // 		 */
  //     Line lineCentreToCentre = Line(callout.tE!, Coord.fromOffset(cspCentre));
  //
  //     /*
  // 		 * point where line intersects rectangle is the centre of the pointy's base. we draw through a
  // 		 * point either side of that.
  // 		 */
  //     Coord pointyBase = calloutR.snapToRect(
  //       Rectangle.getBubbleIntersectionPoint(lineCentreToCentre, calloutR),
  //     );
  //     if (Rectangle.NO_INTERSECTION_FOUND.samePointAs(pointyBase)) return null;
  //     Coord pointyBase1 = calloutR.cleverTraverseClockwise(
  //       pointyBase,
  //       (pointyThickness ?? PathUtil.DEFAULT_THICKNESS),
  //     );
  //     Coord pointyBase2 = calloutR.cleverTraverseAntiClockwise(
  //       pointyBase,
  //       (pointyThickness ?? PathUtil.DEFAULT_THICKNESS),
  //     );
  //
  //     /*
  // 		 * draw clockwise, only drawing corners (if applicable) that would not intersect with the
  // 		 * pointy
  // 		 */
  //
  //     if (calloutR.onSameSide(pointyBase1, pointyBase2)) {
  //       double distanceToNextCorner = calloutR.distanceToNextCorner(
  //         pointyBase1,
  //       );
  //       double distanceToPrevCorner = calloutR.distanceToPreviousCorner(
  //         pointyBase2,
  //       );
  //       if (distanceToNextCorner > 0 &&
  //           distanceToNextCorner < (callout.decorationBorderRadius ?? 0.0)) {
  //         pointyBase1 = calloutR.nextClockwiseCorner(pointyBase1);
  //         pointyBase2 = calloutR.cleverTraverseAntiClockwise(
  //           pointyBase1,
  //           (pointyThickness ?? PathUtil.DEFAULT_THICKNESS) * 2,
  //         );
  //         _partialRectWith3CornersRounded(
  //           path,
  //           pointyBase1,
  //           pointyBase2,
  //           calloutR,
  //           callout,
  //           skipArcs,
  //         );
  //       } else if (distanceToPrevCorner > 0 &&
  //           distanceToPrevCorner < (callout.decorationBorderRadius ?? 0.0)) {
  //         pointyBase2 = calloutR.previousClockwiseCorner(pointyBase2);
  //         pointyBase1 = calloutR.cleverTraverseClockwise(
  //           pointyBase2,
  //           (pointyThickness ?? PathUtil.DEFAULT_THICKNESS) * 2,
  //         );
  //         _partialRectWith3CornersRounded(
  //           path,
  //           pointyBase1,
  //           pointyBase2,
  //           calloutR,
  //           callout,
  //           skipArcs,
  //         );
  //       } else {
  //         _partialRectWithAll4CornersRounded(
  //           path,
  //           pointyBase1,
  //           pointyBase2,
  //           calloutR,
  //           callout,
  //           skipArcs,
  //         );
  //       }
  //     } else {
  //       _partialRectWith3CornersRounded(
  //         path,
  //         pointyBase1,
  //         pointyBase2,
  //         calloutR,
  //         callout,
  //         skipArcs,
  //       );
  //     }
  //
  //     path.lineTo(callout.tE!.x, callout.tE!.y);
  //     path.lineTo(pointyBase1.x, pointyBase1.y);
  //
  //     // in order to completely fill in the rounded rectangle
  //     if ((calloutConfig.decorationBorderRadius ?? 0.0) > 0.0) {
  //       PathUtil.roundedRect(
  //         path,
  //         calloutR.left,
  //         calloutR.top,
  //         calloutR.width,
  //         calloutR.height,
  //         callout.decorationBorderRadius ?? 0.0,
  //       );
  //     }
  //   }
  //
  //   return path;
  // }

  void _partialRectWithAll4CornersRounded(
    Path path,
    Coord pb1,
    Coord pb2,
    Rectangle theRect,
    CalloutConfig callout,
    bool skipArc,
  ) {
    // fca.logger.i("partialRectWith4CornersRounded");
    Coord pos = Coord.clone(pb1);
    path.moveTo(pos.x, pos.y);
    // path.addOval(Rect.fromCenter(center: pos.asOffset, width: 4, height: 4)); //TODO TBD
    Side? startingSide = theRect.whichSide(pos);
    if (startingSide == null) {
      fca.logger.i('startSide NULL!');
      return;
    }
    Side side = startingSide;
    bool allSidesTraversed = false;
    while (!allSidesTraversed) {
      pos = PathUtil.lineToStartOfNextCorner(
        path,
        pos,
        theRect,
        callout.decorationBorderRadius!,
        side: side,
      );
      if (callout.decorationBorderRadius! > 0)
        pos = PathUtil.turnCornerClockwise(
          path,
          pos,
          theRect,
          callout.decorationBorderRadius!,
          skipArc,
          side: side,
        );
      side = nextSide(side);
      allSidesTraversed = side == startingSide;
    }

    path.lineTo(pb2.x, pb2.y);
    // path.stroke();
  }

  void _partialRectWith3CornersRounded(
    Path path,
    Coord pb1,
    Coord pb2,
    Rectangle theRect,
    callout,
    bool skipArc,
  ) {
    // fca.logger.i("partialRectWith3CornersRounded");
    Coord pos = Coord.clone(pb1);
    path.moveTo(pos.x, pos.y);
    Side? startingSide = theRect.whichSide(pos);
    if (startingSide == null) {
      fca.logger.i('startSide NULL!');
      return;
    }
    Side side = startingSide;
    bool threeSidesTraversed = false;
    while (!threeSidesTraversed) {
      pos = PathUtil.lineToStartOfNextCorner(
        path,
        pos,
        theRect,
        callout.decorationBorderRadius,
        side: side,
      );
      if (callout.decorationBorderRadius > 0)
        pos = PathUtil.turnCornerClockwise(
          path,
          pos,
          theRect,
          callout.decorationBorderRadius,
          skipArc,
          side: side,
        );
      side = nextSide(side);
      threeSidesTraversed = side == previousSide(startingSide);
    }
    path.lineTo(pb2.x, pb2.y);
    // path.stroke();
  }
}
