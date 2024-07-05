// ignore_for_file: constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

mixin CalloutUseful /* extends BaseUseful */ {
  // late SharedPreferences _prefs;
  // late LocalStoreHydrated _localStore;
  // final Map<String, OverlayManager> _oms = {};

  GlobalKey? _offstageGK;
  WidgetBuilder _builder = (context) => const Icon(Icons.warning);
  OverlayEntry? _oe;

  final List<ScrollController> registeredScrollControllers = [];

  //avoids listening to the same scrollcontroller more than once for the purpose of refreshing the overlays
  void registerScrollController(ScrollController sController) {
    if (!registeredScrollControllers.contains(sController)) {
      sController.addListener(() => Callout.refreshAll());
    }
  }

  createOffstageOverlay(BuildContext context) {
    Overlay.of(context).insert(_oe = OverlayEntry(
        builder: (BuildContext ctx) => Offstage(
              child: Material(
                color: Colors.transparent,
                child: Center(
                  child: Container(
                    key: _offstageGK,
                    child: _builder(context),
                  ),
                ),
              ),
            )));
  }

  // update config with measured size
  Size _measureOffstageWidget(
    bool skipWidthConstraintWarning,
    bool skipHeightConstraintWarning,
  ) {
    if (_offstageGK != null) {
      Rect? rect = _offstageGK!.globalPaintBounds(
        skipWidthConstraintWarning: skipWidthConstraintWarning,
        skipHeightConstraintWarning: skipHeightConstraintWarning,
      ); //Measuring.findGlobalRect(_offstageGK!);
      if (rect != null) {
        debugPrint(
            '_measureThenRenderCallout: width:${rect.width}, height:${rect.height}');
        return rect.size;
      }
    }
    return Size.zero;
  }

  // void _saveScrollOffsets() {
  //   if (editingPageState?.vScrollController.positions.isNotEmpty ?? false) {
  //     _vScrollControllerOffset = editingPageState?.vScrollController.offset;
  //   }
  //   if (editingPageState?.hScrollController.positions.isNotEmpty ?? false) {
  //     _hScrollControllerOffset = editingPageState?.hScrollController.offset;
  //   }
  //   if (editingPageState != null && editingPageState!.itemScrollController.hasClients) {
  //     commentsAutoScrollControllerOffset = editingPageState!.itemScrollController.offset;
  //   }
  // }
  //
  // void restoreScrollOffsetsAfterNextBuild() {
  //   _saveScrollOffsets();
  //   Useful.afterNextBuildDo(() {
  //     debugPrint('restoreScrollOffsetsAfterNextBuild');
  //     if (_vScrollControllerOffset != null && (editingPageState?.vScrollController.hasClients ?? false)) {
  //       editingPageState?.vScrollController.jumpTo(_vScrollControllerOffset!);
  //     }
  //     if (_hScrollControllerOffset != null && (editingPageState?.hScrollController.hasClients ?? false)) {
  //       editingPageState?.hScrollController.jumpTo(_hScrollControllerOffset!);
  //     }
  //     if (commentsAutoScrollControllerOffset != null && (editingPageState?.itemScrollController.hasClients ?? false)) {
  //       editingPageState?.itemScrollController.jumpTo(commentsAutoScrollControllerOffset!);
  //     }
  //   });
  // }

  /// given a Rect, returns most appropriate alignment between target and callout within the wrapper
  /// NOTICE does not depend on callout size
  Alignment calcTargetAlignmentWithinWrapper(
      Rect wrapperRect, final Rect targetRect) {
    // Rect? wrapperRect = findGlobalRect(widget.key as GlobalKey);

    Rect screenRect =
        Rect.fromLTWH(0, 0, fca.scrW, fca.scrH);
    wrapperRect = screenRect;
    Offset wrapperC = wrapperRect.center;
    Offset targetRectC = targetRect.center;
    double x = (targetRectC.dx - wrapperC.dx) / (wrapperRect.width / 2);
    double y = (targetRectC.dy - wrapperC.dy) / (wrapperRect.height / 2);
    // keep away from sides
    if (x < -0.75) {
      x = -1.0;
    } else if (x > 0.75) {
      x = 1.0;
    }
    if (y < -0.75) {
      y = -1.0;
    } else if (y > 0.75) {
      y = 1.0;
    }
    // debugPrint("$x, $y");
    return Alignment(x, y);
  }

  Offset? findGlobalPos(GlobalKey key) {
    BuildContext? cxt = key.currentContext;
    RenderObject? renderObject = cxt?.findRenderObject();
    return (renderObject as RenderBox).localToGlobal(Offset.zero);
  }

  (double, double) ensureOnScreen(
      Rect calloutRect, double minVisibleH, double minVisibleV) {
    double resultLeft = calloutRect.left;
    double resultTop = calloutRect.top;
    // adjust s.t entirely visible
    if (calloutRect.left > (fca.scrW - minVisibleH)) {
      resultLeft = fca.scrW - minVisibleH;
    }
    if (calloutRect.top >
        (fca.scrH - minVisibleV - fca.kbdH)) {
      resultTop = fca.scrH - minVisibleV - fca.kbdH;
    }
    if (calloutRect.right < minVisibleH)
      resultLeft = minVisibleH - calloutRect.width;
    if (calloutRect.bottom < minVisibleV)
      resultTop = minVisibleV - calloutRect.height;

    return (resultLeft, resultTop);
  }

  Rect restrictRectToScreen(Rect rect) {
    // Clamp left and top to screen bounds
    final left = max(rect.left, 0.0);
    final top = max(rect.top, 0.0);

    // Clamp right and bottom to prevent going off-screen
    final right = min(rect.right, fca.scrW);
    final bottom = min(rect.bottom, fca.scrH);

    // Ensure width and height remain positive (might be 0 if completely off-screen)
    final width = max(0.0, right - left);
    final height = max(0.0, bottom - top);

    return Rect.fromLTWH(left, top, width, height);
  }

  // compare appInfo versionAndBuild with this app's yaml values
  // static Future<bool> possiblyInformUserOfNewVersion() async {
  //   String appsVersionAndBuildNum = await FCA.versionAndBuild;
  //   String? storedVersionAndBuild = FCA.appInfo.versionAndBuildNum ?? '';
  //   if (appsVersionAndBuildNum != storedVersionAndBuild) {
  //     FCA.appInfo.versionAndBuildNum = appsVersionAndBuildNum;
  //     if (false) FCA.modelRepo.saveAppInfo();
  //     return true;
  //   }
  //   return false;
  // }

// static (double, double) ensureOnScreenOLD(Rect calloutRect) {
//   double startingCalloutLeft = calloutRect.left;
//   double startingCalloutTop = calloutRect.top;
//   double resultLeft = startingCalloutLeft;
//   double resultTop = startingCalloutTop;
//   // adjust s.t entirely visible
//   if (startingCalloutLeft + calloutRect.width > Useful.scrW) {
//     resultLeft = Useful.scrW - calloutRect.width;
//   }
//   if (startingCalloutTop + calloutRect.height > (Useful.scrH - Useful.kbdH)) {
//     resultTop = Useful.scrH - calloutRect.height - Useful.kbdH;
//   }
//   if (startingCalloutLeft < 0) resultLeft = 0;
//   if (startingCalloutTop < 0) resultTop = 0;
//
//   return (resultLeft, resultTop);
// }

  Alignment calcTargetAlignmentWholeScreen(
      final Rect targetRect, double calloutW, double calloutH) {
    Rect screenRect =
        Rect.fromLTWH(0, 0, fca.scrW, fca.scrH);
    double T = targetRect.top;
    double L = targetRect.left;
    double B = screenRect.height - targetRect.bottom;
    double R = screenRect.width - targetRect.right;
    double spareAbove = T - calloutH;
    double spareBelow = B - calloutH;
    double spareOnLeft = L - calloutW;
    double spareOnRight = R - calloutW;
    double maxSpare =
        [spareAbove, spareBelow, spareOnLeft, spareOnRight].reduce(max);
    if (maxSpare == spareOnRight) {
      return Alignment.centerRight;
    } else if (maxSpare == spareOnLeft)
      return Alignment.centerLeft;
    else if (maxSpare == spareAbove)
      return Alignment.topCenter;
    else
      return Alignment.bottomCenter;
    // else if (maxSpare == spareBelow) return Alignment.topCenter;
    // bool calloutPossiblyOnLeft = L > calloutW;
    // bool calloutPossiblyOnRight = R > calloutW;
    // bool calloutPossiblyAbove = T > calloutH;
    // bool calloutPossiblyBelow = B > calloutH;
    // if (L > R) {
    //   bool onLeft = calloutPossiblyOnLeft;
    // } else {
    //   bool onRight = calloutPossiblyOnRight;
    // }
    // if (T > B) {
    //   bool above = calloutPossiblyAbove;
    // } else {
    //   bool below = calloutPossiblyBelow;
    // }
    // if ()
    //   if (calloutW < B) return Alignment.bottomCenter;
    // if (calloutW < T) return Alignment.topCenter;
    // if (calloutW < R) return Alignment.centerRight;
    // if (calloutW < L) return Alignment.centerLeft;
    //
    // return Alignment.center;
  }

  void afterNextBuildMeasureThenDo(
    final WidgetBuilder widgetBuilder,
    final ValueChanged<Size> fn, {
    final bool skipWidthConstraintWarning =
        false, // should be true if a width was supplied
    final bool skipHeightConstraintWarning =
        false, // should be true if a height was supplied
    final List<ScrollController>? scrollControllers,
  }) {
    Map<int, double> savedOffsets = {};
    if (scrollControllers != null && scrollControllers.isNotEmpty) {
      for (int i = 0; i < scrollControllers.length; i++) {
        ScrollController sc = scrollControllers[i];
        if (sc.positions.isNotEmpty) {
          savedOffsets[i] = sc.offset;
        }
      }
    }
    _offstageGK = GlobalKey(debugLabel: 'offstage-gk');
    _builder = widgetBuilder;
    _oe?.markNeedsBuild();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        if (savedOffsets.isNotEmpty) {
          for (int i in savedOffsets.keys) {
            scrollControllers![i].jumpTo(savedOffsets[i]!);
            // scrollControllers![i].animateTo(savedOffsets[i]!, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
          }
        }
        Size size = _measureOffstageWidget(
            skipWidthConstraintWarning, skipHeightConstraintWarning);
        if (size != Size.zero) fn.call(size);
      },
    );
  }
}

// class Measuring {
//   Measuring._();
//
//   static Rect? findGlobalRect(GlobalKey key) {
//     final RenderObject? renderObject = key.currentContext?.findRenderObject();
//
//     if (renderObject == null) {
//       return null;
//     }
//
//     if (renderObject is RenderBox) {
//       final Offset globalOffset = renderObject.localToGlobal(Offset.zero);
//
//       Rect bounds = renderObject.paintBounds;
//       bounds = bounds.translate(globalOffset.dx, globalOffset.dy);
//       return bounds;
//     } else {
//       Rect bounds = renderObject.paintBounds;
//       var translation = renderObject.getTransformTo(null).getTranslation();
//       bounds = bounds.translate(translation.x, translation.y);
//       return bounds;
//     }
//   }
//
// static Future<Rect> measureWidgetRect({
//   required BuildContext context,
//   required Widget widget,
//   required BoxConstraints boxConstraints,
// }) {
//   final Completer<Rect> completer = Completer<Rect>();
//   OverlayEntry? entry;
//   entry = OverlayEntry(builder: (BuildContext ctx) {
//     debugPrint(Theme.of(context).platform);
//     return Material(
//       child: MeasureWidget(
//         boxConstraints: boxConstraints,
//         measureRect: (Rect? rect) {
//           entry?.remove();
//           completer.complete(rect);
//         },
//         child: widget,
//       ),
//     );
//   });
//
//   Overlay.of(context).insert(entry);
//   return completer.future;
// }
// }

extension ExtendedOffset on Offset {
  String toFlooredString() {
    return '(${dx.floor()}, ${dy.floor()})';
  }
}

bool _alreadyGaveGlobalPosAndSizeWarning = false;

extension GlobalKeyExtension on GlobalKey {
  (Offset?, Size?) globalPosAndSize() {
    Rect? r = globalPaintBounds();
    return (r?.topLeft, r?.size);
  }

  Rect? globalPaintBounds({bool skipWidthConstraintWarning = true, bool skipHeightConstraintWarning = true}) {
    // var cw = currentWidget;
    var cc = currentContext;
    Size? scrSize;
    if (cc == null) {
      debugPrint('GlobalKeyExtension: currentContext NULL!');
    } else {
      scrSize = MediaQuery.sizeOf(cc);
    }
    final renderObject = cc?.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    Rect? paintBounds;
    try {
      paintBounds = renderObject?.paintBounds;
    } catch (e) {
      debugPrint('paintBounds = renderObject?.paintBounds - ${e.toString()}');
    }
    // possibly warn about the target having an infinite width
    if (!_alreadyGaveGlobalPosAndSizeWarning &&
        !skipWidthConstraintWarning &&
        !skipHeightConstraintWarning &&
        (paintBounds?.width == scrSize!.width ||
            paintBounds?.height == fca.scrH)) {
      _alreadyGaveGlobalPosAndSizeWarning = true;
      Callout.showOverlay(
        calloutContentF: (BuildContext context) {
          return Column(
            children: [
              Text('Warning - Target Size Constraint'),
              Text(
                paintBounds?.width == fca.scrW
                    ? "\nThe width of your callout target is the same as the window width.\n"
                        "This might indicate that your target has an unbounded width constraint.\n"
                        "This occurs, for example, when your target is a child of a ListView.\n\n"
                        "If this is intentional, add 'skipContraintWarning:true' as an arg\n\n"
                        "  to constructor Callout.wrapTarget\n\n"
                        "  or to calls to Callout.showOverlay()\n\n"
                        "Context: ${cc.toString()}"
                    : "\nThe hwight of your callout target is the same as the window hwight.\n"
                        "This might indicate that your target has an unbounded hwight constraint.\n"
                        "If this height is intentional, add 'skipContraintWarning:true' as an arg\n\n"
                        "  to constructor Callout.wrapTarget\n\n"
                        "  or to calls to Callout.showOverlay()\n\n"
                        "Context: ${cc.toString()}",
              ),
              TextButton(
                onPressed: () {
                  Callout.removeParentCallout(context);
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
        calloutConfig: CalloutConfig(
          cId: 'globalPaintBounds error',
          draggable: false,
          initialCalloutW: fca.scrW * .7,
          initialCalloutH: 400,
          fillColor: Colors.white,
        ),
      );
    }
    if (translation != null && paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return paintBounds.shift(offset);
    } else {
      return null;
    }
  }
}
