import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

export "rectangle.dart";
export "side.dart";

// used to store a map of overlay entries, but also each one has a bool indicating whether its a Toast
class OE {
  OverlayEntry? entry;
  OverlayPortalController? opC;
  CalloutConfigModel calloutConfig;
  bool isHidden;
  double? savedHeight;
  int? id;

  OE({this.entry,
    this.opC,
    required this.calloutConfig,
    this.isHidden = false,
    this.savedHeight}) {
    assert(opC != null || entry != null,
    'OE(): must specify an Overlay or an OverlayPortal');
    id = Random().nextInt(99999999);
  }

  static final List<OE> list = [];

  static void registerOE(OE? newOE, {int? before}) {
    if (newOE != null) {
      if (before != null) {
        OE.list.insert(before, newOE);
      } else {
        OE.list.add(newOE);
      }
      // debug();
    }
  }

  static void deRegisterOE(OE? oe, {bool force = false, bool skipOnDismiss = false}) {
    if (oe?.entry != null && !skipOnDismiss) {
      oe?.calloutConfig.onDismissedF?.call();
    }
    oe?.calloutConfig?.removalTimer?.cancel();
    if (oe?.entry != null || force) {
      OE.list.remove(oe);
    }
  }

  static void printFeatures() {
    fca.logger.i('------------');
    for (OE oe in OE.list) {
      fca.logger.i('${oe.calloutConfig.cId} ${oe.opC != null ? "*" : ""}');
    }
    fca.logger.i('------------');
  }

  // static void debug() {
  //   fca.logger.i('${list.length} overlays');
  //   fca.logger.i('------------');
  //   for (OE oe in OE.list) {
  //     fca.logger.i(
  //         '${oe.calloutConfig.cId}: ${oe.entry != null ? Overlay : OverlayPortal}, ${oe.isHidden ? "hidden" : "showing"}, ${oe.isToast ? "TOAST" : ""}');
  //   }
  // }

  // static OE? findOE(Feature feature) {
  //   for (OE oe in OE.list) {
  //     if (oe.calloutConfig.cId == feature) {
  //       return oe;
  //     }
  //   }
  //   return null;
  // }

  // static (int? i, OverlayEntry?) lowestEntry() {
  //   if (OE.list.isNotEmpty) {
  //     for (int i = 0; i < OE.list.length; i++) {
  //       if (OE.list[i].entry != null) {
  //         return (i, OE.list[i].entry);
  //       }
  //     }
  //   }
  //   return (null, null);
  // }

  bool get isToast => calloutConfig.gravity != null;
}