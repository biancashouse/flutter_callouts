// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

mixin ScrollingMixin {
  static final Map<String, double> _scrollOffsets = {};
  static final Map<String, Axis> _scrollAxes = {};

  void registerScrollController(String scrollControllerName,
      ScrollController sC, Axis axis) {
    _scrollAxes[scrollControllerName] = axis;
    sC.addListener(() {
      if (sC.hasClients) {
        _scrollOffsets[scrollControllerName] = sC.offset;
        debugPrint(
            'ScrollingMixin.registerScrollController: $scrollControllerName, ${sC
                .offset})');
      }
      Callout.refreshAll();
      debugPrint('ScrollingMixin.registerScrollController: refreshAll');
    });
    debugPrint(
        'ScrollingMixin.registerScrollController($scrollControllerName, ${axis
            .toString()})');
  }

  double scrollOffset(String? scrollControllerName) =>
      scrollControllerName != null
          ? _scrollOffsets[scrollControllerName!] ?? 0.0
          : 0.0;

  double hScrollOffset(String? scrollControllerName) =>
      scrollControllerName != null && scrollAxis(scrollControllerName) == Axis.horizontal
          ? scrollOffset(scrollControllerName)
          : 0.0;

  double vScrollOffset(String? scrollControllerName) =>
      scrollControllerName != null && scrollAxis(scrollControllerName) == Axis.vertical
          ? scrollOffset(scrollControllerName)
          : 0.0;

  Axis? scrollAxis(String scrollControllerName) =>
      _scrollAxes[scrollControllerName];

  void refreshScrollController(String scrollControllerName,
      ScrollController sC) {
    double? so = scrollOffset(scrollControllerName);
    if (so != null && sC.hasClients && sC.offset != so) {
      sC.jumpTo(so);
    }
  }
}
