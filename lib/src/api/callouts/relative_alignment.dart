import 'dart:math';

import 'package:flutter/widgets.dart';

(Alignment, Alignment) nearestCandTAlignment(Rect cR, Rect tR) {
  var relativeNearestVertical = closestVertically(cR, tR);
  var relativeNearestHorizontsl = closestHorizontally(cR, tR);
  return (Alignment(relativeNearestVertical.$1, relativeNearestVertical.$1), Alignment(relativeNearestHorizontsl.$2, relativeNearestHorizontsl.$2));
}

(double, double) closestVertically(Rect cR, Rect tR) {
  List<double> deltas = [
    (cR.top - tR.top).abs(),
    (cR.top - tR.center.dy).abs(),
    (cR.top - tR.bottom).abs(),
    (cR.center.dy - tR.top).abs(),
    (cR.center.dy - tR.center.dy).abs(),
    (cR.center.dy - tR.bottom).abs(),
    (cR.bottom - tR.top).abs(),
    (cR.bottom - tR.center.dy).abs(),
    (cR.bottom - tR.bottom).abs(),
  ];
  double closest = deltas.reduce(min);
  int indexOfClosest = deltas.indexOf(closest);
  // int findSmallestIndex(List<int> numbers) {
  //   return numbers.indexWhere((number) => number == numbers.reduce(min));
  // }
  // convert into vertical Alignment values for Callout and Target resp.
  (double, double) result = switch (indexOfClosest) {
    0 => (-1, -1),
    1 => (0, -1),
    2 => (1, -1),
    3 => (-1, 0),
    4 => (0, 0),
    5 => (1, 0),
    6 => (-1, 1),
    7 => (0, 1),
    8 => (1, 1),
    // ---------
    _ => (0, 0)
  };
  return result;
}

(double, double) closestHorizontally(Rect cR, Rect tR) {
  List<double> deltas = [
    (cR.left - tR.left).abs(),
    (cR.left - tR.center.dy).abs(),
    (cR.left - tR.right).abs(),
    (cR.center.dy - tR.left).abs(),
    (cR.center.dy - tR.center.dy).abs(),
    (cR.center.dy - tR.right).abs(),
    (cR.right - tR.left).abs(),
    (cR.right - tR.center.dy).abs(),
    (cR.right - tR.right).abs(),
  ];
  double closest = deltas.reduce(min);
  int indexOfClosest = deltas.indexOf(closest);
  // int findSmallestIndex(List<int> numbers) {
  //   return numbers.indexWhere((number) => number == numbers.reduce(min));
  // }
  // convert into vertical Alignment values for Callout and Target resp.
  (double, double) result = switch (indexOfClosest) {
    0 => (-1, -1),
    1 => (0, -1),
    2 => (1, -1),
    3 => (-1, 0),
    4 => (0, 0),
    5 => (1, 0),
    6 => (-1, 1),
    7 => (0, 1),
    8 => (1, 1),
    // ---------
    _ => (0, 0)
  };
  return result;
}
