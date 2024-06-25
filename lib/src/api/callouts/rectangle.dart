import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'coord.dart';
import 'line.dart';
import 'side.dart';

const double RECTANGLE_MOE = 1.1;

class Rectangle extends Rect {
  Rectangle.fromPoints(super.a, super.b) : super.fromPoints();

  Rectangle.fromRect(Rect r) : super.fromPoints(r.topLeft, r.bottomRight);

  /*
	 * allow margin of error
	 */
  Side? whichSide(Coord thePoint) {
    Side? result;
    if (Coord.sameValue(thePoint.x, left)) {
      result = Side.LEFT;
    } else if (Coord.sameValue(thePoint.x, right)) {
      result = Side.RIGHT;
    } else if (Coord.sameValue(thePoint.y, top)) {
      result = Side.TOP;
    } else if (Coord.sameValue(thePoint.y, bottom)) {
      result = Side.BOTTOM;
    } else {
      return result = null;
    }

    /*
		 * if on a corner, return the clockwise-most side
		 */
    switch (result) {
      case Side.BOTTOM:
        if (Coord.sameValue(thePoint.x, left)) result = Side.LEFT;
        break;
      case Side.LEFT:
        if (Coord.sameValue(thePoint.y, top)) result = Side.TOP;
        break;
      case Side.RIGHT:
        if (Coord.sameValue(thePoint.y, bottom)) result = Side.BOTTOM;
        break;
      case Side.TOP:
        if (Coord.sameValue(thePoint.x, right)) result = Side.RIGHT;
        break;
      default:
        break;
    }

    return result;
  }

  bool hasPointOnSide(Coord thePoint, Side theSide) {
    double l = left;
    double r = right;
    double t = top;
    double b = bottom;

    switch (theSide) {
      case Side.BOTTOM:
        return Coord.sameValue2(thePoint.y, b) && roughlyWithin(thePoint.x, l, r);
      case Side.LEFT:
        return Coord.sameValue2(thePoint.x, l) && roughlyWithin(thePoint.y, t, b);
      case Side.RIGHT:
        return Coord.sameValue2(thePoint.x, r) && roughlyWithin(thePoint.y, t, b);
      case Side.TOP:
        return Coord.sameValue2(thePoint.y, t) && roughlyWithin(thePoint.x, l, r);
      default:
        return false;
    }
  }

  bool outside(Coord thePos) {
    return definitelyLT(thePos.x, left) ||
        definitelyGT(thePos.x, right) ||
        definitelyLT(thePos.y, top) ||
        definitelyGT(thePos.y, bottom);
  }

  /// Returns <code>true</code> if the rectangle described by the arguments
  /// intersects with the receiver and <code>false</code> otherwise.
  /// <p>
  /// Two rectangles intersect if the area of the rectangle representing their
  /// intersection is not empty.
  /// </p>
  ///
  /// @param x
  ///            the x coordinate of the origin of the rectangle
  /// @param y
  ///            the y coordinate of the origin of the rectangle
  /// @param widthPx
  ///            ()Class the width of the rectangle
  /// @param height
  ///            the height of the rectangle
  /// @return <code>true</code> if the rectangle intersects with the receiver,
  ///         and <code>false</code> otherwise
  ///
  /// @exception IllegalArgumentException
  ///                <ul>
  ///                <li>ERROR_NULL_ARGUMENT - if the argument is null</li>
  ///                </ul>
  ///
  /// @see #intersection(Rectangle)
  /// @see #isEmpty()
  ///
  /// @since 3.0
  bool intersects(Rectangle theOtherRect) {
    return (theOtherRect.left < left + width) &&
        (theOtherRect.top < top + height) &&
        (theOtherRect.left + theOtherRect.width > left) &&
        (theOtherRect.top + theOtherRect.height > top);
  }

  static bool rectanglesIntersect(int x1, int y1, int w1, int h1, int x2, int y2, int w2, int h2) {
    if (x2 < x1 || y1 < y2) {
      int t1, t2, t3, t4;
      t1 = x1;
      x1 = x2;
      x2 = t1;
      t2 = y1;
      y1 = y2;
      y2 = t2;
      t3 = w1;
      w1 = w2;
      w2 = t3;
      t4 = h1;
      h1 = h2;
      h2 = t4;
    }
    return !(y2 + h2 < y1 || y1 + h1 < y2 || x2 + w2 < x1 || x1 + w1 < x2);
  }

  /*
	 * calcs where bc to te intersects b's rect. if 2 points found, means must
	 * be right on a corner, so in that case just return that corner point. if
	 * inside the rect, return (-999,-999)
	 */
  static Coord NO_INTERSECTION_FOUND = Coord.fromOffset(const Offset(-999,-999));

  static Coord getBubbleIntersectionPoint(Line theLine, Rectangle theRect) {
    Coord result = Coord();

    int numPoints = 0;

    // Top line
    Coord? topSideIP = theLine.getIntersectionPoint(theRect.getTopLine());
    if (topSideIP != null) {
      if (!theLine.includesPoint(topSideIP)) {
        topSideIP = null;
      } else {
        // TrainingProgramDemo.consoleinfo("intersects top side at " +
        // topSideIP.xCommaY());
        numPoints++;
      }
    }
    // Bottom line
    Coord? bottomSideIP = theLine.getIntersectionPoint(theRect.getBottomLine());
    if (bottomSideIP != null) {
      if (!theLine.includesPoint(bottomSideIP)) {
        bottomSideIP = null;
      } else {
        // TrainingProgramDemo.consoleinfo("intersects bottom side at " +
        // bottomSideIP.xCommaY());
        numPoints++;
      }
    }
    // Left side...
    Coord? leftSideIP = theLine.getIntersectionPoint(theRect.getLeftLine());
    if (leftSideIP != null) {
      if (!theLine.includesPoint(leftSideIP)) {
        leftSideIP = null;
      } else {
        // TrainingProgramDemo.consoleinfo("intersects left side at " +
        // leftSideIP.xCommaY());
        numPoints++;
      }
    }
    // Right side
    Coord? rightSideIP = theLine.getIntersectionPoint(theRect.getRightLine());
    if (rightSideIP != null) {
      if (!theLine.includesPoint(rightSideIP)) {
        rightSideIP = null;
      } else {
        // TrainingProgramDemo.consoleinfo("intersects right side at " +
        // rightSideIP.xCommaY());
        numPoints++;
      }
    }

    if (numPoints == 0) {
      return NO_INTERSECTION_FOUND;
    }

    if (numPoints == 1) {
      if (topSideIP != null) {
        return topSideIP;
      }
      if (leftSideIP != null) {
        return leftSideIP;
      }
      if (bottomSideIP != null) {
        return bottomSideIP;
      }
      if (rightSideIP != null) {
        return rightSideIP;
      }
    }

    /*
		 * if more than one candidate found, simply choose the one closest to
		 * the rect centre.
		 */
    if (numPoints == 2) {
      Coord rectCentre = Coord.fromOffset(theRect.center);
//			TrainingProgramDemo.consoleinfo("more than one line intersects a corner");
      // top left
      if (topSideIP != null && leftSideIP != null) {
        return rectCentre.deltaX(topSideIP) > rectCentre.deltaX(leftSideIP) &&
                rectCentre.deltaY(topSideIP) > rectCentre.deltaY(leftSideIP)
            ? leftSideIP
            : topSideIP;
      }
      // top right
      else if (topSideIP != null && rightSideIP != null) {
        return rectCentre.deltaX(topSideIP) > rectCentre.deltaX(rightSideIP) &&
                rectCentre.deltaY(topSideIP) > rectCentre.deltaY(rightSideIP)
            ? rightSideIP
            : topSideIP;
      }
      // bottom left
      else if (bottomSideIP != null && leftSideIP != null) {
        return rectCentre.deltaX(bottomSideIP) > rectCentre.deltaX(leftSideIP) &&
                rectCentre.deltaY(bottomSideIP) > rectCentre.deltaY(leftSideIP)
            ? leftSideIP
            : bottomSideIP;
      }
      // bottom right
      else if (bottomSideIP != null && rightSideIP != null) {
        return rectCentre.deltaX(bottomSideIP) > rectCentre.deltaX(rightSideIP) &&
                rectCentre.deltaY(bottomSideIP) > rectCentre.deltaY(rightSideIP)
            ? rightSideIP
            : bottomSideIP;
      }
    }

    return result;
  }

  // /*
  // * calcs where bc to te intersects the target element's rect.
  // * Will always be 2 intersections, so choose the one that is neither
  // * line a nor b
  // */
  // static Coord getTargetIntersectionPoint(Coord theBubbleCentre,
  // Line theCentreToCentreLine, Rectangle theRect) {
  //
  // Line intersectedEdge = getTargetIntersectingEdge(theBubbleCentre,
  // theRect);
  //
  // return theCentreToCentreLine.getIntersectionPoint(intersectedEdge);
  //
  // }
  //

  /*
	 * its possible that there will be 2 lines intersected (oherwise 1). choose
	 * the intersection pt that is actually on the target rect
	 */
  static Coord? getTargetIntersectionPoint2(
    Coord theCalloutCentre,
    Line line,
    Rectangle targetRectangle,
  ) {
    List<Coord> ips = [];

    // Top line
    Coord? topLineIP = line.getIntersectionPoint(
        Line.fromPoints(targetRectangle.left, targetRectangle.top, targetRectangle.left + targetRectangle.width, targetRectangle.top));
    if (topLineIP != null && targetRectangle.hasPointOnSide(topLineIP, Side.TOP)) ips.add(topLineIP);

    // Bottom line
    Coord? bottomLineIP = line.getIntersectionPoint(Line.fromPoints(targetRectangle.left,
        targetRectangle.top + targetRectangle.height, targetRectangle.left + targetRectangle.width, targetRectangle.top + targetRectangle.height));
    if (bottomLineIP != null && targetRectangle.hasPointOnSide(bottomLineIP, Side.BOTTOM)) ips.add(bottomLineIP);

    // Right side
    Coord? rightLineIP = line.getIntersectionPoint(Line.fromPoints(targetRectangle.left + targetRectangle.width,
        targetRectangle.top, targetRectangle.left + targetRectangle.width, targetRectangle.top + targetRectangle.height));
    if (rightLineIP != null && targetRectangle.hasPointOnSide(rightLineIP, Side.RIGHT)) ips.add(rightLineIP);

    // Left side...
    Coord? leftLineIP = line.getIntersectionPoint(
        Line.fromPoints(targetRectangle.left, targetRectangle.top, targetRectangle.left, targetRectangle.top + targetRectangle.height));
    if (leftLineIP != null && targetRectangle.hasPointOnSide(leftLineIP, Side.LEFT)) ips.add(leftLineIP);

    if (ips.length == 1) {
      return ips[0];
    }

    /*
		 * if more than one candidate found, simply choose the one closest to
		 * the bubble centre.
		 */
    Coord? result;
    if (ips.length > 1) {
      double shortestDelta = 9999;
      for (var ip in ips) {
        double delta = ip.delta(theCalloutCentre);
        if (delta < shortestDelta) {
          shortestDelta = delta;
          result = ip;
        }
      }
    }

    return result;
  }

  static Line? getTargetIntersectingEdge(Coord a, Rectangle r) {
    double slope = (r.top - a.y) / (r.left - a.x);
    double hsw = slope * r.width / 2;
    double hsh = (r.height / 2) / slope;
    double hh = r.height / 2;
    double hw = r.width / 2;
    Coord topLeft = Coord(x: r.left - hw, y: r.top - hh);
    Coord bottomLeft = Coord(x: r.left - hw, y: r.top + hh);
    Coord bottomRight = Coord(x: r.left + hw, y: r.top + hh);
    Coord topRight = Coord(x: r.left + hw, y: r.top - hh);
    Line? result;
    if (-hh <= hsw && hsw <= hh) {
      // line intersects
      if (r.left < a.x) {
        result = Line(topRight, bottomRight);
      } else if (r.left > a.x) {
        result = Line(topLeft, bottomLeft);
      }
    } else if (-hw <= hsh && hsh <= hw) {
      if (r.top < a.y) {
        result = Line(topLeft, topRight);
      } else if (r.top > a.y) {
        result = Line(bottomLeft, bottomRight);
      }
    }

    return result;
  }

  // Coord intersectsLineAt(Line theLine) {
  //   Coord result;
  //   result = getTopLine().getIntersectionPoint(theLine);
  //   if (result != null)
  //     return result;
  //   result = getBottomLine().getIntersectionPoint(theLine);
  //   if (result != null)
  //     return result;
  //   result = getLeftLine().getIntersectionPoint(theLine);
  //   if (result != null)
  //     return result;
  //   result = getRightLine().getIntersectionPoint(theLine);
  //   if (result != null)
  //     return result;
  //   return null;
  // }

  static bool linesIntersect(
      double x1, double y1, double x2, double y2, double x3, double y3, double x4, double y4) {
    double x = ((x1 * y2 - y1 * x2) * (x3 - x4) - (x1 - x2) * (x3 * y4 - y3 * x4)) /
        ((x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4));
    double y = ((x1 * y2 - y1 * x2) * (y3 - y4) - (y1 - y2) * (x3 * y4 - y3 * x4)) /
        ((x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4));
    if (x1 >= x2) {
      if (!(x2 <= x && x <= x1)) {
        return false;
      }
    } else {
      if (!(x1 <= x && x <= x2)) {
        return false;
      }
    }
    if (y1 >= y2) {
      if (!(y2 <= y && y <= y1)) {
        return false;
      }
    } else {
      if (!(y1 <= y && y <= y2)) {
        return false;
      }
    }
    if (x3 >= x4) {
      if (!(x4 <= x && x <= x3)) {
        return false;
      }
    } else {
      if (!(x3 <= x && x <= x4)) {
        return false;
      }
    }
    if (y3 >= y4) {
      if (!(y4 <= y && y <= y3)) {
        return false;
      }
    } else {
      if (!(y3 <= y && y <= y4)) {
        return false;
      }
    }
    return true;
  }

  Line getTopLine() {
    return Line.fromPoints(left, top, left + width, top);
  }

  Line getBottomLine() {
    return Line.fromPoints(left, top + height, left + width, top + height);
  }

  Line getLeftLine() {
    return Line.fromPoints(left, top, left, top + height);
  }

  Line getRightLine() {
    return Line.fromPoints(left + width, top, left + width, top + height);
  }

  bool onBottom(Coord p) {
    return Coord.sameValue(p.y, top + height);
  }

  bool onTop(Coord p) {
    return Coord.sameValue(p.y, top);
  }

  bool onLeft(Coord p) {
    return Coord.sameValue(p.x, left);
  }

  bool onRight(Coord p) {
    // if (Math.abs(p.x - (left + width - 1)) < 5)
    // TrainingProgramDemo.consoleinfo("onRight p is " + p.xCommaY() + "   right = " +
    // (left + width -
    // 1));
    return Coord.sameValue(p.x, left + width);
  }

  bool atTopLeft(Coord p) {
    bool result = onTop(p) && onLeft(p);
//		if (result)
//			TrainingProgramDemo.consoleinfo("Reached CORNER");
    return result;
  }

  bool atTopRight(Coord p) {
    bool result = onTop(p) && onRight(p);
//		if (result)
//			TrainingProgramDemo.consoleinfo("Reached CORNER");
    return result;
  }

  bool atBottomLeft(Coord p) {
    bool result = onBottom(p) && onLeft(p);
//		if (result)
//			TrainingProgramDemo.consoleinfo("Reached CORNER");
    return result;
  }

  bool atBottomRight(Coord p) {
    bool result = onBottom(p) && onRight(p);
    return result;
  }

  /*
	 * move 1 point at a time until reached delta. moves clockwise assumption -
	 * would only ever encounter 1 corner
	 */
  Coord cleverTraverseClockwise(Coord theP, int delta) {
    Coord endPos = Coord.clone(theP);
    // TrainingProgramDemo.consoleinfo("traverseClockwise around rect: ",
    // topLeft.xCommaY() + "  " +
    // width + " x " + height + "\n starting at " +
    // endPos.xCommaY());
    bool turnedCorner = false;
    // bool onBottom = false;
    // bool onLeft = false;
    // bool onTop = false;
    // bool onRight = false;
    for (int i = 0; i < delta; i++) {
      if (onBottom(endPos)) {
        if (!turnedCorner && atBottomLeft(endPos)) {
          endPos.y--;
          turnedCorner = true;
        } else {
          endPos.x--;
        }
      } else if (onLeft(endPos)) {
        if (!turnedCorner && atTopLeft(endPos)) {
          endPos.x++;
          turnedCorner = true;
        } else {
          endPos.y--;
        }
      } else if (onTop(endPos)) {
        if (!turnedCorner && atTopRight(endPos)) {
          endPos.y++;
          turnedCorner = true;
        } else {
          endPos.x++;
        }
      } else if (onRight(endPos)) {
        if (!turnedCorner && atBottomRight(endPos)) {
          turnedCorner = true;
          endPos.x--;
        } else {
          endPos.y++;
        }
      }
    }
    // TrainingProgramDemo.consoleinfo("returning " + endPos.xCommaY());
    return endPos;
  }

  /*
	 * move 1 point at a time until reached delta. moves ANTI-clockwise
	 * assumption - would only ever encounter 1 corner
	 */
  Coord cleverTraverseAntiClockwise(Coord theP, int delta) {
    Coord endPos = Coord.clone(theP);
    // TrainingProgramDemo.consoleinfo("traverseClockwise around rect: ",
    // topLeft.xCommaY() + "  " +
    // width + " x " + height + "\n starting at " +
    // endPos.xCommaY());
    bool turnedCorner = false;
    for (int i = 0; i < delta; i++) {
      if (onBottom(endPos)) {
        if (!turnedCorner && atBottomRight(endPos)) {
          endPos.y--;
          turnedCorner = true;
        } else {
          endPos.x++;
        }
      } else if (onLeft(endPos)) {
        if (!turnedCorner && atBottomLeft(endPos)) {
          endPos.x++;
          turnedCorner = true;
        } else {
          endPos.y++;
        }
      } else if (onTop(endPos)) {
        if (!turnedCorner && atTopLeft(endPos)) {
          endPos.y++;
          turnedCorner = true;
        } else {
          endPos.x--;
        }
      } else if (onRight(endPos)) {
        if (!turnedCorner && atTopRight(endPos)) {
          endPos.x--;
          turnedCorner = true;
        } else {
          endPos.y--;
        }
      }
    }
    // TrainingProgramDemo.consoleinfo("returning " + endPos.xCommaY());
    return endPos;
  }

  Coord nextClockwiseCorner(Coord pos) {
    switch (whichSide(pos)) {
      case Side.BOTTOM:
        return Coord.fromOffset(bottomLeft);
      case Side.LEFT:
        return Coord.fromOffset(topLeft);
      case Side.RIGHT:
        return Coord.fromOffset(bottomRight);
      case Side.TOP:
        return Coord.fromOffset(topRight);
      default:
        throw (Exception("nextClockwiseCorner - Not on a Side !"));
    }
  }

  Coord previousClockwiseCorner(Coord pos) {
    switch (whichSide(pos)) {
      case Side.BOTTOM:
        return Coord.fromOffset(bottomRight);
      case Side.LEFT:
        return Coord.fromOffset(bottomLeft);
      case Side.RIGHT:
        return Coord.fromOffset(topRight);
      case Side.TOP:
        return Coord.fromOffset(topLeft);
      default:
        throw (Exception("prevClockwiseCorner - Not on a Side !"));
    }
  }

  double distanceToNextCorner(Coord pos) {
    switch (whichSide(pos)) {
      case Side.TOP:
        return right - pos.x;
      case Side.LEFT:
        return pos.y - top;
      case Side.RIGHT:
        return bottom - pos.y;
      case Side.BOTTOM:
        return pos.x - left;
      default:
        throw (Exception("distanceToNextCorner - Not on a Side !"));
    }
  }

  double distanceToPreviousCorner(Coord pos) {
    switch (whichSide(pos)) {
      case Side.TOP:
        return pos.x - left;
      case Side.LEFT:
        return bottom - pos.y;
      case Side.RIGHT:
        return pos.y - top;
      case Side.BOTTOM:
        return right - pos.x;
      default:
        throw (Exception("distanceToPreviousCorner - Not on a Side !"));
    }
  }

  /*
	 * allowing for a moe of 2, is theValue between a and b
	 */
  bool roughlyWithin(double theValue, double a, double b) {
    return a <= (theValue + 2) && (theValue - 2) <= b;
  }

  bool definitelyLT(double a, double b) {
    return a < b;
  }

  bool definitelyGT(double a, double b) {
    return a > b;
  }

  bool sameAs(double a, double b) {
    return (a - b).abs() < RECTANGLE_MOE;
  }

  bool onSameSide(Coord pos1, Coord pos2) {
    return (whichSide(pos1) == whichSide(pos2));
  }

  /*
	 * used when approximations with doubles causes hard-to-track edge cases
	 * (bugs). E.g. if we calc an intersect of a line to a rect, we snap the
	 * result onto the rect to correct any MOE.
	 *
	 * If the coord happens to be very close to the rect, we put it ON the rect.
	 */
  Coord snapToRect(Coord thePos) {
    Coord result = Coord.clone(thePos);
    if (sameAs(thePos.y, top)) {
      result.y = top;
    } else if (sameAs(thePos.y, bottom)) {
      result.y = bottom;
    }
    if (sameAs(thePos.x, left)) {
      result.x = left;
    } else if (sameAs(thePos.x, right)) {
      result.x = right;
    }
    return result;
  }
}
