import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

import 'overlay_entry_list.dart';

export 'arrow_type.dart';
export "rectangle.dart";
export "side.dart";

class Callout {
  Callout._(); // Private constructor

  static OE? findOE(Feature cId) {
    for (OE oe in OE.list) {
      if (oe.calloutConfig.cId == cId) {
        return oe;
      }
    }
    return null;
  }

  static CalloutConfig? getCalloutConfig(Feature feature) {
    OE? oe  = findOE(feature);
    if (oe != null) return oe.calloutConfig;
    return null;
  }

  static void rebuild(Feature feature, {VoidCallback? f}) {
    findOE(feature)?.calloutConfig.rebuild(f);
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

  static BuildContext? findCalloutCallerContext(String cId) {
    var oe = findOE(cId);
    var callerGK = oe?.calloutConfig.callerGK;
    return callerGK?.currentContext;
  }

  static State? findCalloutCallerState(String cId) {
    var oe = findOE(cId);
    var callerGK = oe?.calloutConfig.callerGK;
    return callerGK?.currentState;
  }

  static Widget? findCalloutCallerWidget(String cId) {
    var oe = findOE(cId);
    var callerGK = oe?.calloutConfig.callerGK;
    return callerGK?.currentWidget;
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

  static void dismiss(String cId, {bool skipOnDismiss = false}) {
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
      if (oeObj.entry != null && !skipOnDismiss) {
        oeObj.calloutConfig.onDismissedF?.call();
      }
      // debugPrint(
      //     '-- dismissed $cId ${oeObj.opC != null ? "*" : ""} ---------------------------');
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

  static CalloutConfig? findParentCalloutConfig(context) {
    return context
        .findAncestorWidgetOfExactType<PositionedBoxContent>()
        ?.calloutConfig;
  }

// unhide OpenPortal overlay
  static void unhideParentCallout(BuildContext context,
      {bool animateSeparation = false, int hideAfterMs = 0}) {
    var op = context.findAncestorWidgetOfExactType<OverlayPortal>();
    if (op != null) {
      // find its cc
      for (OE oe in OE.list) {
        if (oe.opC == op.controller) {
          CalloutConfig cc = oe.calloutConfig;
          unhide(cc.cId);
        }
      }
    }

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

  static bool isHidden(String cId) => findOE(cId)?.isHidden ?? false;

  static void hide(String cId) {
    OE? oeObj = findOE(cId);
    if (oeObj != null /*  && !oeObj.isHidden*/) {
      oeObj
        ..isHidden = true
        ..opC?.hide()
        ..entry?.markNeedsBuild();
      // OE.debug();
    }
  }

  static void unhide(String cId) {
    OE? oe = findOE(cId);
    if (oe != null /*&& oe.isHidden*/) {
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
      if (!oe.isHidden && oe.entry != null) {
        oe.calloutConfig.calcEndpoints();
        debugPrint('after calcEndpoints: tR is ${oe.calloutConfig.tR.toString()}');
        oe.entry?.markNeedsBuild();
      }
      // if (!oe.isHidden && oe.opC != null) {
      //   oe.opC?.show();
      // }
    }
  }

  static bool anyPresent(List<Feature> cIds, {bool includeHidden = false}) {
    bool result = false;
    if (cIds.isEmpty) {
      result = false;
    } else {
      for (OE oe in OE.list) {
        if ((!oe.isHidden || includeHidden) &&
            cIds.contains(oe.calloutConfig.cId)) {
          result = true;
        }
      }
    }
    return result;
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
