
import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

typedef ScrollControllerName = String;

class NamedScrollController extends ScrollController {
  final ScrollControllerName name;
  final Axis axis;

  static final Map<ScrollControllerName, NamedScrollController> _instanceMap = {};
  static final Map<ScrollControllerName, double> _scrollOffsetMap = {};

  NamedScrollController(this.name, this.axis, {super.initialScrollOffset, super.debugLabel}) {
    _instanceMap..remove(name)..[name] = this;
    fca.logi("new NamedScrollController($name)");
    // onAttach() {
    //   fca.logi('********************************** onAttach() - ${positions.length} positions' );
    // }
  }

  void listenToOffset() {
    addListener(() {
      if (hasClients) {
        _scrollOffsetMap[name] = offset;
        fca.logi('NamedScrollController.listenToOffset: $name, $offset)');
        fca.refreshAll();
        fca.logi('NamedScrollController.listenToOffset: refreshAll');
      }
    });
  }

  void refreshOffset() {
    double? so = _scrollOffsetMap[name];
    if (so != null && hasClients && offset != so) {
      jumpTo(so);
    }
  }

  static double _scrollOffset(ScrollControllerName scName) =>
      _scrollOffsetMap[scName] ?? 0.0;

  static double hScrollOffset(ScrollControllerName? scName) {
    if (scName == null) return 0.0;
    var sC = _instanceMap[scName];
    double result = sC != null && sC.axis == Axis.horizontal
        ? _scrollOffset(scName)
        : 0.0;
    // if (result != 0.0) fca.logi('hScrollOffset!=0');
    return result;
  }

  static double vScrollOffset(ScrollControllerName? scName) {
    if (scName == null) return 0.0;
    var sC = _instanceMap[scName];
    double result = sC != null && sC.axis == Axis.vertical
        ? _scrollOffset(scName)
        : 0.0;
    // if (result != 0.0) fca.logi('vScrollOffset!=0');
    return result;
  }
}
