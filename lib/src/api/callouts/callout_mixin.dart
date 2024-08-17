import 'dart:math';


import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';
import 'package:flutter_callouts/src/api/callouts/overlay_entry_list.dart';

mixin CalloutMixin {

  static const int separationAnimationMs = 500;

  // assumption: at least 1 build has been executed; after initState
  // #begin
  Future<void> showOverlay({
    // ZoomerState? zoomer, // if callout needs access to the zoomer
    required CalloutConfig calloutConfig,
    required Widget calloutContent,
    TargetKeyFunc? targetGkF,
    bool ensureLowestOverlay = false,
    int? removeAfterMs,
    final ValueNotifier<int>? targetChangedNotifier,
    // TargetModel? configurableTarget,
    final skipWidthConstraintWarning = false,
    final skipHeightConstraintWarning = false,
  }) async
  // #end
      {
    if (fca.alreadyGotit(calloutConfig.cId)) return;

    if (Callout.anyPresent([calloutConfig.cId])) return;

    if ((calloutConfig.calloutW ?? 0) < 0) {
      print('tbd');
    }

    // target's GlobalKey supplied
    if (removeAfterMs != null) {
      Future.delayed(Duration(milliseconds: removeAfterMs), () {
        // calloutConfig.onDismissedF?.call();
        Callout.dismiss(calloutConfig.cId);
      });
    }

    // // get this target's context
    // if (targetGkF != null) {
    //   GlobalKey? gk = targetGkF.call();
    //   var cc = gk?.currentContext;
    //   if (cc == null) {
    //     fca.logi(
    //         '${calloutConfig.cId} missing target gk - overlay not shown');
    //     return;
    //   } else {
    //     fca.initWithContext(cc);
    //   }
    // }

    // possibly create the overlay after measuring the callout's content
    if (calloutConfig.initialCalloutW == null ||
        calloutConfig.initialCalloutH == null) {
      fca
          .measureWidgetRect(context: fca.rootContext, widget: calloutContent)
          .then(
            (rect) {
          calloutConfig.calloutW = rect.width;
          calloutConfig.calloutH = rect.height;
          fca.logi('measured content size: ${rect.toString()}');
          _createOverlayDefinitelyHasSize(
            calloutConfig,
            calloutContent,
            // zoomer,
            targetGkF,
            targetChangedNotifier,
            ensureLowestOverlay,
          );
        },
      );
    } else {
      // width and height supplied
      calloutConfig.initialCalloutW = calloutConfig.initialCalloutH = 0.0;
      _createOverlayDefinitelyHasSize(
        calloutConfig,
        calloutContent,
        // zoomer,
        targetGkF,
        targetChangedNotifier,
        ensureLowestOverlay,
      );
    }

    await Future.delayed(Duration(milliseconds: 800));
  }

  void _createOverlayDefinitelyHasSize(CalloutConfig calloutConfig,
      Widget calloutContent,
      // ZoomerState? zoomer,
      TargetKeyFunc? targetGkF,
      ValueNotifier<int>? targetChangedNotifier,
      bool ensureLowestOverlay,) {
    OverlayEntry oEntry = _createOverlay(
      // zoomer,
      calloutConfig,
      calloutContent,
      targetGkF,
      ensureLowestOverlay,
    ); // will be null if target not present
    // if a notifer was passed in, means inside another overlay, so the target would change as the overlay gets moved or resized
    targetChangedNotifier?.addListener(() {
      // fca.logi("\n\ntime to update the target\n\n");
      fca.afterNextBuildDo(() => oEntry.markNeedsBuild());
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      if (calloutConfig.notToast) {
        // fca.logi('_possiblyAnimateSeparation');
        _possiblyAnimateSeparation(calloutConfig);
      } else {
        _possiblyAnimateToastPos(calloutConfig);
      }
    });
  }

  OverlayEntry _createOverlay(// ZoomerState? zoomer,
      CalloutConfig calloutConfig,
      Widget boxContent,
      TargetKeyFunc? targetGkF,
      bool ensureLowestOverlay,) {
    late OverlayEntry entry;
    entry = OverlayEntry(builder: (BuildContext ctx) {
      // FCA.initWithContext(ctx);
      // fca.logi('...');
      // fca.logi("${calloutConfig.cId} OverlayEntry.builder...");
      // fca.logi('...');
// if (calloutConfig.cId == 'root'){
//   fca.logi('root');
// }

      // if no target and no initialPos, use scren dimension
      if (calloutConfig.initialCalloutW == null &&
          calloutConfig.initialCalloutH == null &&
          calloutConfig.initialCalloutPos == null) {
        calloutConfig.initialCalloutW = fca.scrW;
        calloutConfig.initialCalloutH = fca.scrH;
      }
      Rect? r = targetGkF?.call()?.globalPaintBounds(
          skipWidthConstraintWarning: calloutConfig.calloutW != null,
          skipHeightConstraintWarning: calloutConfig.calloutH != null);
      if (r == null) {
// for toast targetgk will be null, and we have to use the gravity to get a rect
        calloutConfig.initialCalloutPos ??= Offset(
          fca.scrW / 2 - calloutConfig.initialCalloutW! / 2,
          fca.scrH / 2 - calloutConfig.initialCalloutH! / 2,
        );
        r = Rect.fromLTWH(
          calloutConfig.initialCalloutPos!.dx,
          calloutConfig.initialCalloutPos!.dy,
          calloutConfig.initialCalloutW!,
          calloutConfig.initialCalloutH!,
        );
// fca.logi('${calloutConfig.cId} failed to measure pos and size from targetGkF - overlay not shown');
// return const Icon(Icons.warning_amber);
      }
      OE? oeObj = Callout.findOE(calloutConfig.cId);
      if ((calloutConfig.calloutW ?? 0) <= 0) {
        fca.logi(
            'calloutW:${calloutConfig.calloutW} !!!  (cId:${calloutConfig
                .cId}');
      }
      return Visibility(
        visible: oeObj == null || !oeObj.isHidden,
        child: calloutConfig.oeContentWidget(
// zoomer: zoomer,
          targetRect: r,
          calloutContent: (_) => boxContent,
          rebuildF: () {
            entry.markNeedsBuild();
          },
        ),
      );
    });
    OverlayEntry? lowestOverlay;
    int? pos;
    if (ensureLowestOverlay) {
      final result = Callout.lowestEntry();
      pos = result.$1;
      lowestOverlay = result.$2;
    }

    // fca.afterNextBuildDo(() {
    Overlay.of(fca.rootContext).insert(entry, below: lowestOverlay);
    // });

// // animate separation just once
//     if (calloutConfig.finalSeparation > 0.0) {
//       var rootContext = FCallouts().rootContext;
//       if (rootContext != null) {
//         var zoomer = Zoomer.of(rootContext);
//         if (zoomer != null) {
//           AnimationController animationController = AnimationController(
//             duration: const Duration(milliseconds: 1),
//             vsync: calloutConfig.vsync!,
//           );
//           Tween<double> tween =
//               Tween<double>(begin: 0.0, end: calloutConfig.finalSeparation);
//           Animation<double> animation = tween.animate(animationController);
//           animation.addListener(() => calloutConfig.setSeparation(
//               animation.value, () => entry.markNeedsBuild()));
//           calloutConfig.setRebuildCallback(() {
//             entry.markNeedsBuild();
//           });
//           animationController.forward().whenComplete(() {
//             calloutConfig.finishedAnimatingSeparation();
//           });
//         }
//       }
//     }
    OE.registerOE(
        OE(entry: entry, calloutConfig: calloutConfig, isHidden: false),
        before: pos);
    return entry;
  }

  Future<void> _possiblyAnimateSeparation(CalloutConfig calloutConfig) async {
    if (calloutConfig.finalSeparation > 0.0) {
      // animate separation, top or left
      AnimationController animationController = AnimationController(
        duration: const Duration(milliseconds: separationAnimationMs),
        vsync: calloutConfig,
      );
      Tween<double> tween =
      Tween<double>(begin: 0.0, end: calloutConfig.finalSeparation);
      Animation<double> animation = tween.animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.bounceOut,
      ));
      animation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          calloutConfig.finishedAnimatingSeparation();
          animationController.dispose();
        }
      });
      animation.addListener(() {
        //fca.logi('new separation: ${animation.value}');
        calloutConfig.setSeparation(animation.value);
      });
      calloutConfig.startedAnimatingSeparation();
      animationController.forward(from: 0.0);
    }
  }

  static bool _sameType<T1, T2>() => T1 == T2;

  void showToast({
    required CalloutConfig calloutConfig,
    required Widget calloutContent,
    int removeAfterMs = 0,
  }) {
    assert(calloutConfig.gravity != null &&
        calloutConfig.initialCalloutW != null &&
        calloutConfig.initialCalloutH != null);

    CalloutConfig toastCC = calloutConfig.copyWith(
      cId: calloutConfig.cId,
      scrollControllerName: calloutConfig.scrollControllerName,
      initialTargetAlignment: null,
      initialCalloutAlignment: null,
      gravity: calloutConfig.gravity,
      initialCalloutPos: _initialOffsetFromGravity(
        calloutConfig.gravity!,
        calloutConfig.initialCalloutW!,
        calloutConfig.initialCalloutH!,
      ),
      arrowType: ArrowType.NONE,
      // draggable: false,
      skipOnScreenCheck: true,
    );
    if (removeAfterMs > 0) {
      Future.delayed(Duration(milliseconds: removeAfterMs), () {
        Callout.dismiss(toastCC.cId);
      });
    }
    showOverlay(
      calloutConfig: toastCC,
      calloutContent: calloutContent,
    );
  }

  Offset _initialOffsetFromGravity(Alignment alignment, double w, double h) {
    late Offset initialOffset;
    if (alignment == Alignment.topCenter) {
      initialOffset = Offset((fca.scrW - w) / 2, -h);
    } else if (alignment == Alignment.topLeft) {
      initialOffset = Offset(-w, -h);
    } else if (alignment == Alignment.topRight) {
      initialOffset = Offset(fca.scrW, -h);
    } else if (alignment == Alignment.bottomCenter) {
      initialOffset = Offset((fca.scrW - w) / 2, fca.scrH);
    } else if (alignment == Alignment.bottomLeft) {
      initialOffset = Offset(-w, fca.scrH);
    } else if (alignment == Alignment.bottomRight) {
      initialOffset = Offset(fca.scrW, fca.scrH);
    } else if (alignment == Alignment.center) {
      initialOffset =
          Offset(fca.scrW / 2 - w / 2 - 10, fca.scrH / 2 - h / 2 - 10);
    } else if (alignment == Alignment.centerLeft) {
      initialOffset = Offset(-w, fca.scrH / 2 - h / 2);
    } else if (alignment == Alignment.centerRight) {
      initialOffset = Offset(fca.scrW, fca.scrH / 2 - h / 2);
    } else {
      initialOffset =
          Offset(fca.scrW / 2 - w / 2 - 10, fca.scrH / 2 - h / 2 - 10);
    }
    return initialOffset;
  }

  Offset _finalOffsetFromGravity(Alignment alignment, double w, double h) {
    late Offset initialOffset;
    if (alignment == Alignment.topCenter) {
      initialOffset = Offset((fca.scrW - w) / 2, 10);
    } else if (alignment == Alignment.topLeft) {
      initialOffset = Offset(10, 10);
    } else if (alignment == Alignment.topRight) {
      initialOffset = Offset(fca.scrW - w - 10, 10);
    } else if (alignment == Alignment.bottomCenter) {
      initialOffset = Offset((fca.scrW - w) / 2, fca.scrH - h - 10);
    } else if (alignment == Alignment.bottomLeft) {
      initialOffset = Offset(10, fca.scrH - h - 10);
    } else if (alignment == Alignment.bottomRight) {
      initialOffset = Offset(fca.scrW - w - 10, fca.scrH - h - 20);
    } else if (alignment == Alignment.center) {
      initialOffset = Offset(fca.scrW / 2 - w / 2, fca.scrH / 2 - h / 2);
    } else if (alignment == Alignment.centerLeft) {
      initialOffset = Offset(10, fca.scrH / 2 - h / 2);
    } else if (alignment == Alignment.centerRight) {
      initialOffset = Offset(fca.scrW - w - 10, fca.scrH / 2 - h / 2);
    } else {
      initialOffset = Offset(fca.scrW / 2 - w / 2, fca.scrH / 2 - h / 2);
    }
    return initialOffset;
  }

  Future<void> _possiblyAnimateToastPos(CalloutConfig toastCC) async {
    if (toastCC.left != null && toastCC.top != null) {
      Offset initialPos = Offset(toastCC.left!, toastCC.top!);
      Offset finalPos = _finalOffsetFromGravity(
        toastCC.gravity!,
        toastCC.calloutW!,
        toastCC.calloutH!,
      );
      // animate pos from offscreen
      AnimationController animationController = AnimationController(
        duration: const Duration(milliseconds: separationAnimationMs),
        vsync: toastCC,
      );
      Tween<Offset> tween = Tween<Offset>(begin: initialPos, end: finalPos);
      Animation<Offset> animation = tween.animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.bounceOut,
      ));
      animation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          toastCC.finishedAnimatingSeparation();
          animationController.dispose();
        }
      });
      animation.addListener(() {
        toastCC.setPos(animation.value);
      });
      toastCC.startedAnimatingSeparation();
      animationController.forward();
    }
  }

  void showCircularProgressIndicator(bool show, {required String reason}) {
// if (width != null && height == null) height = 60;
    BuildContext? cachedContext = fca.rootContext;
    if (show && (cachedContext.mounted)) {
      showOverlay(
        calloutConfig: CalloutConfig(
          cId: reason,
          gravity: Alignment.topCenter,
          // scale: 1.0,
          initialCalloutW: 600,
          initialCalloutH: 50,
          fillColor: Colors.white70,
          elevation: 5,
          borderRadius: 10,
          alwaysReCalcSize: true,
          arrowType: ArrowType.NONE,
          draggable: false,
        ),
        calloutContent: Center(
          child: Container(
//width: w,
// decoration: BoxDecoration(
//   color: background,
//   borderRadius: BorderRadius.circular(backgroundRadius),
// ),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Row(
                children: [
                  const CircularProgressIndicator(),
                  Text(reason),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      Callout.dismiss(reason);
    }
  }

  /// given a Rect, returns most appropriate alignment between target and callout within the wrapper
  /// NOTICE does not depend on callout size
  Alignment calcTargetAlignmentWithinWrapper(Rect wrapperRect,
      final Rect targetRect) {
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
    // fca.logi("$x, $y");
    return Alignment(x, y);
  }

  Offset? findGlobalPos(GlobalKey key) {
    BuildContext? cxt = key.currentContext;
    RenderObject? renderObject = cxt?.findRenderObject();
    return (renderObject as RenderBox).localToGlobal(Offset.zero);
  }

  (double, double) ensureOnScreen(Rect calloutRect, double minVisibleH,
      double minVisibleV) {
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

  Alignment calcTargetAlignmentWholeScreen(final Rect targetRect,
      double calloutW, double calloutH) {
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

}

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

  Rect? globalPaintBounds(
      {bool skipWidthConstraintWarning = true, bool skipHeightConstraintWarning = true}) {
    // var cw = currentWidget;
    var cc = currentContext;
    Size? scrSize;
    if (cc == null) {
      //fca.logi('GlobalKeyExtension: currentContext NULL!');
    } else {
      scrSize = MediaQuery.sizeOf(cc);
    }
    final renderObject = cc?.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    Rect? paintBounds;
    try {
      paintBounds = renderObject?.paintBounds;
    } catch (e) {
      fca.logi('paintBounds = renderObject?.paintBounds - ${e.toString()}');
    }
    // possibly warn about the target having an infinite width
    if (!_alreadyGaveGlobalPosAndSizeWarning &&
        !skipWidthConstraintWarning &&
        !skipHeightConstraintWarning &&
        (paintBounds?.width == scrSize!.width ||
            paintBounds?.height == fca.scrH)) {
      _alreadyGaveGlobalPosAndSizeWarning = true;
      fca.showOverlay(
        calloutContent: Column(
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
                Callout.dismissTopFeature();
              },
              child: const Text('Close'),
            ),
          ],
        ),
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