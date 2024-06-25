import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

import 'overlay_entry_list.dart';

export 'arrow_type.dart';
export "rectangle.dart";
export "side.dart";

class Callout {
  Callout._(); // Private constructor

  static void showOverlay({
    ZoomerState? zoomer, // if callout needs access to the zoomer
    required CalloutConfig calloutConfig,
    required WidgetBuilder boxContentF,
    TargetKeyFunc? targetGkF,
    bool ensureLowestOverlay = false,
    int? removeAfterMs,
    final ValueNotifier<int>? targetChangedNotifier,
    // TargetModel? configurableTarget,
    final ScrollController? hScrollController,
    final ScrollController? vScrollController,
    final skipWidthConstraintWarning = false,
    final skipHeightConstraintWarning = false,
  }) {
    if (Callout.anyPresent([calloutConfig.feature])) return;

    if ((calloutConfig.calloutW ?? 0) < 0) {
      print('tbd');
    }
    // if (targetGkF != null) {
    //   GlobalKey? gk = targetGkF.call();
    //   // var cs = gk?.currentState;
    //   // var cw = gk?.currentWidget;
    //   var cc = gk?.currentContext;
    //   // if (cc == null) {
    //   //   debugPrint(
    //   //       '${calloutConfig.feature} missing target gk - overlay not shown');
    //   //   return;
    //   // }
    // }

    // target's GlobalKey supplied
    if (removeAfterMs != null) {
      Future.delayed(Duration(milliseconds: removeAfterMs), () {
        // calloutConfig.onDismissedF?.call();
        dismiss(calloutConfig.feature);
      });
    }

    late OverlayEntry oEntry; // will be null if target not present
    calloutConfig.calloutW = calloutConfig.suppliedCalloutW;

    calloutConfig.calloutH = calloutConfig.suppliedCalloutH;

    // possibly create the overlay after measuring the callout's content
    if (calloutConfig.suppliedCalloutW == null ||
        calloutConfig.suppliedCalloutH == null) {
      FCallouts().afterNextBuildMeasureThenDo(
          skipWidthConstraintWarning: calloutConfig.calloutW != null,
          skipHeightConstraintWarning: calloutConfig.calloutH != null,
          (mctx) => boxContentF(mctx), (Size size) {
        calloutConfig.calloutW ??= size.width;
        calloutConfig.calloutH ??= size.height;
        oEntry = _createOverlay(
          zoomer,
          calloutConfig,
          boxContentF,
          targetGkF,
          ensureLowestOverlay,
        );
      });
    } else {
      oEntry = _createOverlay(
        zoomer,
        calloutConfig,
        boxContentF,
        targetGkF,
        ensureLowestOverlay,
      );
    }
    // if a notifer was passed in, means inside another overlay, so the target would change as the overlay gets moved or resized
    targetChangedNotifier?.addListener(() {
      // debugPrint("\n\ntime to update the target\n\n");
      FCallouts().afterNextBuildDo(() => oEntry.markNeedsBuild());
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      debugPrint('_possiblyAnimateSeparation');
      _possiblyAnimateSeparation(calloutConfig, oEntry);
    });
  }

  static OverlayEntry _createOverlay(
    ZoomerState? zoomer,
    CalloutConfig calloutConfig,
    WidgetBuilder boxContentF,
    TargetKeyFunc? targetGkF,
    bool ensureLowestOverlay,
  ) {
    late OverlayEntry entry;
    entry = OverlayEntry(builder: (BuildContext ctx) {
      debugPrint('...');
      debugPrint("${calloutConfig.feature} OverlayEntry.builder...");
      debugPrint('...');
// if (calloutConfig.feature == 'root'){
//   debugPrint('root');
// }

      Rect? r = targetGkF?.call()?.globalPaintBounds(
          skipWidthConstraintWarning: calloutConfig.calloutW != null,
          skipHeightConstraintWarning: calloutConfig.calloutH != null);
      if (r == null) {
// for toast targetgk will be null, and we have to use the gravity to get a rect
        calloutConfig.initialCalloutPos ??= Offset(
          FCallouts().scrW / 2 - calloutConfig.suppliedCalloutW! / 2,
          FCallouts().scrH / 2 - calloutConfig.suppliedCalloutH! / 2,
        );
        r = Rect.fromLTWH(
          calloutConfig.initialCalloutPos!.dx,
          calloutConfig.initialCalloutPos!.dy,
          calloutConfig.suppliedCalloutW!,
          calloutConfig.suppliedCalloutH!,
        );
// debugPrint('${calloutConfig.feature} failed to measure pos and size from targetGkF - overlay not shown');
// return const Icon(Icons.warning_amber);
      }
      OE? oeObj = findOE(calloutConfig.feature);
      if ((calloutConfig.calloutW ?? 0) <= 0) {
        debugPrint(
            'calloutW:${calloutConfig.calloutW} !!!  (feature:${calloutConfig.feature}');
      }
      return Visibility(
        visible: oeObj == null || !oeObj.isHidden,
        child: calloutConfig.oeContentWidget(
// zoomer: zoomer,
          targetRect: r,
          calloutContent: (_) => boxContentF(_),
          rebuildF: () {
            entry.markNeedsBuild();
          },
        ),
      );
    });
    OverlayEntry? lowestOverlay;
    int? pos;
    if (ensureLowestOverlay) {
      final result = lowestEntry();
      pos = result.$1;
      lowestOverlay = result.$2;
    }

    Overlay.of(FCallouts().rootContext!).insert(entry, below: lowestOverlay);

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

  static Future<void> _possiblyAnimateSeparation(
      CalloutConfig calloutConfig, OverlayEntry oEntry) async {
    if (calloutConfig.finalSeparation > 0.0 && calloutConfig.vsync != null) {
// animate separation, top or left
      AnimationController animationController = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: calloutConfig.vsync!,
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
        debugPrint('new separation: ${animation.value}');
        calloutConfig.setSeparation(
            animation.value, () => oEntry.markNeedsBuild());
      });
      calloutConfig.startedAnimatingSeparation();
      animationController.forward(from: 0.0);
    }
  }

  static OE? findOE(Feature feature) {
    for (OE oe in OE.list) {
      if (oe.calloutConfig.feature == feature) {
        return oe;
      }
    }
    return null;
  }

  static bool _sameType<T1, T2>() => T1 == T2;

  static T? findCallout<T>(String feature) {
    if (_sameType<T, OverlayEntry>()) {
      OverlayEntry? entry = findOE(feature)?.entry;
      return entry as T?;
    }
    if (_sameType<T, OverlayPortalController>()) {
      OverlayPortalController? entry = findOE(feature)?.opC;
      return entry as T?;
    }
    return null;
  }

  static void dismissAll(
      {List<Feature> exceptFeatures = const [],
      bool onlyToasts = false,
      bool exceptToasts = false}) {
    List<Feature> overlays2bRemoved = [];
    for (OE oe in OE.list) {
// if (oe.entry != null) {
      bool isToast = oe.calloutConfig.gravity != null;
      if ((onlyToasts && isToast) ||
          (exceptToasts && !isToast) ||
          (!onlyToasts && !exceptToasts)) {
        overlays2bRemoved.add(oe.calloutConfig.feature);
      }
// }
    }
    for (Feature feature in overlays2bRemoved) {
      if (!exceptFeatures.contains(feature)) dismiss(feature);
    }
  }

  static void dismiss(String feature) {
// debugPrint('-- dismiss -----------------------------------');
// for (OE oe in OE.list) {
//   debugPrint(oe.calloutConfig.feature);
// }

    OE? oeObj = findOE(feature);
    if (oeObj != null) {
      oeObj
        ..isHidden = true
        ..opC?.hide()
        ..entry?.remove();
      OE.deRegisterOE(oeObj);
      debugPrint(
          '-- dismissed $feature ${oeObj.opC != null ? "*" : ""} ---------------------------');
    }
  }

  static (int? i, OverlayEntry?) lowestEntry() {
    if (OE.list.isNotEmpty) {
      for (int i = 0; i < OE.list.length; i++) {
        if (OE.list[i].entry != null) {
          return (i, OE.list[i].entry);
        }
      }
    }
    return (null, null);
  }

  static void dismissTopFeature() {
    if (OE.list.isNotEmpty) {
      OE topOE = OE.list.last;
      dismiss(topOE.calloutConfig.feature);
    }
  }

  static CalloutConfig? findParentCalloutConfig(context) => context
      .findAncestorWidgetOfExactType<PositionedBoxContent>()
      ?.calloutConfig;

// unhide OpenPortal overlay
  static void unhideParentCallout(BuildContext context,
      {bool animateSeparation = false, int hideAfterMs = 0}) {
    CalloutConfig? config = findParentCalloutConfig(context);
    if (config != null) {
      unhide(config.feature);
    } else {
      WrappedCalloutState? c = WrappedCallout.of(context);
      c?.unhide(animateSeparation: animateSeparation, hideAfterMs: hideAfterMs);
    }
  }

  static void hideParentCallout(context) {
    CalloutConfig? config = findParentCalloutConfig(context);
    if (config != null) {
      hide(config.feature);
    }
  }

  static void removeParentCallout(context) {
    CalloutConfig? config = findParentCalloutConfig(context);
    if (config != null) {
      dismiss(config.feature);
    }
  }

  static void showTextToast({
    required feature,
    required String msgText,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    double textScaleFactor = 1,
    Alignment gravity = Alignment.topCenter,
    double width = 600,
    double height = 30,
    VoidCallback? onDiscardedF,
    VoidCallback? onAcceptedF,
// bool? gotitAxis,,
// VoidCallback? onGotitPressedF,
    bool onlyOnce = false,
    double elevation = 6,
    bool showcpi = false,
    double roundedCorners = 10,
    int removeAfterMs = 2000,
  }) {
// if (width != null && height == null) height = 60;

    if (removeAfterMs > 0) {
      Future.delayed(Duration(milliseconds: removeAfterMs), () {
        dismiss(feature);
      });
    }
    showOverlay(
      calloutConfig: CalloutConfig(
        feature: feature,
        gravity: gravity,
        scale: 1.0,
        suppliedCalloutW: width,
        suppliedCalloutH: height,
        fillColor: backgroundColor,
        elevation: elevation,
        modal: false,
        noBorder: true,
        animate: true,
        borderRadius: 10,
        alwaysReCalcSize: true,
        arrowType: ArrowType.NO_CONNECTOR,
        draggable: false,
        onDismissedF: onDiscardedF,
        initialCalloutPos: _initialOffsetFromGravity(gravity, width, height),
        onlyOnce: onlyOnce,
        showcpi: showcpi,
      ),
      boxContentF: (cachedContext) => ConstrainedBox(
        constraints: BoxConstraints(maxWidth: width),
        child: Center(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: 32, minWidth: FCallouts().scrW * .8),
            child: Container(
//width: w,
// decoration: BoxDecoration(
//   color: background,
//   borderRadius: BorderRadius.circular(backgroundRadius),
// ),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  msgText,
                  softWrap: true,
                  textScaler: TextScaler.linear(textScaleFactor),
                  style: TextStyle(fontSize: 24, color: textColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void showWidgetToast({
    required Feature feature,
    required WidgetBuilder contents,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    double textScaleFactor = 1,
    Alignment gravity = Alignment.topCenter,
    double width = 600,
    double height = 30,
    VoidCallback? onDiscardedF,
    VoidCallback? onAcceptedF,
// bool? gotitAxis,
// VoidCallback? onGotitPressedF,
    bool onlyOnce = false,
    double elevation = 6,
    bool showcpi = false,
    double roundedCorners = 10,
    int removeAfterMs = 2000,
  }) {
    Callout.dismiss(feature);

    if (removeAfterMs > 0) {
      Future.delayed(Duration(milliseconds: removeAfterMs), () {
        dismiss(feature);
      });
    }
    showOverlay(
      calloutConfig: CalloutConfig(
        feature: feature,
        gravity: gravity,
        scale: 1.0,
        suppliedCalloutW: width,
        suppliedCalloutH: height,
        fillColor: backgroundColor,
        elevation: elevation,
        modal: false,
        noBorder: true,
        animate: true,
        borderRadius: 10,
        alwaysReCalcSize: true,
        arrowType: ArrowType.NO_CONNECTOR,
        draggable: false,
        onDismissedF: onDiscardedF,
        onAcceptedF: onAcceptedF,
        initialCalloutPos: _initialOffsetFromGravity(gravity, width, height),
        onlyOnce: onlyOnce,
        showcpi: showcpi,
        // contentTranslateY: -height,
      ),
      boxContentF: (cachedContext) => Center(child: contents(cachedContext)),
    );
  }

  static Offset _initialOffsetFromGravity(
      Alignment alignment, double w, double h) {
    late Offset initialOffset;
    if (alignment == Alignment.topCenter) {
      initialOffset = Offset((FCallouts().scrW - w) / 2, 0);
    } else if (alignment == Alignment.topRight) {
      initialOffset = Offset(FCallouts().scrW - w - 10, 10);
    } else if (alignment == Alignment.bottomCenter) {
      initialOffset = Offset((FCallouts().scrW - w) / 2, FCallouts().scrH - h);
    } else if (alignment == Alignment.bottomRight) {
      initialOffset =
          Offset(FCallouts().scrW - w - 10, FCallouts().scrH - h - 10);
    } else if (alignment == Alignment.center) {
      initialOffset = Offset(
          FCallouts().scrW / 2 - w / 2 - 10, FCallouts().scrH / 2 - h / 2 - 10);
    } else {
      initialOffset =
          Offset(FCallouts().scrW - -10, FCallouts().scrH / 2 - h / 2 - 10);
    }
// debugPrint('initialOffset (${initialOffset.dx}, ${initialOffset.dy}), and Useful.screenW is ${Useful.scrW} and screenH is ${Useful.scrH}');
    return initialOffset;
  }

  static void showCircularProgressIndicator(bool show,
      {required String reason}) {
// if (width != null && height == null) height = 60;
    BuildContext? cachedContext = FCallouts().rootContext;
    if (show && (cachedContext?.mounted ?? false)) {
      showOverlay(
        calloutConfig: CalloutConfig(
          feature: reason,
          gravity: Alignment.topCenter,
          scale: 1.0,
          suppliedCalloutW: 600,
          suppliedCalloutH: 50,
          fillColor: Colors.black,
          elevation: 5,
          borderRadius: 10,
          alwaysReCalcSize: true,
          arrowType: ArrowType.NO_CONNECTOR,
          draggable: false,
        ),
        boxContentF: (cachedContext) => Center(
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
    }
  }

  static bool isHidden(String feature) => findOE(feature)?.isHidden ?? false;

  static void hide(String feature) {
    OE? oeObj = findOE(feature);
    if (oeObj != null && !oeObj.isHidden) {
      oeObj
        ..isHidden = true
        ..opC?.hide()
        ..entry?.markNeedsBuild();
      OE.debug();
    }
  }

// static bool isOverlayOrOPHidden(String feature) =>
//     findOE(feature)?.isHidden ?? false;
//
// static void hide(String feature) {
//   OE? oeObj = findOE(feature);
//   if (oeObj != null && !oeObj.isHidden) {
//     oeObj
//       ..isHidden = true
//       ..opC?.hide()
//       ..entry?.markNeedsBuild();
//     OE.debug();
//   }
// }

  static void unhide(String feature) {
    OE? oe = findOE(feature);
    if (oe != null && oe.isHidden) {
      oe
        ..isHidden = false
        ..opC?.show()
        ..entry?.markNeedsBuild();
      OE.debug();
    }
  }

  static void refresh(String feature, {VoidCallback? f}) {
    f?.call();
    Callout.findCallout<OverlayEntry>(feature)?.markNeedsBuild();
  }

  static void refreshAll({VoidCallback? f}) {
    f?.call();
    for (OE oe in OE.list) {
      if (!oe.isHidden) {
        oe.entry?.markNeedsBuild();
        oe.opC?.show();
      }
    }
  }

  static bool anyPresent(List<Feature> features, {bool includeHidden = false}) {
    if (features.isEmpty) {
      return false;
    } else {
      for (OE oe in OE.list) {
        if ((!oe.isHidden || includeHidden) &&
            features.contains(oe.calloutConfig.feature)) {
          return true;
        }
      }
    }
    return false;
  }

  static void preventParentCalloutDrag(BuildContext ctx) {
    PositionedBoxContent? parent =
        ctx.findAncestorWidgetOfExactType<PositionedBoxContent>();
    if (parent != null) {
      parent.calloutConfig.preventDrag = true;
    }
  }

  static void allowParentCalloutDrag(BuildContext ctx) {
    PositionedBoxContent? parent =
        ctx.findAncestorWidgetOfExactType<PositionedBoxContent>();
    if (parent != null) {
// delay to allow _onContentPointerUp to do its thing
      FCallouts().afterMsDelayDo(300, () {
        parent.calloutConfig.preventDrag = false;
      });
    }
  }
}
