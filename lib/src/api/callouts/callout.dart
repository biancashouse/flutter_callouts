import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

import 'overlay_entry_list.dart';

export 'arrow_type.dart';
export "rectangle.dart";
export "side.dart";

class Callout {
  Callout._(); // Private constructor

  // assumption: at least 1 build has been executed; after initState
  // #begin
  static void showOverlay({
    ZoomerState? zoomer, // if callout needs access to the zoomer
    required CalloutConfig calloutConfig,
    required WidgetBuilder calloutContentF,
    TargetKeyFunc? targetGkF,
    bool ensureLowestOverlay = false,
    int? removeAfterMs,
    final ValueNotifier<int>? targetChangedNotifier,
    // TargetModel? configurableTarget,
    final skipWidthConstraintWarning = false,
    final skipHeightConstraintWarning = false,
  })
  // #end
  {
    if (Callout.anyPresent([calloutConfig.cId])) return;

    if ((calloutConfig.calloutW ?? 0) < 0) {
      print('tbd');
    }

    // scroll awareness
    if (calloutConfig.hScrollController != null) {
      fca.registerScrollController(calloutConfig.hScrollController!);
    }
    if (calloutConfig.vScrollController != null) {
      fca.registerScrollController(calloutConfig.vScrollController!);
    }

    // target's GlobalKey supplied
    if (removeAfterMs != null) {
      Future.delayed(Duration(milliseconds: removeAfterMs), () {
        // calloutConfig.onDismissedF?.call();
        dismiss(calloutConfig.cId);
      });
    }

    // get this target's context
    if (targetGkF != null) {
      GlobalKey? gk = targetGkF.call();
      var cc = gk?.currentContext;
      if (cc == null) {
        debugPrint(
            '${calloutConfig.cId} missing target gk - overlay not shown');
        return;
      } else {
        fca.initWithContext(cc);
      }
    }

    late OverlayEntry oEntry; // will be null if target not present
    calloutConfig.calloutW = calloutConfig.initialCalloutW;

    calloutConfig.calloutH = calloutConfig.initialCalloutH;

    // possibly create the overlay after measuring the callout's content
    if (calloutConfig.initialCalloutW == null ||
        calloutConfig.initialCalloutH == null) {
      fca.afterNextBuildMeasureThenDo(
          skipWidthConstraintWarning: calloutConfig.calloutW != null,
          skipHeightConstraintWarning: calloutConfig.calloutH != null,
          (mctx) => calloutContentF(mctx), (Size size) {
        calloutConfig.calloutW ??= size.width;
        calloutConfig.calloutH ??= size.height;
        oEntry = _createOverlay(
          zoomer,
          calloutConfig,
          calloutContentF,
          targetGkF,
          ensureLowestOverlay,
        );
        // if a notifer was passed in, means inside another overlay, so the target would change as the overlay gets moved or resized
        targetChangedNotifier?.addListener(() {
          // debugPrint("\n\ntime to update the target\n\n");
          fca.afterNextBuildDo(() => oEntry.markNeedsBuild());
        });
        Future.delayed(const Duration(milliseconds: 300), () {
          debugPrint('_possiblyAnimateSeparation');
          _possiblyAnimateSeparation(calloutConfig);
        });
      });
    } else {
      oEntry = _createOverlay(
        zoomer,
        calloutConfig,
        calloutContentF,
        targetGkF,
        ensureLowestOverlay,
      );
      // if a notifer was passed in, means inside another overlay, so the target would change as the overlay gets moved or resized
      targetChangedNotifier?.addListener(() {
        // debugPrint("\n\ntime to update the target\n\n");
        fca.afterNextBuildDo(() => oEntry.markNeedsBuild());
      });
      Future.delayed(const Duration(milliseconds: 300), () {
        if (calloutConfig.notToast) {
          debugPrint('_possiblyAnimateSeparation');
          _possiblyAnimateSeparation(calloutConfig);
        } else {
          _possiblyAnimateToastPos(calloutConfig);
        }
      });
    }
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
      // FCA.initWithContext(ctx);
      debugPrint('...');
      debugPrint("${calloutConfig.cId} OverlayEntry.builder...");
      debugPrint('...');
// if (calloutConfig.cId == 'root'){
//   debugPrint('root');
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
// debugPrint('${calloutConfig.cId} failed to measure pos and size from targetGkF - overlay not shown');
// return const Icon(Icons.warning_amber);
      }
      OE? oeObj = findOE(calloutConfig.cId);
      if ((calloutConfig.calloutW ?? 0) <= 0) {
        debugPrint(
            'calloutW:${calloutConfig.calloutW} !!!  (cId:${calloutConfig.cId}');
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

    fca.afterNextBuildDo(() {
      Overlay.of(fca.rootContext).insert(entry, below: lowestOverlay);
    });

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
      CalloutConfig calloutConfig) async {
    if (calloutConfig.finalSeparation > 0.0) {
      if (calloutConfig.vsync != null) {
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
          calloutConfig.setSeparation(animation.value);
        });
        calloutConfig.startedAnimatingSeparation();
        animationController.forward(from: 0.0);
      } else {
        // calloutConfig.setSeparation(
        //   calloutConfig.finalSeparation,
        //   () => oEntry.markNeedsBuild(),
        // );
        // oEntry.markNeedsBuild();
      }
    }
  }

  static OE? findOE(Feature cId) {
    for (OE oe in OE.list) {
      if (oe.calloutConfig.cId == cId) {
        return oe;
      }
    }
    return null;
  }

  static bool _sameType<T1, T2>() => T1 == T2;

  static T? findCallout<T>(String cId) {
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
        overlays2bRemoved.add(oe.calloutConfig.cId);
      }
// }
    }
    for (Feature cId in overlays2bRemoved) {
      if (!exceptFeatures.contains(cId)) dismiss(cId);
    }
  }

  static void dismiss(String cId) {
// debugPrint('-- dismiss -----------------------------------');
// for (OE oe in OE.list) {
//   debugPrint(oe.calloutConfig.cId);
// }

    OE? oeObj = findOE(cId);
    if (oeObj != null) {
      try {
        oeObj
          ..isHidden = true
          ..opC?.hide()
          ..entry?.remove();
      } catch (e) {}
      OE.deRegisterOE(oeObj);
      if (oeObj.entry != null) {
        oeObj.calloutConfig.onDismissedF?.call();
      }
      debugPrint(
          '-- dismissed $cId ${oeObj.opC != null ? "*" : ""} ---------------------------');
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
      dismiss(topOE.calloutConfig.cId);
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
      unhide(config.cId);
    } else {
      WrappedCalloutState? c = WrappedCallout.of(context);
      c?.unhide(animateSeparation: animateSeparation, hideAfterMs: hideAfterMs);
    }
  }

  static void hideParentCallout(context) {
    CalloutConfig? config = findParentCalloutConfig(context);
    if (config != null) {
      hide(config.cId);
    }
  }

  static void removeParentCallout(context) {
    CalloutConfig? config = findParentCalloutConfig(context);
    if (config != null) {
      dismiss(config.cId);
    }
  }

//   static void showTextToast({
//     required cId,
//     required String msgText,
//     Color backgroundColor = Colors.black,
//     Color textColor = Colors.white,
//     double textScaleFactor = 1,
//     Alignment gravity = Alignment.topCenter,
//     double width = 600,
//     double height = 30,
//     VoidCallback? onDiscardedF,
//     VoidCallback? onAcceptedF,
// // bool? gotitAxis,,
// // VoidCallback? onGotitPressedF,
//     bool onlyOnce = false,
//     double elevation = 6,
//     bool showCloseButton = false,
//     Color closeButtonColor = Colors.deepOrange,
//     double borderRadius = 10,
//     int removeAfterMs = 0,
//   }) {
// // if (width != null && height == null) height = 60;
//
//     if (removeAfterMs > 0) {
//       Future.delayed(Duration(milliseconds: removeAfterMs), () {
//         dismiss(cId);
//       });
//     }
//     showOverlay(
//       calloutConfig: CalloutConfig(
//         fid: cId,
//         gravity: gravity,
//         scale: 1.0,
//         suppliedCalloutW: width,
//         suppliedCalloutH: height,
//         fillColor: backgroundColor,
//         elevation: elevation,
//         modal: false,
//         noBorder: true,
//         animate: true,
//         borderRadius: 10,
//         alwaysReCalcSize: true,
//         arrowType: ArrowType.NO_CONNECTOR,
//         draggable: false,
//         onDismissedF: onDiscardedF,
//         initialCalloutPos: _initialOffsetFromGravity(gravity, width, height),
//         onlyOnce: onlyOnce,
//         showCloseButton: showCloseButton,
//         closeButtonColor: closeButtonColor,
//       ),
//       calloutContentF: (cachedContext) => ConstrainedBox(
//         constraints: BoxConstraints(maxWidth: width),
//         child: Center(
//           child: ConstrainedBox(
//             constraints: BoxConstraints(minHeight: 32, minWidth: FCA.scrW * .8),
//             child: Container(
// //width: w,
// // decoration: BoxDecoration(
// //   color: background,
// //   borderRadius: BorderRadius.circular(backgroundRadius),
// // ),
//               margin: const EdgeInsets.symmetric(horizontal: 20),
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Center(
//                 child: Text(
//                   msgText,
//                   softWrap: true,
//                   textScaler: TextScaler.linear(textScaleFactor),
//                   style: TextStyle(fontSize: 24, color: textColor),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

  static void showToast({
    required CalloutConfig calloutConfig,
    required WidgetBuilder calloutContentF,
    int removeAfterMs = 0,
  }) {
    assert(calloutConfig.gravity != null &&
        calloutConfig.initialCalloutW != null &&
        calloutConfig.initialCalloutH != null);

    // scroll awareness
    if (calloutConfig.hScrollController != null) {
      fca.registerScrollController(calloutConfig.hScrollController!);
    }
    if (calloutConfig.vScrollController != null) {
      fca.registerScrollController(calloutConfig.vScrollController!);
    }

    CalloutConfig toastCC = calloutConfig.copyWith(
      cId: calloutConfig.cId,
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
        dismiss(toastCC.cId);
      });
    }
    showOverlay(
      calloutConfig: toastCC,
      calloutContentF: (cachedContext) => calloutContentF(cachedContext),
    );
  }

  static Offset _initialOffsetFromGravity(
      Alignment alignment, double w, double h) {
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

  static Offset _finalOffsetFromGravity(
      Alignment alignment, double w, double h) {
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

  static Future<void> _possiblyAnimateToastPos(CalloutConfig toastCC) async {
    if (toastCC.vsync != null && toastCC.left != null && toastCC.top != null) {
      Offset initialPos = Offset(toastCC.left!, toastCC.top!);
      Offset finalPos = _finalOffsetFromGravity(
        toastCC.gravity!,
        toastCC.calloutW!,
        toastCC.calloutH!,
      );
      // animate pos from offscreen
      AnimationController animationController = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: toastCC.vsync!,
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

  static void showCircularProgressIndicator(bool show,
      {required String reason}) {
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
          fillColor: Colors.black,
          elevation: 5,
          borderRadius: 10,
          alwaysReCalcSize: true,
          arrowType: ArrowType.NONE,
          draggable: false,
        ),
        calloutContentF: (cachedContext) => Center(
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

  static bool isHidden(String cId) => findOE(cId)?.isHidden ?? false;

  static void hide(String cId) {
    OE? oeObj = findOE(cId);
    if (oeObj != null && !oeObj.isHidden) {
      oeObj
        ..isHidden = true
        ..opC?.hide()
        ..entry?.markNeedsBuild();
      // OE.debug();
    }
  }

// static bool isOverlayOrOPHidden(String cId) =>
//     findOE(cId)?.isHidden ?? false;
//
// static void hide(String cId) {
//   OE? oeObj = findOE(cId);
//   if (oeObj != null && !oeObj.isHidden) {
//     oeObj
//       ..isHidden = true
//       ..opC?.hide()
//       ..entry?.markNeedsBuild();
//     OE.debug();
//   }
// }

  static void unhide(String cId) {
    OE? oe = findOE(cId);
    if (oe != null && oe.isHidden) {
      oe
        ..isHidden = false
        ..opC?.show()
        ..entry?.markNeedsBuild();
      // OE.debug();
    }
  }

  static void refresh(String cId, {VoidCallback? f}) {
    f?.call();
    Callout.findCallout<OverlayEntry>(cId)?.markNeedsBuild();
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

  static bool anyPresent(List<Feature> cIds, {bool includeHidden = false}) {
    if (cIds.isEmpty) {
      return false;
    } else {
      for (OE oe in OE.list) {
        if ((!oe.isHidden || includeHidden) &&
            cIds.contains(oe.calloutConfig.cId)) {
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
      fca.afterMsDelayDo(300, () {
        parent.calloutConfig.preventDrag = false;
      });
    }
  }
}
