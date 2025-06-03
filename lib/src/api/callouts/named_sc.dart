import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

typedef ScrollControllerName = String;

class NamedScrollController extends ScrollController {
  final ScrollControllerName name;
  final Axis axis; // need axis for bubble pos translate
  final ValueNotifier<int>? targetNotifier;

  static final Map<ScrollControllerName, NamedScrollController>
  namedScrollControllers = {};

  NamedScrollController._internal(this.name, this.axis, this.targetNotifier);

  factory NamedScrollController(String name,
      Axis axis, {
        initialScrollOffset,
        debugLabel,
        ValueNotifier<int>? targetNotifier,
      }) {
    // if (namedScrollControllers.containsKey(name))
    //   return namedScrollControllers[name]!;
    // else {
      final NamedScrollController nsc =
      NamedScrollController._internal(name, axis, targetNotifier);
      namedScrollControllers[name] = nsc;
      // onAttach() {
      //   fca.logger.i('********************************** onAttach() - ${positions.length} positions' );
      // }
      nsc.addListener(() {
        nsc._listener.call();
      });
      fca.logger.i("new NamedScrollController($name)\n"
          "listening for refreshing callouts and targets");
      return nsc;
    // }
  }

  @override
  void dispose() {
    removeListener(_listener);
    namedScrollControllers.remove(name);
    fca.logger.i("- - - - - dispose NamedScrollController($name) - - - - - ");
    super.dispose();
  }

  void _listener() {
    if (hasClients) {
      // _scrollOffsetMap[name] = offset;
      // fca.logger.i('NamedScrollController.listenToOffset: $name, $offset)');
      fca.refreshAll();
      fca.logger.i('NamedScrollController.listenToOffset: calling refreshAll');
    }
  }

  static List<ScrollController> allControllers() =>
      namedScrollControllers.values.toList();

  // static void restoreOffset(ScrollControllerName? scName) {
  //   if (scName == null) return;
  //   var sC = _instances[scName];
  //   if (sC == null) return;
  //   double? so = _scrollOffsetMap[scName];
  //   if (so != null && sC.hasClients && sC.offset != so) {
  //     sC.jumpTo(so);
  //   }
  // }

  // static void restoreOffsetTo(ScrollControllerName? scName, double scOffset) {
  //   if (scName == null) return;
  //   var sC = _instances[scName];
  //   sC?.jumpTo(scOffset);
  // }

  static NamedScrollController? instance(ScrollControllerName scName) =>
      namedScrollControllers[scName];

  static bool exists(ScrollControllerName scName) =>
      namedScrollControllers.containsKey(scName);

  static double scrollOffset(ScrollControllerName? scName) =>
      // scName != null ? (_scrollOffsetMap[scName] ?? 0.0) : 0.0;
  scName != null && (instance(scName)?.hasClients ?? false)
      ? (instance(scName)?.offset ?? 0.0)
      : 0.0;

  static double hScrollOffset(ScrollControllerName? scName) {
    if (scName == null) return 0.0;
    var namedSC = instance(scName);
    double result = namedSC != null && namedSC.axis == Axis.horizontal
        ? scrollOffset(scName)
        : 0.0;
    // if (result != 0.0) fca.logger.i('hScrollOffset!=0');
    return result;
  }

  static double vScrollOffset(ScrollControllerName? scName) {
    if (scName == null) return 0.0;
    var namedSC = instance(scName);
    double result = namedSC != null && namedSC.axis == Axis.vertical
        ? scrollOffset(scName)
        : 0.0;
    // if (result != 0.0) fca.logger.i('vScrollOffset!=0');
    return result;
  }
}
