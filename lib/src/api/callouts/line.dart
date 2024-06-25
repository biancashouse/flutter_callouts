import 'dart:math' as math;
import 'dart:ui';

import 'coord.dart';

const double LINE_MOE = .5;

class Line {
  late Coord a, b;

  Line(Coord c1, Coord c2) {
    a = Coord.clone(c1);
    b = Coord.clone(c2);
  }

  Line.fromPoints(double ax, double ay, double bx, double by) {
    a = Coord(x: ax, y: ay);
    b = Coord(x: bx, y: by);
  }

  Line.fromOffsets(Offset o1, Offset o2) {
    a = Coord.fromOffset(o1);
    b = Coord.fromOffset(o2);
  }

  Line.fromPointAndCoord(double ax, double ay, Coord b) {
    a = Coord(x: ax, y: ay);
    b = Coord.clone(b);
  }

  bool includesPoint(Coord thePoint) {
    late Coord leftPt, rightPt;

    // Normalize start/end to left right to make the offset calc simpler.
    if (a.x <= b.x) {
      leftPt = a;
      rightPt = b;
    } else {
      leftPt = b;
      rightPt = a;
    }

    // If point is out of bounds, no need to do further checks.
    if (definitelyLT(thePoint.x, leftPt.x) || definitelyLT(rightPt.x, thePoint.x)) {
      return false;
    } else {
      // Normalize in vertical axis
      if (a.y <= b.y) {
        leftPt = a;
        rightPt = b;
      } else {
        leftPt = b;
        rightPt = a;
      }
      if (definitelyLT(thePoint.y, leftPt.y) || definitelyLT(rightPt.y, thePoint.y)) return false;
    }

    //    double ratio1 = (thePoint.y - a.y) / (b.y - a.y);
    //    double ratio2 = (thePoint.x - a.x) / (b.x - a.x);
    //
    //    return ratio1 == ratio2;
    return true;
  }

  // find the distance between the points
  double length() => math.sqrt(math.pow(b.x - a.x, 2) + math.pow(b.y - a.y, 2));

  Coord? getIntersectionPoint(Line theOtherLine) {
    double x1 = a.x;
    double y1 = a.y;
    double x2 = b.x;
    double y2 = b.y;

    double x3 = theOtherLine.a.x;
    double y3 = theOtherLine.a.y;
    double x4 = theOtherLine.b.x;
    double y4 = theOtherLine.b.y;

    Coord? p;

    double d = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
    if (d != 0) {
      double xi = ((x3 - x4) * (x1 * y2 - y1 * x2) - (x1 - x2) * (x3 * y4 - y3 * x4)) / d;
      double yi = ((y3 - y4) * (x1 * y2 - y1 * x2) - (y1 - y2) * (x3 * y4 - y3 * x4)) / d;

      p = Coord(x: xi, y: yi);
    }
    return p;
  }

  // https://stackoverflow.com/questions/23369705/html5-canvas-draw-a-line-and-make-it-shorter
  Line adjustLength(double delta1, double delta2) {
    Coord vec = Coord(), sp1 = Coord(), sp2 = Coord();
    vec.x = b.x - a.x;
    vec.y = b.y - a.y;
    var hyp = math.sqrt(vec.x * vec.x + vec.y * vec.y);
    vec.x /= hyp;
    vec.y /= hyp;

    sp1.x = a.x + vec.x * delta1;
    sp1.y = a.y + vec.y * delta1;

    sp2.x = b.x + vec.x * delta2;
    sp2.y = b.y + vec.y * delta2;

    return Line(sp1, sp2);
  }

  Coord adjustedEndpoint({required double pc}) => Coord(
        x: b.x + (pc / length()) * (a.x - b.x),
        y: b.y + (pc / length()) * (a.y - b.y),
      );

  Coord midPoint() => Coord(
        x: (a.x + b.x) / 2,
        y: (a.y + b.y) / 2,
      );
  Coord labelPos() {
    Coord m = midPoint();
    if (b.x > a.x && b.y > a.y) {
      return Coord(x: m.x, y: m.y - 30);
    } else {
      return Coord(x: m.x, y: m.y + 10);
    }
  }

  bool definitelyLT(double a, double b) {
    return a < (b - LINE_MOE);
  }

  bool definitelyGT(double a, double b) {
    return a > (b + LINE_MOE);
  }
}
