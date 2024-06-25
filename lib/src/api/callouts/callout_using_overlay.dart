// import 'package:flutter/material.dart';
// import 'package:flutter_callouts/flutter_callouts.dart';
//
// import 'overlay_entry_list.dart';
//
// export 'arrow_type.dart';
// export "rectangle.dart";
// export "side.dart";
//
// /// callout creator
//
// int SECS(int s) => s * 1000;
//
// class Callout extends StatefulWidget {
//   final CalloutConfig calloutConfig;
//   final WidgetBuilder calloutBoxContentBuilderF;
//   final WidgetBuilder targetBuilderF;
//   final ValueNotifier<int>? targetChangedNotifier;
//   final bool skipWidthConstraintWarning;
//   final bool skipHeightConstraintWarning;
//
//   static void showOP(Feature feature) =>
//       Callout.findCallout<OverlayPortalController>(feature)?.show();
//
//   static void hideOP(Feature feature) =>
//       Callout.findCallout<OverlayPortalController>(feature)?.hide();
//
//   Callout.wrapTarget({
//     required this.calloutConfig,
//     required this.calloutBoxContentBuilderF,
//     // providing a target widget directly means use an OverlayPortal
//     required this.targetBuilderF,
//     this.targetChangedNotifier,
//     this.skipWidthConstraintWarning = false,
//     this.skipHeightConstraintWarning = false,
//     super.key,
//   }) {
//     // debugPrint("Callout.wrapTarget");
//   }
//
//   static bool _sameType<T1, T2>() => T1 == T2;
//
//   static T? findCallout<T>(String feature) {
//     if (_sameType<T, OverlayEntry>()) {
//       OverlayEntry? entry = OE.findOE(feature)?.entry;
//       return entry as T?;
//     }
//     if (_sameType<T, OverlayPortalController>()) {
//       OverlayPortalController? entry = OE.findOE(feature)?.opC;
//       return entry as T?;
//     }
//     return null;
//   }
//
//   static CalloutState? of(BuildContext context) =>
//       context.findAncestorStateOfType<CalloutState>();
//
// // hide OpenPortal overlay
//   static void hideParentCallout(BuildContext context) =>
//       Callout.of(context)?.hideOP();
//
// // unhide OpenPortal overlay
//   static void unhideParentCallout(BuildContext context,
//       {bool animateSeparation = false, int hideAfterMs = 0}) {
//     CalloutState? c = Callout.of(context);
//     c?.unhide(animateSeparation: animateSeparation, hideAfterMs: hideAfterMs);
//   }
//
//   // creates the actual OverlayEntry
//   // pos and size can by changed externally
//   static OverlayEntry _createOverlay(
//       ZoomerState? zoomer,
//       CalloutConfig calloutConfig,
//       WidgetBuilder boxContentF,
//       TargetKeyFunc? targetGkF,
//       bool ensureLowestOverlay,
//       ) {
//     late OverlayEntry entry;
//     entry = OverlayEntry(builder: (BuildContext ctx) {
//       debugPrint('...');
//       debugPrint("${calloutConfig.feature} OverlayEntry.builder...");
//       debugPrint('...');
//       // if (calloutConfig.feature == 'root'){
//       //   debugPrint('root');
//       // }
//
//       Rect? r = targetGkF?.call()?.globalPaintBounds(
//           skipWidthConstraintWarning: calloutConfig.calloutW != null,
//           skipHeightConstraintWarning: calloutConfig.calloutH != null);
//       if (r == null) {
//         // for toast targetgk will be null, and we have to use the gravity to get a rect
//         calloutConfig.initialCalloutPos ??= Offset(
//           FCallouts().scrW / 2 - calloutConfig.suppliedCalloutW! / 2,
//           FCallouts().scrH / 2 - calloutConfig.suppliedCalloutH! / 2,
//         );
//         r = Rect.fromLTWH(
//           calloutConfig.initialCalloutPos!.dx,
//           calloutConfig.initialCalloutPos!.dy,
//           calloutConfig.suppliedCalloutW!,
//           calloutConfig.suppliedCalloutH!,
//         );
//         // debugPrint('${calloutConfig.feature} failed to measure pos and size from targetGkF - overlay not shown');
//         // return const Icon(Icons.warning_amber);
//       }
//       OE? oeObj = OE.findOE(calloutConfig.feature);
//       if ((calloutConfig.calloutW ?? 0) <= 0) {
//         debugPrint(
//             'calloutW:${calloutConfig.calloutW} !!!  (feature:${calloutConfig.feature}');
//       }
//       return Visibility(
//         visible: oeObj == null || !oeObj.isHidden,
//         child: calloutConfig.oeContentWidget(
//           // zoomer: zoomer,
//           targetRect: r,
//           calloutContent: (_) => boxContentF(_),
//           rebuildF: () {
//             entry.markNeedsBuild();
//           },
//         ),
//       );
//     });
//     OverlayEntry? lowestOverlay;
//     int? pos;
//     if (ensureLowestOverlay) {
//       final result = OE.lowestEntry();
//       pos = result.$1;
//       lowestOverlay = result.$2;
//     }
//
//     Overlay.of(FCallouts().rootContext!).insert(entry, below: lowestOverlay);
//
// // // animate separation just once
// //     if (calloutConfig.finalSeparation > 0.0) {
// //       var rootContext = FCallouts().rootContext;
// //       if (rootContext != null) {
// //         var zoomer = Zoomer.of(rootContext);
// //         if (zoomer != null) {
// //           AnimationController animationController = AnimationController(
// //             duration: const Duration(milliseconds: 1),
// //             vsync: calloutConfig.vsync!,
// //           );
// //           Tween<double> tween =
// //               Tween<double>(begin: 0.0, end: calloutConfig.finalSeparation);
// //           Animation<double> animation = tween.animate(animationController);
// //           animation.addListener(() => calloutConfig.setSeparation(
// //               animation.value, () => entry.markNeedsBuild()));
// //           calloutConfig.setRebuildCallback(() {
// //             entry.markNeedsBuild();
// //           });
// //           animationController.forward().whenComplete(() {
// //             calloutConfig.finishedAnimatingSeparation();
// //           });
// //         }
// //       }
// //     }
//     OE.registerOE(OE(entry: entry, calloutConfig: calloutConfig, isHidden: false),
//         before: pos);
//     return entry;
//   }
//
//   static void showOverlay({
//     ZoomerState? zoomer, // if callout needs access to the zoomer
//     required CalloutConfig calloutConfig,
//     required WidgetBuilder boxContentF,
//     TargetKeyFunc? targetGkF,
//     bool ensureLowestOverlay = false,
//     int? removeAfterMs,
//     final ValueNotifier<int>? targetChangedNotifier,
//     // TargetModel? configurableTarget,
//     final ScrollController? hScrollController,
//     final ScrollController? vScrollController,
//     final skipWidthConstraintWarning = false,
//     final skipHeightConstraintWarning = false,
//   }) {
//     if ((calloutConfig.calloutW ?? 0) < 0) {
//       print('tbd');
//     }
//     // if (targetGkF != null) {
//     //   GlobalKey? gk = targetGkF.call();
//     //   // var cs = gk?.currentState;
//     //   // var cw = gk?.currentWidget;
//     //   var cc = gk?.currentContext;
//     //   // if (cc == null) {
//     //   //   debugPrint(
//     //   //       '${calloutConfig.feature} missing target gk - overlay not shown');
//     //   //   return;
//     //   // }
//     // }
//
//     // target's GlobalKey supplied
//     if (removeAfterMs != null) {
//       Future.delayed(Duration(milliseconds: removeAfterMs), () {
//         // calloutConfig.onDismissedF?.call();
//         dismiss(calloutConfig.feature);
//       });
//     }
//
//     late OverlayEntry oEntry; // will be null if target not present
//     calloutConfig.calloutW = calloutConfig.suppliedCalloutW;
//
//     calloutConfig.calloutH = calloutConfig.suppliedCalloutH;
//
//     // possibly create the overlay after measuring the callout's content
//     if (calloutConfig.suppliedCalloutW == null ||
//         calloutConfig.suppliedCalloutH == null) {
//       FCallouts().afterNextBuildMeasureThenDo(
//           skipWidthConstraintWarning: calloutConfig.calloutW != null,
//           skipHeightConstraintWarning: calloutConfig.calloutH != null,
//               (mctx) => boxContentF(mctx), (Size size) {
//         calloutConfig.calloutW ??= size.width;
//         calloutConfig.calloutH ??= size.height;
//         oEntry = _createOverlay(
//           zoomer,
//           calloutConfig,
//           boxContentF,
//           targetGkF,
//           ensureLowestOverlay,
//         );
//       });
//     } else {
//       oEntry = _createOverlay(
//         zoomer,
//         calloutConfig,
//         boxContentF,
//         targetGkF,
//         ensureLowestOverlay,
//       );
//     }
//     // if a notifer was passed in, means inside another overlay, so the target would change as the overlay gets moved or resized
//     targetChangedNotifier?.addListener(() {
//       // debugPrint("\n\ntime to update the target\n\n");
//       FCallouts().afterNextBuildDo(() => oEntry.markNeedsBuild());
//     });
//     Future.delayed(const Duration(milliseconds: 300), (){
//       debugPrint('_possiblyAnimateSeparation');
//       _possiblyAnimateSeparation(calloutConfig, oEntry);
//     });
//   }
//
//   static Future<void> _possiblyAnimateSeparation(CalloutConfig calloutConfig, OverlayEntry oEntry) async {
//     if (calloutConfig.finalSeparation > 0.0 && calloutConfig.vsync != null) {
// // animate separation, top or left
//       AnimationController animationController = AnimationController(
//         duration: const Duration(milliseconds: 100),
//         vsync: calloutConfig.vsync!,
//       );
//       Tween<double> tween =
//       Tween<double>(begin: 0.0, end: calloutConfig.finalSeparation);
//       Animation<double> animation = tween.animate(animationController);
//       animation.addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           calloutConfig.finishedAnimatingSeparation();
//           animationController.dispose();
//         }
//       });
//       animation.addListener(() {
//         debugPrint('new separation: ${animation.value}');
//         calloutConfig.setSeparation(
//             animation.value, () => oEntry.markNeedsBuild());
//       });
//       calloutConfig.startedAnimatingSeparation();
//       animationController.forward(from: 0.0);
//     }
//   }
//
//   static void showTextToast({
//     required feature,
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
//     bool showcpi = false,
//     double roundedCorners = 10,
//     int removeAfterMs = 2000,
//   }) {
// // if (width != null && height == null) height = 60;
//
//     if (removeAfterMs > 0) {
//       Future.delayed(Duration(milliseconds: removeAfterMs), () {
//         dismiss(feature);
//       });
//     }
//     showOverlay(
//       calloutConfig: CalloutConfig(
//         feature: feature,
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
//         showcpi: showcpi,
//       ),
//       boxContentF: (cachedContext) => ConstrainedBox(
//         constraints: BoxConstraints(maxWidth: width),
//         child: Center(
//           child: ConstrainedBox(
//             constraints:
//             BoxConstraints(minHeight: 32, minWidth: FCallouts().scrW * .8),
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
//
//   static void showWidgetToast({
//     required Feature feature,
//     required WidgetBuilder contents,
//     Color backgroundColor = Colors.black,
//     Color textColor = Colors.white,
//     double textScaleFactor = 1,
//     Alignment gravity = Alignment.topCenter,
//     double width = 600,
//     double height = 30,
//     VoidCallback? onDiscardedF,
//     VoidCallback? onAcceptedF,
// // bool? gotitAxis,
// // VoidCallback? onGotitPressedF,
//     bool onlyOnce = false,
//     double elevation = 6,
//     bool showcpi = false,
//     double roundedCorners = 10,
//     int removeAfterMs = 2000,
//   }) {
//     if (removeAfterMs > 0) {
//       Future.delayed(Duration(milliseconds: removeAfterMs), () {
//         dismiss(feature);
//       });
//     }
//     showOverlay(
//       calloutConfig: CalloutConfig(
//         feature: feature,
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
//         onAcceptedF: onAcceptedF,
//         initialCalloutPos: _initialOffsetFromGravity(gravity, width, height),
//         onlyOnce: onlyOnce,
//         showcpi: showcpi,
//       ),
//       boxContentF: (cachedContext) => contents(cachedContext),
//     );
//   }
//
//   static void showCircularProgressIndicator(bool show,
//       {required String reason}) {
// // if (width != null && height == null) height = 60;
//     BuildContext? cachedContext = FCallouts().rootContext;
//     if (show && (cachedContext?.mounted ?? false)) {
//       showOverlay(
//         calloutConfig: CalloutConfig(
//           feature: reason,
//           gravity: Alignment.topCenter,
//           scale: 1.0,
//           suppliedCalloutW: 600,
//           suppliedCalloutH: 50,
//           fillColor: Colors.black,
//           elevation: 5,
//           borderRadius: 10,
//           alwaysReCalcSize: true,
//           arrowType: ArrowType.NO_CONNECTOR,
//           draggable: false,
//         ),
//         boxContentF: (cachedContext) => Center(
//           child: Container(
// //width: w,
// // decoration: BoxDecoration(
// //   color: background,
// //   borderRadius: BorderRadius.circular(backgroundRadius),
// // ),
//             margin: const EdgeInsets.symmetric(horizontal: 20),
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Center(
//               child: Row(
//                 children: [
//                   const CircularProgressIndicator(),
//                   Text(reason),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     }
//   }
//
//   static void dismissAll(
//       {List<Feature> exceptFeatures = const [],
//         bool onlyToasts = false,
//         bool exceptToasts = false}) {
//     List<Feature> overlays2bRemoved = [];
//     for (OE oe in OE.list) {
// // if (oe.entry != null) {
//       bool isToast = oe.calloutConfig.gravity != null;
//       if ((onlyToasts && isToast) ||
//           (exceptToasts && !isToast) ||
//           (!onlyToasts && !exceptToasts)) {
//         overlays2bRemoved.add(oe.calloutConfig.feature);
//       }
// // }
//     }
//     for (Feature feature in overlays2bRemoved) {
//       if (!exceptFeatures.contains(feature)) dismiss(feature);
//     }
//   }
//
//   static void dismiss(String feature) {
// // debugPrint('-- dismiss -----------------------------------');
// // for (OE oe in OE.list) {
// //   debugPrint(oe.calloutConfig.feature);
// // }
//
//     OE? oeObj = OE.findOE(feature);
//     if (oeObj != null) {
//       oeObj
//         ..isHidden = true
//         ..opC?.hide()
//         ..entry?.remove();
//       OE.deRegisterOE(oeObj);
//       debugPrint(
//           '-- dismissed $feature ${oeObj.opC != null ? "*" : ""} ---------------------------');
//     }
//   }
//
//   static void dismissTopFeature() {
//     if (OE.list.isNotEmpty) {
//       OE topOE = OE.list.last;
//       dismiss(topOE.calloutConfig.feature);
//     }
//   }
//
//   static CalloutConfig? findParentCalloutConfig(context) => context
//       .findAncestorWidgetOfExactType<PositionedBoxContent>()
//       ?.calloutConfig;
//
//   static void removeParentCallout(context) {
//     CalloutConfig? config = findParentCalloutConfig(context);
//     if (config != null) {
//       dismiss(config.feature);
//     }
//   }
//
//   static bool isOverlayOrOPHidden(String feature) =>
//       OE.findOE(feature)?.isHidden ?? false;
//
//   static void hide(String feature) {
//     OE? oeObj = OE.findOE(feature);
//     if (oeObj != null && !oeObj.isHidden) {
//       oeObj
//         ..isHidden = true
//         ..opC?.hide()
//         ..entry?.markNeedsBuild();
//       OE.debug();
//     }
//   }
//
//   static void unhide(String feature) {
//     OE? oe = OE.findOE(feature);
//     if (oe != null && oe.isHidden) {
//       oe
//         ..isHidden = false
//         ..opC?.show()
//         ..entry?.markNeedsBuild();
//       OE.debug();
//     }
//   }
//
//   static void refreshOverlay(String feature, {VoidCallback? f}) {
//     f?.call();
//     Callout.findCallout<OverlayEntry>(feature)?.markNeedsBuild();
//   }
//
//   static void refreshAll({VoidCallback? f}) {
//     f?.call();
//     for (OE oe in OE.list) {
//       if (!oe.isHidden) {
//         oe.entry?.markNeedsBuild();
//         oe.opC?.show();
//       }
//     }
//   }
//
//   static bool anyPresent(List<Feature> features, {bool includeHidden = false}) {
//     if (features.isEmpty) {
//       return false;
//     } else {
//       for (OE oe in OE.list) {
//         if ((!oe.isHidden || includeHidden) &&
//             features.contains(oe.calloutConfig.feature)) {
//           return true;
//         }
//       }
//     }
//     return false;
//   }
//
//   static void preventParentCalloutDrag(BuildContext ctx) {
//     PositionedBoxContent? parent =
//     ctx.findAncestorWidgetOfExactType<PositionedBoxContent>();
//     if (parent != null) {
//       parent.calloutConfig.preventDrag = true;
//     }
//   }
//
//   static void allowParentCalloutDrag(BuildContext ctx) {
//     PositionedBoxContent? parent =
//     ctx.findAncestorWidgetOfExactType<PositionedBoxContent>();
//     if (parent != null) {
// // delay to allow _onContentPointerUp to do its thing
//       FCallouts().afterMsDelayDo(300, () {
//         parent.calloutConfig.preventDrag = false;
//       });
//     }
//   }
//
//   static Offset _initialOffsetFromGravity(
//       Alignment alignment, double w, double h) {
//     late Offset initialOffset;
//     if (alignment == Alignment.topCenter) {
//       initialOffset = Offset((FCallouts().scrW - w) / 2, 0);
//     } else if (alignment == Alignment.topRight) {
//       initialOffset = Offset(FCallouts().scrW - w - 10, 10);
//     } else if (alignment == Alignment.bottomCenter) {
//       initialOffset = Offset((FCallouts().scrW - w) / 2, FCallouts().scrH - h);
//     } else if (alignment == Alignment.bottomRight) {
//       initialOffset =
//           Offset(FCallouts().scrW - w - 10, FCallouts().scrH - h - 10);
//     } else if (alignment == Alignment.center) {
//       initialOffset = Offset(
//           FCallouts().scrW / 2 - w / 2 - 10, FCallouts().scrH / 2 - h / 2 - 10);
//     } else {
//       initialOffset =
//           Offset(FCallouts().scrW - -10, FCallouts().scrH / 2 - h / 2 - 10);
//     }
// // debugPrint('initialOffset (${initialOffset.dx}, ${initialOffset.dy}), and Useful.screenW is ${Useful.scrW} and screenH is ${Useful.scrH}');
//     return initialOffset;
//   }
//
//   @override
//   State<Callout> createState() => CalloutState();
// }
//
// class CalloutState extends State<Callout> {
// // OverlayPortal use
//   late OverlayPortalController opController;
//   late CalloutConfig _config;
//   static const _AllowImagesToRenderMs = 2000;
//   late GlobalKey _targetMeasuringGK;
//   late bool _waitingForAnyImagesToRender;
//   Offset? targetPos;
//   Size? targetSize;
//   Size? boxContentInitialSize;
//
//   late Future<Widget> fCreateCalloutOverlayEntry;
//
//   @override
//   void initState() {
// // TODO initState can only run when widget is actually in the widget tree ?
//     super.initState();
//     _config = widget.calloutConfig;
//     _targetMeasuringGK = GlobalKey(debugLabel: 'measuring-target-gk');
//     opController = OverlayPortalController();
//
//     OE.registerOE(
//         OE(opC: opController, calloutConfig: _config, isHidden: false));
//
//     _waitingForAnyImagesToRender = true;
//     FCallouts().afterNextBuildDo(() {
//       FCallouts().afterMsDelayDo(_AllowImagesToRenderMs, () {
//         _waitingForAnyImagesToRender = false;
// // get initial size after first build + a little more time to allow any images to render
//         Rect? r = _targetMeasuringGK.globalPaintBounds(
//             skipWidthConstraintWarning: widget.skipWidthConstraintWarning);
//         if (r != null) {
//           targetPos = r.topLeft;
//           targetSize = r.size;
//         }
//       });
//     });
//
// // if a notifer was passed in, means inside another overlay, so the target would change as the overlay gets moved or resized
//     widget.targetChangedNotifier?.addListener(() {
//       debugPrint("\n\ntime to update the target\n\n");
// // measure target again
//       Rect? r = _targetMeasuringGK
//           .globalPaintBounds(); //Measuring.findGlobalRect(_targetMeasuringGK);
//       if (r != null) {
//         targetPos = r.topLeft;
//         targetSize = r.size;
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     debugPrint("callout disposed: ${_config.feature}");
//     OE.deRegisterOE(OE.findOE(_config.feature), force: true);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext contexT) => OverlayPortal(
//     controller: opController,
// // the CalloutConfig + overlayPortalChild + overlayContent are combined to make the Overlay
//     overlayChildBuilder: (contexT) {
//       Rect r = Rect.fromLTWH(targetPos?.dx ?? 0, targetPos?.dy ?? 0,
//           targetSize?.width ?? 0, targetSize?.height ?? 0);
//       return _config.opContentWidget(
//         context: contexT,
//         targetRect: r,
//         calloutContent: (ctx) => Builder(builder: (ctx) {
//           return widget.calloutBoxContentBuilderF(ctx);
//         }),
//         rebuildF: () => opController.show(),
//       );
//     },
// //     (BuildContext ctx) {
// //   debugPrint("overlayChildBuilder...");
// //   if (targetSize != null && targetPos != null) debugPrint("target not measured!");
// //   if (calloutSize != null) debugPrint("callout boxContent not measured!");
// //   return targetSize != null && targetPos != null
// //       ? _config.calloutOverlayEntryAlreadyMeasured(
// //           context: ctx,
// //           boxContent: widget.calloutBoxContentBuilderF(ctx),
// //         )
// //       : const Offstage();
// // }, // need the context of the State, so client app can access the opController
//     child: Builder(
//       key: _targetMeasuringGK,
//       builder: (ctx) => widget.targetBuilderF(ctx),
//     ),
//   );
//
//   void unhide({bool animateSeparation = false, int hideAfterMs = 0}) {
//     showOP();
//   }
//
//   void showOP() {
// // may be called before target sized properly
//     if (false && _waitingForAnyImagesToRender) {
//       FCallouts().afterMsDelayDo(_AllowImagesToRenderMs, () {
//         opController.show;
//       });
//       return;
//     }
//
//     if (opController.isShowing) {
//       opController.show;
//       return;
//     }
//
// // restore content size - may be null
//     _config.calloutW = boxContentInitialSize?.width;
//     _config.calloutH = boxContentInitialSize?.height;
// //
//     _config.calloutW ??= _config.suppliedCalloutW;
//     _config.calloutH ??= _config.suppliedCalloutH;
// // possibly create the overlay after measuring the callout's content
//     if (_config.suppliedCalloutW == null || _config.suppliedCalloutH == null) {
//       FCallouts().afterNextBuildMeasureThenDo(
//           skipWidthConstraintWarning: _config.calloutW != null,
//           skipHeightConstraintWarning: _config.calloutH != null,
//               (mctx) => widget.calloutBoxContentBuilderF(mctx), (Size size) {
//         _config.calloutW ??= size.width;
//         _config.calloutH ??= size.height;
//         boxContentInitialSize ??= Size(_config.calloutW!, _config.calloutH!);
//         opController.show();
//       });
//     } else {
// // Useful.afterNextBuildDo(() {
//       opController.show();
// // });
//     }
//
//     _possiblyAnimateSeparationOP(context);
//   }
//
//   void toggleOP() {
//     context;
//     if (opController.isShowing) {
//       hideOP();
//     } else {
//       showOP();
//     }
//   }
//
//   void _possiblyAnimateSeparationOP(BuildContext context) {
//     if (_config.finalSeparation > 0.0 && _config.vsync != null) {
// // animate separation, top or left
//       AnimationController animationController = AnimationController(
//         duration: const Duration(milliseconds: 300),
//         vsync: _config.vsync!,
//       );
//       Tween<double> tween =
//       Tween<double>(begin: 0.0, end: _config.finalSeparation);
//       Animation<double> animation = tween.animate(animationController);
//       animation.addListener(() {
// // debugPrint('--- ${_config.feature} --- animation value ${animation.value}');
//         _config.setSeparation(animation.value, () => opController.show());
//       });
//       _config.startedAnimatingSeparation();
//       animationController.forward().whenComplete(() {
//         _config.finishedAnimatingSeparation();
//         animationController.dispose();
//       });
//     }
//   }
//
//   void hideOP() {
//     if (!opController.isShowing) return;
//     opController.hide();
//   }
//
// // OverlayEntry renderCalloutBoxContentOffstage(Widget boxContent) {
// //   OverlayEntry offstageEntry = OverlayEntry(
// //     builder: (BuildContext ctx) => MeasureSizeBox(
// //       onSizedCallback: (newSize) {
// //         debugPrint("measured callout: ${newSize.toString()}");
// //         calloutSize = newSize;
// //         _config.calloutW = newSize.width;
// //         _config.calloutH = newSize.height;
// //       },
// //       child: ConstrainedBox(
// //           constraints: BoxConstraints(maxHeight: 100, maxWidth: 200),
// //           child: Text('ABC')), //widget.calloutBoxContentBuilderF(Useful.cachedContext!),
// //     ),
// //   );
// //   Overlay.of(Useful.cachedContext!).insert(offstageEntry);
// //   return offstageEntry;
// // }
// }
