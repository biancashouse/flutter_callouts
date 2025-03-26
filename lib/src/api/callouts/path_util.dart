
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

class PathUtil {
  static const int DEFAULT_THICKNESS = 10;

  // static Path? draw(CalloutConfig config, {int? pointyThickness}) {
  //   Path path = Path();
  //   config.calcEndpoints();
  //   Offset tE = config.tE?.asOffset ?? Offset.zero;
  //   if (config.arrowType == ArrowType.NONE || (config.tE == null || config.cR().contains(tE))) {
  //     /*
	// 		 * rectangle around calloutR
	// 		 */
  //     //PathUtil.roundedRect(path, callout.top!, callout.left!, callout.cR().width, callout.cR().height, callout.roundedCorners);
  //     // fca.logger.i('no pointy');
  //   } else {
  //     Rectangle calloutR = config.cR();
  //     Offset cspCentre = calloutR.center;
  //
  //     // possibly translate tE with callout args + possible scroll offsets
  //     config.tE = Coord.fromOffset(
  //       config.tE!.asOffset.translate(
  //         config.targetTranslateX ?? 0.0,
  //         config.targetTranslateY ?? 0.0,
  //         // )
  //         // .translate(
  //         //   -(callout.hScrollController?.offset ?? 0.0),
  //         //   -(callout.vScrollController?.offset ?? 0.0),
  //       ),
  //     );
  //
  //     // path.translate(-canvasOffset.left, -canvasOffset.top);
  //
  //     /*
	// 		 * line from tE centre to calloutR centre
	// 		 */
  //     Line lineCentreToCentre = Line(config.tE!, Coord.fromOffset(cspCentre));
  //
  //     /*
	// 		 * point where line intersects rectangle is the centre of the pointy's base. we draw through a
	// 		 * point either side of that.
	// 		 */
  //     Coord pointyBase = calloutR.snapToRect(Rectangle.getBubbleIntersectionPoint(lineCentreToCentre, calloutR));
  //     if (Rectangle.NO_INTERSECTION_FOUND.samePointAs(pointyBase)) return null;
  //     Coord pointyBase1 = calloutR.cleverTraverseClockwise(pointyBase, (pointyThickness ?? DEFAULT_THICKNESS));
  //     Coord pointyBase2 = calloutR.cleverTraverseAntiClockwise(pointyBase, (pointyThickness ?? DEFAULT_THICKNESS));
  //
  //     /*
	// 		 * draw clockwise, only drawing corners (if applicable) that would not intersect with the
	// 		 * pointy
	// 		 */
  //
  //     if (calloutR.onSameSide(pointyBase1, pointyBase2)) {
  //       double distanceToNextCorner = calloutR.distanceToNextCorner(pointyBase1);
  //       double distanceToPrevCorner = calloutR.distanceToPreviousCorner(pointyBase2);
  //       if (distanceToNextCorner > 0 && distanceToNextCorner < config.borderRadius) {
  //         pointyBase1 = calloutR.nextClockwiseCorner(pointyBase1);
  //         pointyBase2 = calloutR.cleverTraverseAntiClockwise(pointyBase1, (pointyThickness ?? DEFAULT_THICKNESS) * 2);
  //         partialRectWith3CornersRounded(path, pointyBase1, pointyBase2, calloutR, config);
  //       } else if (distanceToPrevCorner > 0 && distanceToPrevCorner < config.borderRadius) {
  //         pointyBase2 = calloutR.previousClockwiseCorner(pointyBase2);
  //         pointyBase1 = calloutR.cleverTraverseClockwise(pointyBase2, (pointyThickness ?? DEFAULT_THICKNESS) * 2);
  //         partialRectWith3CornersRounded(path, pointyBase1, pointyBase2, calloutR, config);
  //       } else {
  //         partialRectWithAll4CornersRounded(path, pointyBase1, pointyBase2, calloutR, config);
  //       }
  //     } else {
  //       partialRectWith3CornersRounded(path, pointyBase1, pointyBase2, calloutR, config);
  //     }
  //
  //     /*
	// 			 * finally, close shape by drawing pb2 to pointy and back to pb1
	// 			 */
  //     // fca.logger.i("path.lineTo(${callout.tE!.x}, ${callout.tE!.y})");
  //     path.lineTo(config.tE!.x, config.tE!.y);
  //     path.lineTo(pointyBase1.x, pointyBase1.y);
  //   }
  //   //path.close();
  //   return path;
  // }

  /*
	 * starting at theStartPos, draw rectangle from pb1 to pb2 clockwise
	 */
//   static void partialRectWithAll4CornersRounded(Path path, Coord pb1, Coord pb2, Rectangle theRect, config) {
//     // fca.logger.i("partialRectWith4CornersRounded");
//     Coord pos = Coord.clone(pb1);
//     path.moveTo(pos.x, pos.y);
//     // path.addOval(Rect.fromCenter(center: pos.asOffset, width: 4, height: 4)); //TODO TBD
//     Side? startingSide = theRect.whichSide(pos);
//     if (startingSide == null) {
//       fca.logger.i('startSide NULL!');
//       return;
//     }
//     Side side = startingSide;
//     bool allSidesTraversed = false;
//     while (!allSidesTraversed) {
//       pos = PathUtil.lineToStartOfNextCorner(path, pos, theRect, config.borderRadius, side: side);
//       if (config.borderRadius > 0) pos = PathUtil.turnCornerClockwise(path, pos, theRect, config.borderRadius, side: side);
//       side = nextSide(side);
//       allSidesTraversed = side == startingSide;
//     }
//
//     path.lineTo(pb2.x, pb2.y);
// // path.stroke();
//   }

//   static void partialRectWith3CornersRounded(Path path, Coord pb1, Coord pb2, Rectangle theRect, config) {
//     // fca.logger.i("partialRectWith3CornersRounded");
//     Coord pos = Coord.clone(pb1);
//     path.moveTo(pos.x, pos.y);
//     Side? startingSide = theRect.whichSide(pos);
//     if (startingSide == null) {
//       fca.logger.i('startSide NULL!');
//       return;
//     }
//     Side side = startingSide;
//     bool threeSidesTraversed = false;
//     while (!threeSidesTraversed) {
//       pos = PathUtil.lineToStartOfNextCorner(path, pos, theRect, config.borderRadius, side: side);
//       if (config.borderRadius > 0) pos = PathUtil.turnCornerClockwise(path, pos, theRect, config.borderRadius, side: side);
//       side = nextSide(side);
//       threeSidesTraversed = side == previousSide(startingSide);
//     }
//     path.lineTo(pb2.x, pb2.y);
// // path.stroke();
//   }

  static void roundedRect(Path path, double x, double y, double width, double height, double radius) {
    // arcs:  https://medium.com/flutter-community/flutter-custom-clipper-28c6d380fdd6
    path
      ..moveTo(x + radius, y)
      ..lineTo(x + width - radius, y)
      ..quadraticBezierTo(x + width, y, x + width, y + radius)
      ..lineTo(x + width, y + height - radius)
      ..quadraticBezierTo(x + width, y + height, x + width - radius, y + height)
      ..lineTo(x + radius, y + height)
      ..quadraticBezierTo(x, y + height, x, y + height - radius)
      ..lineTo(x, y + radius)
      ..quadraticBezierTo(x, y, x + radius, y);
  }

  static void roundedRectCentred(Path path, double x, double y, double width, double height, double radius) {
    roundedRect(path, x - width / 2, y - height / 2, width, height, radius);
  }

// draw arc clockwise from (x,y) 90 degrees
  static Coord trCorner(Path path, double x, double y, double r) {
    path
      ..moveTo(x, y)
      ..quadraticBezierTo(x + r, y, x = x + r, y = y + r)
      ..moveTo(x, y);
    return Coord(x: x, y: y);
  }

  static Coord tlCorner(Path path, double x, double y, double r) {
    path
      ..moveTo(x, y)
      ..quadraticBezierTo(x, y - r, x = x + r, y = y - r)
      ..moveTo(x, y);
    return Coord(x: x, y: y);
  }

  static Coord blCorner(Path path, double x, double y, double r) {
    path
      ..moveTo(x, y)
      ..quadraticBezierTo(x - r, y, x = x - r, y = y - r)
      ..moveTo(x, y);
    return Coord(x: x, y: y);
  }

  static Coord brCorner(Path path, double x, double y, double r) {
    path
      ..moveTo(x, y)
      ..quadraticBezierTo(x, y + r, x = x - r, y = y + r)
      ..moveTo(x, y);
    return Coord(x: x, y: y);
  }

  static void pathTriangle(Path path, double x1, double y1, double x2, double y2, double x3, double y3) {
    path
      ..lineTo(x1, y1)
      ..lineTo(x2, y2)
      ..lineTo(x3, y3);
  }

// static void filledArc30To45AntiClockwise(Path path,double theX, double theY, double theRadius) {
//   var arcCenter = Offset(theX, theY);
//   final arcRect = Rect.fromCircle(center: arcCenter, radius: theRadius);
//   final startAngle = degreesToRadians(pi / 2);
//   final sweepAngle = degreesToRadians(pi);
//   path.drawArc(arcRect, startAngle, sweepAngle, true, bgPaint(Colors.yellow));
// }

// static void filledArc0To15AntiClockwise(Path path, double theX, double theY, double theRadius) {
//   path.moveTo(theX, theY);
//   path.lineTo(theX, theY + theRadius);
//   path.arc(theX, theY, theRadius, 1.5 * pi, 1, ANTI_CLOCKWISE);
//   path.lineTo(theX, theY);
// }
//
// static void pathFilledArc30To15Clockwise(Path path,double theX, double theY, double theRadius) {
//   filledArc30To15Clockwise(path,theX, theY, theRadius);
// }
//
// static void filledArc30To15Clockwise(Path path,double theX, double theY, double theRadius) {
//   path.moveTo(theX, theY);
//   path.lineTo(theX, theY + theRadius);
//   path.arc(theX, theY, theRadius, .5 * pi, 0, CLOCKWISE);
//   path.lineTo(theX, theY);
// }
//
// static void pathQuarterCircle0To15(Path path,double theX, double theY, double theRadius) {
//   quarterCircle0To15(path,theX, theY, theRadius);
// }
//
// static void pathQuarterCircle15To30(Path path,double theX, double theY, double theRadius) {
//   quarterCircle15To30(path,theX, theY, theRadius);
// }
//
// static void pathQuarterCircle30To45(Path path,double theX, double theY, double theRadius) {
//   quarterCircle30To45(path,theX, theY, theRadius);
// }
//
// static void pathQuarterCircle45To0(Path path,double theX, double theY, double theRadius) {
//   quarterCircle45To0(path,theX, theY, theRadius);
// }
//
// static void quarterCircle0To15(Path path,double theX, double theY, double theRadius) {
//   path.arc(theX, theY, theRadius, 1.5 * pi, 0 * pi, CLOCKWISE);
// }
//
// static void quarterCircle15To30(Path path,double theX, double theY, double theRadius) {
//   path.arc(theX, theY, theRadius, 0 * pi, .5 * pi, CLOCKWISE);
// }
//
// static void quarterCircle30To45(Path path,double theX, double theY, double theRadius) {
//   path.arc(theX, theY, theRadius, .5 * pi, 1 * pi, CLOCKWISE);
// }
//
// static void quarterCircle45To0(Path path,double theX, double theY, double theRadius) {
//   path.arc(theX, theY, theRadius, 1 * pi, 1.5 * pi, CLOCKWISE);
// }
//
// static void pathFilledCircle(Path path,double theX, double theY, double theRadius) {
//   filledCircle(path, theX, theY, theRadius);
// }
//
// static void filledCircle(Path path,double theX, double theY, double theRadius) {
//   path.moveTo(theX, theY);
//   path.lineTo(theX, theY + theRadius);
//   path.arc(theX, theY, theRadius, 2 * pi, 0, ANTI_CLOCKWISE);
//   path.lineTo(theX, theY);
// }
//
// static void filledArc(Path path,double theX, double theY, double theRadius, double theStartAngle, double theEndAngle, bool isClockwise) {
//   path.moveTo(theX, theY);
//   path.lineTo(theX, theY + theRadius);
//   path.arc(theX, theY, theRadius, theStartAngle, theEndAngle, isClockwise);
//   path.lineTo(theX, theY);
// }
//
// static double degreesToRadians(double degrees) {
//   return degrees * (pi / 180);
// }
//
// static double radiansToDegrees(double radians) {
//   return radians * (180 / pi);
// }

/*
	 * moving clockwise, draw the next corner from the line containing thePos. returns pos; i.e.
	 * the endpoint round the corner.
	 */
  static Coord turnCornerClockwise(Path path, Coord thePos, Rectangle theRect, double theRadius, {Side? side}) {
    if (side == Side.BOTTOM || (side == null && theRect.onBottom(thePos))) {
      return blCorner(path, thePos.x, thePos.y, theRadius);
    } else if (side == Side.LEFT || (side == null && theRect.onLeft(thePos))) {
      return tlCorner(path, thePos.x, thePos.y, theRadius);
    } else if (side == Side.TOP || (side == null && theRect.onTop(thePos))) {
      return trCorner(path, thePos.x, thePos.y, theRadius);
    } else {
      return brCorner(path, thePos.x, thePos.y, theRadius);
    }
  }

  static Coord lineToStartOfNextCorner(Path path, Coord thePos, Rectangle theRect, double theRadius, {Side? side}) {
    Coord result = Coord.clone(thePos);
    switch (side ?? theRect.whichSide(thePos)) {
      case Side.BOTTOM:
        path.lineTo(result.x = theRect.left + theRadius, result.y = theRect.bottom);
        break;
      case Side.LEFT:
        path.lineTo(result.x = theRect.left, result.y = theRect.top + theRadius);
        break;
      case Side.RIGHT:
        path.lineTo(result.x = theRect.right, result.y = theRect.bottom - theRadius);
        break;
      case Side.TOP:
        path.lineTo(result.x = theRect.right - theRadius + 1, result.y = theRect.top);
        break;
      default:
        fca.logger.i("drawToStartOfNextCorner - Not on a Side !");
    }
    return result;
  }

// static Coord lineToNextCorner(Path path, Coord thePos, Rectangle theRect) {
//   Coord result = Coord.clone(thePos);
//   switch (theRect.whichSide(thePos)) {
//     case Side.BOTTOM:
//       path.lineTo(result.x = theRect.left, result.y = theRect.bottom);
//       break;
//     case Side.LEFT:
//       path.lineTo(result.x = theRect.left, result.y = theRect.top);
//       break;
//     case Side.RIGHT:
//       path.lineTo(result.x = theRect.right, result.y = theRect.bottom);
//       break;
//     case Side.TOP:
//       path.lineTo(result.x = theRect.right, result.y = theRect.top);
//       break;
//     default:
//       fca.logger.i("drawToStartOfNextCorner - Not on a Side !");
//   }
//   return result;
// }

  static double sq(double theN) {
    return theN * theN;
  }
}
