// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_callouts/src/feature_discovery/featured_widget.dart';
// import 'package:flutter_callouts/src/callout_useful.dart';
//
// class DiscoveryOverlayBuilder extends StatefulWidget {
//   final FeaturedWidget parent;
//   final bool? showOverlay;
//   final WidgetBuilder? overlayBuilderF;
//   final Widget? child;
//
//   const DiscoveryOverlayBuilder({required this.parent, this.showOverlay = false, this.overlayBuilderF, this.child, super.key});
//
//   @override
//   _DiscoveryOverlayBuilderState createState() => _DiscoveryOverlayBuilderState();
// }
//
// class _DiscoveryOverlayBuilderState extends State<DiscoveryOverlayBuilder> {
//    OverlayEntry? overlayEntry;
//
//   @override
//   void initState() {
//     super.initState();
//
//     if (widget.showOverlay!) {
//       //showOverlay();
//       CalloutsUseful.afterNextBuildDo(showOverlay);
//     }
//   }
//
//   @override
//   void didUpdateWidget(DiscoveryOverlayBuilder oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     //syncWidgetAndOverlay();
//     CalloutsUseful.afterNextBuildDo(syncWidgetAndOverlay);
//   }
//
//   @override
//   void reassemble() {
//     super.reassemble();
//     //syncWidgetAndOverlay();
//     CalloutsUseful.afterNextBuildDo(syncWidgetAndOverlay);
//   }
//
//   @override
//   void dispose() {
//     if (isShowingOverlay()) {
//       hideOverlay();
//     }
//
//     super.dispose();
//   }
//
//   bool isShowingOverlay() => overlayEntry != null;
//
//   void showOverlay() {
//     overlayEntry = OverlayEntry(
//       builder: widget.overlayBuilderF!,
//     );
//     // Useful.om.insertFeaturedWidgetOverlayEntry(widget.parent, overlayEntry!);
//   }
//
// //  void addToOverlay(OverlayEntry entry) async {
// //    Overlay.of(context).insert(entry);
// //  }
//
// //   void addToOverlay(OverlayEntry? entry) async {
// //     Timer.run(() {
// //       Overlay.of(context).insert(entry!);
// //     });
// // //    final overlay = Overlay.of(context);
// // //     Useful.afterNextBuildDo(() => overlay.insert(entry));
// //   }
//
//   void hideOverlay() {
//     // Callout.removeOverlay(widget.parent.featureEnum);
//   }
//
//   void syncWidgetAndOverlay() {
//     if (isShowingOverlay() && !widget.showOverlay!) {
//       hideOverlay();
//     } else if (!isShowingOverlay() && widget.showOverlay!) {
//       showOverlay();
//     }
//   }
//
//   void buildOverlay() async {
//     overlayEntry?.markNeedsBuild();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Timer.run(() {
//       buildOverlay();
//     });
//     return widget.child!;
//   }
// }
