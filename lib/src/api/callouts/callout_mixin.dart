import 'dart:async' show Timer;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_callouts/flutter_callouts.dart';
import 'package:flutter_callouts/src/api/callouts/overlay_entry_list.dart';

mixin CalloutMixin {
  static const int separationAnimationMs = 500;

  // Alignment get alignTopLeft => AlignmentModel(-1.0, -1.0).value;
  //
  // /// The center point along the top edge.
  // Alignment get topCenter => AlignmentModel(0.0, -1.0).value;
  //
  // /// The top right corner.
  // Alignment get topRight => AlignmentModel(1.0, -1.0).value;
  //
  // /// The center point along the left edge.
  // Alignment get centerLeft => AlignmentModel(-1.0, 0.0).value;
  //
  // /// The center point, both horizontally and vertically.
  // Alignment get center => AlignmentModel(0.0, 0.0).value;
  //
  // /// The center point along the right edge.
  // Alignment get centerRight => AlignmentModel(1.0, 0.0).value;
  //
  // /// The bottom left corner.
  // Alignment get bottomLeft => AlignmentModel(-1.0, 1.0).value;
  //
  // /// The center point along the bottom edge.
  // Alignment get bottomCenter => AlignmentModel(0.0, 1.0).value;
  //
  // /// The bottom right corner.
  // Alignment get bottomRight => AlignmentModel(1.0, 1.0).value;

  // assumption: at least 1 build has been executed; after initState
  // #begin
  Future<void> showOverlay({
    // ZoomerState? zoomer, // if callout needs access to the zoomer
    required CalloutConfigModel calloutConfig,
    required Widget calloutContent,
    TargetKeyFunc? targetGkF,
    bool ensureLowestOverlay = false,
    int? removeAfterMs,
    VoidCallback? onReadyF,
    final ValueNotifier<int>? targetChangedNotifier,
    // TargetModel? configurableTarget,
    final skipWidthConstraintWarning = false,
    final skipHeightConstraintWarning = false,
  }) async
  // #end
  {
    if (await fca.alreadyGotit(calloutConfig.cId)) return;

    if (anyPresent([calloutConfig.cId])) return;

    if ((calloutConfig.calloutW ?? 0) < 0) {
      fca.logger.w('negative width ?');
    }

    if (removeAfterMs != null) {
      calloutConfig.removalTimer = Timer(Duration(milliseconds: removeAfterMs), () {
        dismiss(calloutConfig.cId);
      });
    }

    // has a barrier means allow escape to dismiss
    if (calloutConfig.barrier != null) {
      fca.registerKeystrokeHandler(calloutConfig.cId, (k) {
        if (k.logicalKey == LogicalKeyboardKey.escape) {
          fca.dismiss(calloutConfig.cId);
          fca.hide(calloutConfig.cId);
        }
        return false;
      });
    }

    // // get this target's context
    // if (targetGkF != null) {
    //   GlobalKey? gk = targetGkF.call();
    //   var cc = gk?.currentContext;
    //   if (cc == null) {
    //     fca.logger.i(
    //         '${calloutConfig.cId} missing target gk - overlay not shown');
    //     return;
    //   } else {
    //     fca.initWithContext(cc);
    //   }
    // }

    // possibly create the overlay after measuring the callout's content
    if (calloutConfig.initialCalloutW == null || calloutConfig.initialCalloutH == null) {
      fca.measureWidgetRect(context: fca.rootContext, widget: calloutContent).then((rect) {
        calloutConfig.calloutW = rect.width;
        calloutConfig.calloutH = rect.height;
        fca.logger.i('measured content size: ${rect.toString()}');
        _createOverlayDefinitelyHasSize(
          calloutConfig,
          calloutContent,
          // zoomer,
          targetGkF,
          targetChangedNotifier,
          ensureLowestOverlay,
          onReadyF,
        );
      });
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
        onReadyF,
      );
    }

    await Future.delayed(const Duration(milliseconds: 800));
  }

  void _createOverlayDefinitelyHasSize(
    CalloutConfigModel calloutConfig,
    Widget calloutContent,
    // ZoomerState? zoomer,
    TargetKeyFunc? targetGkF,
    ValueNotifier<int>? targetChangedNotifier,
    bool ensureLowestOverlay,
    VoidCallback? onReadyF,
  ) {
    OverlayEntry oEntry = _createOverlay(
      // zoomer,
      calloutConfig,
      calloutContent,
      targetGkF,
      ensureLowestOverlay,
    ); // will be null if target not present
    // if a notifer was passed in, means inside another overlay, so the target would change as the overlay gets moved or resized
    targetChangedNotifier?.addListener(() {
      print("\n\ntime to update the target\n\n");
      fca.afterNextBuildDo(() => oEntry.markNeedsBuild());
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      if (calloutConfig.notToast) {
        // fca.logger.i('_possiblyAnimateSeparation');
        _possiblyAnimateSeparation(calloutConfig, onReadyF);
      } else {
        _possiblyAnimateToastPos(calloutConfig, onReadyF);
      }
    });
  }

  OverlayEntry _createOverlay(
    // ZoomerState? zoomer,
    CalloutConfigModel calloutConfig,
    Widget boxContent,
    TargetKeyFunc? targetGkF,
    bool ensureLowestOverlay,
  ) {
    // in the event that finalSeparation specified, ensure initial callout at zero separation
    double? savedFinalSeparation = calloutConfig.finalSeparation;
    if ((calloutConfig.finalSeparation ?? 0.0) > 0.0) {
      calloutConfig.setSeparation(0.0);
    }

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (BuildContext ctx) {
        // FCA.initWithContext(ctx);
        // fca.logger.i('...');
        // fca.logger.i("${calloutConfig.cId} OverlayEntry.builder...");
        // fca.logger.i('...');
        // if (calloutConfig.cId == 'root'){
        //   fca.logger.i('root');
        // }

        // var scrSize = fca.scrSize;

        // if no target and no initialPos, use scren dimension
        if (calloutConfig.initialCalloutW == null && calloutConfig.initialCalloutH == null && calloutConfig.initialCalloutPos == null) {
          calloutConfig.initialCalloutW = fca.scrW;
          calloutConfig.initialCalloutH = fca.scrH;
        }

        var targetGK = targetGkF?.call();
        var r = targetGK?.globalPaintBounds(
          skipWidthConstraintWarning: calloutConfig.calloutW != null,
          skipHeightConstraintWarning: calloutConfig.calloutH != null,
        );

        if (r == null) {
          // for toast targetgk will be null, and we have to use the gravity to get a rect
          calloutConfig.initialCalloutPos ??= OffsetModel(
            fca.scrW / 2 - calloutConfig.initialCalloutW! / 2,
            fca.scrH / 2 - calloutConfig.initialCalloutH! / 2,
          );
          r = Rect.fromLTWH(
            calloutConfig.initialCalloutPos!.dx,
            calloutConfig.initialCalloutPos!.dy,
            calloutConfig.initialCalloutW!,
            calloutConfig.initialCalloutH!,
          );
          // fca.logger.i('${calloutConfig.cId} failed to measure pos and size from targetGkF - overlay not shown');
          // return const Icon(Icons.warning_amber);
        }
        OE? oeObj = findOE(calloutConfig.cId);
        if ((calloutConfig.calloutW ?? 0) <= 0) {
          fca.logger.i('calloutW:${calloutConfig.calloutW} !!!  (cId:${calloutConfig.cId}');
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
      },
    );
    calloutConfig.finalSeparation = savedFinalSeparation;
    OverlayEntry? lowestOverlay;
    int? pos;
    if (ensureLowestOverlay) {
      final result = lowestEntry();
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
      before: pos,
    );
    return entry;
  }

  Future<void> _possiblyAnimateSeparation(CalloutConfigModel calloutConfig, VoidCallback? onReadyF) async {
    // print('_possiblyAnimateSeparation finalSep: ${calloutConfig.finalSeparation}');
    if ((calloutConfig.finalSeparation ?? 0.0) > 0.0) {
      // animate separation, top or left
      AnimationController animationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: calloutConfig);
      Tween<double> tween = Tween<double>(begin: 0.0, end: calloutConfig.finalSeparation);
      Animation<double> animation = tween.animate(CurvedAnimation(parent: animationController, curve: Curves.bounceOut));
      animation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          calloutConfig.finishedAnimatingSeparation();
          animationController.dispose();
        }
      });
      animation.addListener(() {
        fca.logger.i('new separation: ${animation.value}');
        calloutConfig.setSeparation(animation.value);
      });
      calloutConfig.startedAnimatingSeparation();
      animationController.reset();
      animationController.forward(from: 0.0).then((value) => onReadyF?.call());
    }
  }

  bool _sameType<T1, T2>() => T1 == T2;

  void showToastOverlay({required CalloutConfigModel calloutConfig, required Widget calloutContent, int removeAfterMs = 0}) {
    assert(calloutConfig.gravity != null && calloutConfig.initialCalloutW != null && calloutConfig.initialCalloutH != null);

    CalloutConfigModel toastCC = calloutConfig.cloneWith(
      cId: calloutConfig.cId,
      scrollControllerName: calloutConfig.scrollControllerName,
      initialTargetAlignment: null,
      initialCalloutAlignment: null,
      gravity: calloutConfig.gravity,
      initialCalloutPos: OffsetModel.fromOffset(
        _initialOffsetFromGravity(calloutConfig.gravity!.flutterValue, calloutConfig.initialCalloutW!, calloutConfig.initialCalloutH!),
      ),
      arrowType: ArrowTypeEnum.NONE,
      decorationShape: DecorationShapeEnum.rectangle,
      // draggable: false,
      skipOnScreenCheck: true,
      allowScrolling: calloutConfig.followScroll,
    );
    if (removeAfterMs > 0) {
      Future.delayed(Duration(milliseconds: removeAfterMs), () {
        dismiss(toastCC.cId);
      });
    }
    showOverlay(calloutConfig: toastCC, calloutContent: calloutContent);
  }

  void showToast({
    required CalloutId cId,
    required String msg,
    Color? bgColor,
    Color? textColor,
    AlignmentEnum gravity = AlignmentEnum.topCenter,
    bool showCPI = false,
    bool onlyOnce = false,
    int removeAfterMs = 0,
    double? width,
    double? height,
  }) {
    var cc = CalloutConfigModel(
      cId: cId,
      gravity: gravity,
      fillColor: ColorModel.fromColor(bgColor??Colors.white),
      initialCalloutW: width ?? fca.scrW * .8,
      initialCalloutH: height ?? 40,
      scrollControllerName: null,
      showcpi: showCPI,
      onlyOnce: onlyOnce,
    );

    showToastOverlay(
      calloutConfig: cc,
      calloutContent: Center(child: fca.coloredText(msg, color: textColor??Colors.black)),
      removeAfterMs: removeAfterMs,
    );
  }

  void showToastBlueOnYellow({required CalloutId cId, required String msg, bool showCPI = false, int removeAfterMs = 0}) =>
      showToast(cId: cId, msg: msg, bgColor: Colors.yellow, textColor: Colors.black, showCPI: showCPI, removeAfterMs: removeAfterMs);

  void showToastPurpleOnLightWhite({required CalloutId cId, required String msg, int removeAfterMs = 0, double? widthPC}) {
    var cc = CalloutConfigModel(
      cId: cId,
      gravity: AlignmentEnum.topCenter,
      fillColor: ColorModel.white(),
      initialCalloutW: widthPC == null ? fca.scrW * .8 : fca.scrW * widthPC / 100,
      initialCalloutH: 80,
      scrollControllerName: null,
    );

    showToastOverlay(
      calloutConfig: cc,
      calloutContent: Center(
        child: fca.coloredText(msg, fontSize: 16, fontWeight: FontWeight.bold, color: Colors.purple),
      ),
      removeAfterMs: removeAfterMs,
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
      initialOffset = Offset(fca.scrW / 2 - w / 2 - 10, fca.scrH / 2 - h / 2 - 10);
    } else if (alignment == Alignment.centerLeft) {
      initialOffset = Offset(-w, fca.scrH / 2 - h / 2);
    } else if (alignment == Alignment.centerRight) {
      initialOffset = Offset(fca.scrW, fca.scrH / 2 - h / 2);
    } else {
      initialOffset = Offset(fca.scrW / 2 - w / 2 - 10, fca.scrH / 2 - h / 2 - 10);
    }
    return initialOffset;
  }

  Offset _finalOffsetFromGravity(Alignment alignment, double w, double h) {
    late Offset initialOffset;
    if (alignment == Alignment.topCenter) {
      initialOffset = Offset((fca.scrW - w) / 2, 10);
    } else if (alignment == Alignment.topLeft) {
      initialOffset = const Offset(10, 10);
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

  Future<void> _possiblyAnimateToastPos(CalloutConfigModel toastCC, VoidCallback? onReadyF) async {
    if (toastCC.left != null && toastCC.top != null) {
      Offset initialPos = Offset(toastCC.left!, toastCC.top!);
      Offset finalPos = _finalOffsetFromGravity(toastCC.gravity!.flutterValue, toastCC.calloutW!, toastCC.calloutH!);
      // animate pos from offscreen
      AnimationController animationController = AnimationController(
        duration: const Duration(milliseconds: separationAnimationMs),
        vsync: toastCC,
      );
      Tween<Offset> tween = Tween<Offset>(begin: initialPos, end: finalPos);
      Animation<Offset> animation = tween.animate(CurvedAnimation(parent: animationController, curve: Curves.bounceOut));
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
      animationController.forward(from: 0.0).then((value) => onReadyF?.call());
    }
  }

    void showCircularProgressIndicator(bool show,
        {ScrollControllerName? scName, required String reason}) {
  // if (width != null && height == null) height = 60;
      BuildContext? cachedContext = fca.rootContext;
      if (show && (cachedContext.mounted)) {
        showOverlay(
          calloutConfig: CalloutConfigModel(
            cId: reason,
            gravity: AlignmentEnum.topCenter,
            // scale: 1.0,
            initialCalloutW: 600,
            initialCalloutH: 50,
            fillColor: ColorModel.fromColor(Colors.white70),
            elevation: 5,
            borderRadius: 10,
            alwaysReCalcSize: true,
            arrowType: ArrowTypeEnum.NONE,
            draggable: false,
            scrollControllerName: scName,
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
        dismiss(reason);
      }
    }

  /// given a Rect, returns most appropriate alignment between target and callout within the wrapper
  /// NOTICE does not depend on callout size
  Alignment calcTargetAlignmentWithinWrapper({Rect? wrapperRect, required Rect targetRect}) {
    // Rect? wrapperRect = findGlobalRect(widget.key as GlobalKey);

    Rect screenRect = Rect.fromLTWH(0, 0, fca.scrW, fca.scrH);
    // if (wrapperRect == null) {
    //   wrapperRect = screenRect;
    // }
    wrapperRect = screenRect;

    // final cutoutPadding = 30.0;
    // final scaleTarget = 1.71;
    // double scaledAndPaddedW = scaleTarget * (targetRect.width + cutoutPadding*2);
    // double scaledAndPaddedH = scaleTarget * (targetRect.height + cutoutPadding*2);
    // Rect scaledTr = Rect.fromLTWH(
    //   targetRect.left - (scaledAndPaddedW - targetRect.width)/2,
    //   targetRect.top - (scaledAndPaddedH - targetRect.height)/2,
    //   scaledAndPaddedW,
    //   scaledAndPaddedH,
    // );

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
    // fca.logger.i("$x, $y");
    return Alignment(x, y);
  }

  Offset? findGlobalPos(GlobalKey key) {
    BuildContext? cxt = key.currentContext;
    RenderObject? renderObject = cxt?.findRenderObject();
    return (renderObject as RenderBox).localToGlobal(Offset.zero);
  }

  (double, double) ensureOnScreen(Rect calloutRect, double minVisibleH, double minVisibleV) {
    double resultLeft = calloutRect.left;
    double resultTop = calloutRect.top;
    // adjust s.t entirely visible
    if (calloutRect.left > (fca.scrW - minVisibleH)) {
      resultLeft = fca.scrW - minVisibleH;
    }
    if (calloutRect.top > (fca.scrH - minVisibleV - fca.kbdH)) {
      resultTop = fca.scrH - minVisibleV - fca.kbdH;
    }
    if (calloutRect.right < minVisibleH) {
      resultLeft = minVisibleH - calloutRect.width;
    }
    if (calloutRect.bottom < minVisibleV) {
      resultTop = minVisibleV - calloutRect.height;
    }

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

  Alignment calcTargetAlignmentWholeScreen(final Rect targetRect, double calloutW, double calloutH) {
    Rect screenRect = Rect.fromLTWH(0, 0, fca.scrW, fca.scrH);
    double T = targetRect.top;
    double L = targetRect.left;
    double B = screenRect.height - targetRect.bottom;
    double R = screenRect.width - targetRect.right;
    double spareAbove = T - calloutH;
    double spareBelow = B - calloutH;
    double spareOnLeft = L - calloutW;
    double spareOnRight = R - calloutW;
    double maxSpare = [spareAbove, spareBelow, spareOnLeft, spareOnRight].reduce(max);
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

  //------------------
  //---  static  -----
  //------------------
  OE? findOE(CalloutId cId) {
    for (OE oe in OE.list) {
      if (oe.calloutConfig.cId == cId) {
        return oe;
      }
    }
    return null;
  }

  CalloutConfigModel? getCalloutConfig(CalloutId feature) {
    OE? oe = findOE(feature);
    if (oe != null) return oe.calloutConfig;
    return null;
  }

  void rebuild(CalloutId feature, {VoidCallback? f}) {
    findOE(feature)?.calloutConfig.rebuild(f);
  }

  T? findCallout<T>(String cId) {
    if (_sameType<T, OverlayEntry>()) {
      OverlayEntry? entry = findOE(cId)?.entry;
      return entry as T?;
    }
    if (_sameType<T, OverlayPortalController>()) {
      OverlayPortalController? entry = findOE(cId)?.opC;
      return entry as T?;
    }
    return null;
  }

  BuildContext? findCalloutCallerContext(String cId) {
    var oe = findOE(cId);
    var callerGK = oe?.calloutConfig.callerGK;
    return callerGK?.currentContext;
  }

  State? findCalloutCallerState(String cId) {
    var oe = findOE(cId);
    var callerGK = oe?.calloutConfig.callerGK;
    return callerGK?.currentState;
  }

  Widget? findCalloutCallerWidget(String cId) {
    var oe = findOE(cId);
    var callerGK = oe?.calloutConfig.callerGK;
    return callerGK?.currentWidget;
  }

  void dismissAll({List<CalloutId> exceptFeatures = const [], bool onlyToasts = false, bool exceptToasts = false}) {
    fca.logger.d("dismissAll");
    List<CalloutId> overlays2bRemoved = [];
    for (OE oe in OE.list) {
      // if (oe.entry != null) {
      bool isToast = oe.calloutConfig.gravity != null;
      if ((onlyToasts && isToast) || (exceptToasts && !isToast) || (!onlyToasts && !exceptToasts)) {
        overlays2bRemoved.add(oe.calloutConfig.cId);
      }
      // }
    }
    for (CalloutId cId in overlays2bRemoved) {
      if (!exceptFeatures.contains(cId)) dismiss(cId);
    }
  }

  void dismiss(String cId, {bool skipOnDismiss = false}) {
    OE? oeObj = findOE(cId);
    if (oeObj != null) {
      try {
        oeObj
          ..isHidden = true
          ..opC?.hide()
          ..entry?.remove();
      } catch (e) {}
      OE.deRegisterOE(oeObj, skipOnDismiss: skipOnDismiss);
    }
  }

  (int? i, OverlayEntry?) lowestEntry() {
    if (OE.list.isNotEmpty) {
      for (int i = 0; i < OE.list.length; i++) {
        if (OE.list[i].entry != null) {
          return (i, OE.list[i].entry);
        }
      }
    }
    return (null, null);
  }

  // void bringToTop(String cId) {
  //   return;
  //   OE? oeObjToMove = findOE(cId);
  //   OverlayEntry? entryToMove = oeObjToMove?.entry;
  //   if (entryToMove == null) return;
  //   final topMostEntry = _nonPortalList().last.entry;
  //   entryToMove.remove();
  //   OverlayState? os = Overlay.maybeOf(fca.rootContext);
  //   os?.insert(entryToMove!, above: topMostEntry);
  //   os?.setState((){});
  //   OE.list.remove(oeObjToMove);
  //   OE.list.add(oeObjToMove!);
  // }

  // List<OE> _nonPortalList() => OE.list.where((oe) => oe.opC == null).toList();

  void dismissTopFeature() {
    if (OE.list.isNotEmpty) {
      OE topOE = OE.list.last;
      dismiss(topOE.calloutConfig.cId);
    }
  }

  CalloutConfigModel? findParentCalloutConfig(context) {
    return context.findAncestorWidgetOfExactType<PositionedBoxContent>()?.calloutConfig;
  }

  // unhide OpenPortal overlay
  void unhideParentCallout(BuildContext context, {bool animateSeparation = false, int hideAfterMs = 0}) {
    var op = context.findAncestorWidgetOfExactType<OverlayPortal>();
    if (op != null) {
      // find its cc
      for (OE oe in OE.list) {
        if (oe.opC == op.controller) {
          CalloutConfigModel cc = oe.calloutConfig;
          unhide(cc.cId);
        }
      }
    }

    CalloutConfigModel? config = findParentCalloutConfig(context);
    if (config != null) {
      unhide(config.cId);
    } else {
      WrappedCalloutState? c = WrappedCallout.of(context);
      c?.unhide(animateSeparation: animateSeparation, hideAfterMs: hideAfterMs);
    }
  }

  void hideParentCallout(context) {
    CalloutConfigModel? config = findParentCalloutConfig(context);
    if (config != null) {
      hide(config.cId);
    }
  }

  void removeParentCallout(context) {
    CalloutConfigModel? config = findParentCalloutConfig(context);
    if (config != null) {
      dismiss(config.cId);
    }
  }

  bool isHidden(String cId) => findOE(cId)?.isHidden ?? false;

  void hide(String cId) {
    OE? oeObj = findOE(cId);
    if (oeObj != null /*  && !oeObj.isHidden*/ ) {
      oeObj
        ..isHidden = true
        ..opC?.hide()
        ..entry?.markNeedsBuild();
      // OE.debug();
    }
  }

  void zeroHeight(String cId) {
    OE? oeObj = findOE(cId);
    if (oeObj != null /*  && !oeObj.isHidden*/ ) {
      oeObj.savedHeight = oeObj.calloutConfig.calloutH = 0;
      oeObj.entry?.markNeedsBuild();
    }
  }

  void restoreHeight(String cId) {
    OE? oeObj = findOE(cId);
    if (oeObj != null /*  && !oeObj.isHidden*/ ) {
      oeObj.calloutConfig.calloutH = oeObj.savedHeight;
      oeObj.entry?.markNeedsBuild();
    }
  }

  void unhide(String cId) {
    OE? oe = findOE(cId);
    if (oe != null /*&& oe.isHidden*/ ) {
      oe
        ..isHidden = false
        ..opC?.show()
        ..entry?.markNeedsBuild();
      // OE.debug();
    }
  }

  void refresh(String cId, {VoidCallback? f}) {
    f?.call();
    findCallout<OverlayEntry>(cId)?.markNeedsBuild();
  }

  void refreshAll({VoidCallback? f}) {
    f?.call();
    for (OE oe in OE.list) {
      if (!oe.isHidden && oe.entry != null) {
        oe.calloutConfig.calcEndpoints();
        // oe.calloutConfig.refreshAlignment();
        fca.logger.i('after calcEndpoints: tR is ${oe.calloutConfig.tR().toString()}');
        oe.entry?.markNeedsBuild();
      }
      // if (!oe.isHidden && oe.opC != null) {
      //   oe.opC?.show();
      // }
    }
  }

  bool anyPresent(List<CalloutId> cIds, {bool includeHidden = false}) {
    bool result = false;
    if (cIds.isEmpty) {
      result = false;
    } else {
      for (OE oe in OE.list) {
        if ((!oe.isHidden || includeHidden) && cIds.contains(oe.calloutConfig.cId)) {
          result = true;
        }
      }
    }
    return result;
  }

  void preventParentCalloutDrag(BuildContext ctx) {
    PositionedBoxContent? parent = ctx.findAncestorWidgetOfExactType<PositionedBoxContent>();
    if (parent != null) {
      parent.calloutConfig.preventDrag = true;
    }
  }

  void allowParentCalloutDrag(BuildContext ctx) {
    PositionedBoxContent? parent = ctx.findAncestorWidgetOfExactType<PositionedBoxContent>();
    if (parent != null) {
      // delay to allow _onContentPointerUp to do its thing
      fca.afterMsDelayDo(300, () {
        parent.calloutConfig.preventDrag = false;
      });
    }
  }
}

// extension ExtendedOffset on Offset {
//   String toFlooredString() {
//     return '(${dx.floor()}, ${dy.floor()})';
//   }
// }
