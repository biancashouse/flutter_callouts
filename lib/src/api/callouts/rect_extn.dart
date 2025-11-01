import 'package:flutter/material.dart';

/// extend Rect s.t. can convert a localpos into an Alignment
extension RectExtension on Rect {
  /// shift rect to pos (0,0)
  Rect shiftToOrigin() => Rect.fromLTWH(0, 0, width, height);

  /// Converts a line from the center of a Rect [r] to a point [localPos]
  /// into an [Alignment] object.
  ///
  /// The resulting Alignment object represents the position of point [localPos]
  /// relative to the rectangle's center. For example, if [localPos] is at the
  /// top-right corner of [r], this function will return `Alignment(1.0, -1.0)`.
  ///
  /// - [r]: The reference rectangle.
  /// - [localPos]: The target point, in the same coordinate system as the rectangle.
  Alignment pointToAlignment(Offset localPos) {
    // If the rect has no size, normalization is not possible.
    // Return center as a sensible default.
    if (width == 0 || height == 0) {
      return Alignment.center;
    }

    Rect rAt00 = shiftToOrigin();

    // 1. Calculate the vector from the center of the rect to the point p.
    final Offset vectorFromCenter = localPos - rAt00.center;

    // 2. Normalize the vector components based on the rect's dimensions.
    //    The distance from the center to a horizontal edge is (width / 2).
    //    The distance from the center to a vertical edge is (height / 2).
    //    Alignment's coordinate system maps these distances to 1.0.
    final double alignmentX = vectorFromCenter.dx / (width / 2.0);
    final double alignmentY = vectorFromCenter.dy / (height / 2.0);

    return Alignment(alignmentX, alignmentY);
  }
}
