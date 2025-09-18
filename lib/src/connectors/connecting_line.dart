import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';
import 'package:flutter_callouts/src/api/callouts/pointing_line.dart';



class ConnectingLine {
  final CalloutId feature;

  final TargetKeyFunc fromGKF;
  final TargetKeyFunc toGKF;

  // extend line in the to direction by delta
  final double? fromDelta;

  // extend line in the from direction by delta
  final double? toDelta;

  final Function? onExpiredF;
  final TargetPointerTypeEnum arrowThickness;
  final Color arrowColor;

  final bool animate;

  final completer = Completer<bool>();

  OverlayEntry? _lineEntry;

  OverlayState? overlayState;

  double? top;
  double? left;
  int animatedPositionDurationMs = 500;

  // for hiding / unhiding
  double? savedTop;
  double? savedLeft;

  double? actualTop;
  double? actualLeft;

  ConnectingLine({
    required this.feature,
    required this.toGKF,
    this.toDelta,
    required this.fromGKF,
    this.fromDelta,
    this.onExpiredF,
    this.arrowThickness = TargetPointerTypeEnum.THIN_LINE,
    this.arrowColor = Colors.grey,
    this.animate = false,
  });

  Coord? toE, fromE;

  late Rectangle? fromR;
  Rectangle? toR;

  Future<void> init() async {
    //TODO use OverlayManager...
    if (getToGK() != null) {
      overlayState = Overlay.of(getToGK()!.currentContext!);
      overlayState!.insert(_lineEntry = _createLineEntry());
    }
  }

  GlobalKey? getToGK() => toGKF.call();

  GlobalKey? getFromGK() => fromGKF.call();

  Rectangle? rectangleFromGK(GlobalKey gk) {
    if (gk.currentWidget == null) {
      developer.log('gk not found in the widget tree - assuming no target specified! (${feature.toString()})');
      return null;
    } else {
      Rect? r = gk.globalPaintBounds(); //Measuring.findGlobalRect(gk);
      return r != null ? Rectangle.fromRect(r) : null;
    }
  }

  // Rectangle rectangleFromGK(GlobalKey gk) {
  //   Rect r;
  //   if (gk.currentWidget == null) {
  //     developer.log('gk not found in the widget tree - assuming no target specified! (${feature.toString()})');
  //     r = const Rect.fromLTWH(0, 0, 1, 1);
  //   } else {
  //     r = findGlobalRect(gk);
  //   }
  //   return Rectangle.fromRect(r);
  // }

  OverlayEntry _createLineEntry() => OverlayEntry(builder: (BuildContext ctx) {
        calcEndpoints();
        if (toE == null || fromE == null) {
          return const Offstage();
        }
        Rect r = Rect.fromPoints(toE!.asOffset, fromE!.asOffset);
        Offset to = toE!.asOffset.translate(-r.left, -r.top);
        Offset from = fromE!.asOffset.translate(-r.left, -r.top);
        // Line line = Line(Coord.fromOffset(from), Coord.fromOffset(to));

        return Positioned(
          top: r.top,
          left: r.left,
          child: IgnorePointer(
            child: PointingLine(
              from,
              to,
              arrowThickness,
              arrowColor,
              animate: animate,
            ),
          ),
        );
      });

  void calcEndpoints() {
    if (toGKF() == null) return;
    toR = rectangleFromGK(toGKF()!);
    if (toR != null) {
      if (fromGKF() == null) return;
      fromR = rectangleFromGK(fromGKF()!);
      if (fromR != null) {
        var toCentre = toR!.center;
        var fromCentre = fromR!.center;
        Line line = Line.fromOffsets(fromCentre, toCentre);

        toE = Rectangle.getTargetIntersectionPoint2(Coord.fromOffset(fromCentre), line, toR!);
        fromE = Rectangle.getTargetIntersectionPoint2(Coord.fromOffset(toCentre), line, fromR!);

        if (toDelta != null && toDelta != 0.0) {
          toE = Coord.changeDistanceBetweenPoints(fromE, toE, toDelta);
        }

        if (fromDelta != null && fromDelta != 0.0) {
          fromE = Coord.changeDistanceBetweenPoints(toE, fromE, fromDelta);
        }
      }
    }
  }

  void hide() {
    overlaySetState(() {
      savedTop = top;
      savedLeft = left;
      top = 9999;
      left = 9999;
    });
  }

  void unhide() {
    overlaySetState(() {
      top = savedTop;
      left = savedLeft;
    });
  }

  void _completed(bool result) {
    _lineEntry?.remove();
    onExpiredF?.call();
    // triggers caller with true = did something, or false = aborted
    completer.complete(result);
  }

  void overlaySetState(f) {
    // because not allowed to setState from outside of the state itself !
    overlaySetState(f);
  }

  static Future<bool> showLine({
    required ConnectingLine line,
    int? removeAfterMs,
  }) async {
    // skip if same overlay already found
    if (fca.anyPresent([line.feature])) return false;

    await line.init();

    // show line
    if (removeAfterMs != null) {
      Future.delayed(Duration(milliseconds: removeAfterMs), () {
        line.onExpiredF?.call();
        line._completed(true);
      });
    }

    return line.completer.future;
  }
}
