// ignore: library_prefixes
import 'dart:math' as Math;

import 'package:flutter/widgets.dart';

const EPSILON = .5;
const EPSILON2 = 1.1;

class Coord {
  double x, y;

  Offset get asOffset => Offset(x, y);

  Coord({this.x = 0, this.y = 0});

  factory Coord.clone(Coord theCoord) {
    return Coord(x: theCoord.x, y: theCoord.y);
  }

  factory Coord.fromOffset(Offset theOffset) {
    return Coord(x: theOffset.dx, y: theOffset.dy);
  }

  static bool sameValue(double a, double b) {
    return (a - b).abs() < EPSILON;
  }

  static bool sameValue2(double a, double b) {
    return (a - b).abs() < EPSILON2;
  }

  bool samePointAs(Coord? theOtherPoint) {
    return theOtherPoint != null
        ? ((x - theOtherPoint.x).abs() < EPSILON && (y - theOtherPoint.y).abs() < EPSILON)
        : false;
  }

  /*
		 * pythagorus
		 */
  double delta(Coord otherPos) {
    return Math.sqrt((x - otherPos.x) * (x - otherPos.x) + (y - otherPos.y) * (y - otherPos.y));
  }

  /*
		 * return the x distance between 2 points - useful when needing to know which of 2 points is closest to
		 * another point; e.g. the centre of the rect
		 */
  double deltaX(Coord otherPos) {
    return (x - otherPos.x).abs();
  }

  double deltaY(Coord otherPos) {
    return (y - otherPos.y).abs();
  }

  // moves the from pos s.t. line has new length
  static Coord? changeDistanceBetweenPoints(Coord? toCentre, Coord? from, double? lineLenDelta) {
    if (toCentre == null || toCentre.samePointAs(from)) return from;

    var lineLen = Math.sqrt(Math.pow(toCentre.x - from!.x, 2.0) + Math.pow(toCentre.y - from.y, 2.0));
    //debugPrint('line length before = $lineLen');
    // extend line by delta
    from = Coord(
        x: from.x + (from.x - toCentre.x) / lineLen * lineLenDelta!,
        y: from.y + (from.y - toCentre.y) / lineLen * lineLenDelta);
    //debugPrint('new endpoint is ${from.asOffset}');
    lineLen = Math.sqrt(Math.pow(toCentre.x - from.x, 2.0) + Math.pow(toCentre.y - from.y, 2.0));
    //debugPrint('line length after = $lineLen');
    return from;
  }
}
