import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

typedef ScrollControllerName = String;

class NamedScrollController extends ScrollController {
  final ScrollControllerName name;
  final Axis axis; // need axis for bubble pos translate

  static final Map<ScrollControllerName, NamedScrollController> _instanceMap = {
  };
  static final Map<ScrollControllerName, double> _scrollOffsetMap = {};

  NamedScrollController(this.name, this.axis,
      {super.initialScrollOffset, super.debugLabel}) {
    _instanceMap
      ..remove(name)
      ..[name] = this;
    fca.logi("new NamedScrollController($name)");
    // onAttach() {
    //   fca.logi('********************************** onAttach() - ${positions.length} positions' );
    // }
    _listenToOffset();
    fca.logi(
        "NamedScrollController($name) listening for saving offset and refreshing callouts");
  }

  void _listenToOffset() {
    // update map with new offset
    addListener(() {
      listener.call();
    });
  }
  void listener() {
    if (hasClients) {
      _scrollOffsetMap[name] = offset;
      fca.logi('NamedScrollController.listenToOffset: $name, $offset)');
      fca.refreshAll();
      fca.logi('NamedScrollController.listenToOffset: refreshAll');
    }
  }

  static List<ScrollController> allControllers() => _instanceMap.values.toList();

  static void restoreOffset(ScrollControllerName? scName) {
    if (scName == null) return;
    var sC = _instanceMap[scName];
    if (sC == null) return;
    double? so = _scrollOffsetMap[scName];
    if (so != null && sC.hasClients && sC.offset != so) {
      sC.jumpTo(so);
    }
  }

  static void restoreOffsetTo(ScrollControllerName? scName, double scOffset) {
    if (scName == null) return;
    var sC = _instanceMap[scName];
    sC?.jumpTo(scOffset);
  }

  static double scrollOffset(ScrollControllerName? scName) =>
      scName != null ? (_scrollOffsetMap[scName] ?? 0.0) : 0.0;

  static double hScrollOffset(ScrollControllerName? scName) {
    if (scName == null) return 0.0;
    var sC = _instanceMap[scName];
    double result = sC != null && sC.axis == Axis.horizontal
        ? scrollOffset(scName)
        : 0.0;
    // if (result != 0.0) fca.logi('hScrollOffset!=0');
    return result;
  }

  static double vScrollOffset(ScrollControllerName? scName) {
    if (scName == null) return 0.0;
    var sC = _instanceMap[scName];
    double result = sC != null && sC.axis == Axis.vertical
        ? scrollOffset(scName)
        : 0.0;
    // if (result != 0.0) fca.logi('vScrollOffset!=0');
    return result;
  }
}
