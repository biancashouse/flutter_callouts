import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

import 'overlay_entry_list.dart';

export "rectangle.dart";
export "side.dart";

// ignore: non_constant_identifier_names
int SECS(int s) => s * 1000;

class WrappedCallout extends StatefulWidget {
  final CalloutConfig calloutConfig;
  final WidgetBuilder calloutBoxContentBuilderF;
  final WidgetBuilder targetBuilderF;
  final ValueNotifier<int>? targetChangedNotifier;
  final bool skipWidthConstraintWarning;
  final bool skipHeightConstraintWarning;
  final bool wrapInPointerInterceptor;

  // static void showOP(Feature feature) =>
  //     Callout.findCallout<OverlayPortalController>(feature)?.show();
  //
  // static void hideOP(Feature feature) =>
  //     Callout.findCallout<OverlayPortalController>(feature)?.hide();

  WrappedCallout({
    required this.calloutConfig,
    required this.calloutBoxContentBuilderF,
    // providing a target widget directly means use an OverlayPortal
    required this.targetBuilderF,
    this.targetChangedNotifier,
    this.skipWidthConstraintWarning = false,
    this.skipHeightConstraintWarning = false,
    this.wrapInPointerInterceptor = false,
    super.key,
  }) {
    // fca.logger.i("Callout.wrapTarget");
  }

  static WrappedCalloutState? of(BuildContext context) =>
      context.findAncestorStateOfType<WrappedCalloutState>();

  // hide OpenPortal overlay
  static void hideParentCallout(BuildContext context) =>
      WrappedCallout.of(context)?.hideOP();

  // unhide OpenPortal overlay
  static void unhideParentCallout(
    BuildContext context, {
    bool animateSeparation = false,
    int hideAfterMs = 0,
  }) {
    WrappedCalloutState? c = WrappedCallout.of(context);
    c?.unhide(animateSeparation: animateSeparation, hideAfterMs: hideAfterMs);
  }

  // creates the actual OverlayEntry
  // pos and size can by changed externally

  @override
  State<WrappedCallout> createState() => WrappedCalloutState();
}

class WrappedCalloutState extends State<WrappedCallout>
    implements TickerProvider {
  // OverlayPortal use
  late OverlayPortalController opController;
  late CalloutConfig _config;

  // ignore: constant_identifier_names
  static const _AllowImagesToRenderMs = 2000;
  late GlobalKey _targetMeasuringGK;

  // late bool _waitingForAnyImagesToRender;
  Offset? targetPos;
  Size? targetSize;
  Size? boxContentInitialSize;

  late Future<Widget> fCreateCalloutOverlayEntry;

  @override
  void initState() {
    // TODO initState can only run when widget is actually in the widget tree ?
    super.initState();
    _config = widget.calloutConfig;
    _targetMeasuringGK = GlobalKey(debugLabel: 'measuring-target-gk');
    opController = OverlayPortalController();

    OE.registerOE(
      OE(opC: opController, calloutConfig: _config, isHidden: false),
    );

    // has a barrier means allow escape to dismiss
    if (_config.barrier != null) {
      fca.registerKeystrokeHandler(_config.cId, (k) {
        if (k.logicalKey == LogicalKeyboardKey.escape) {
          fca.hide(_config.cId);
        }
        return false;
      });
    }

    // _waitingForAnyImagesToRender = true;
    fca.afterNextBuildDo(() {
      fca.afterMsDelayDo(_AllowImagesToRenderMs, () {
        // _waitingForAnyImagesToRender = false;
        // get initial size after first build + a little more time to allow any images to render
        Rect? r = _targetMeasuringGK.globalPaintBounds(
          skipWidthConstraintWarning: widget.skipWidthConstraintWarning,
        );
        if (r != null) {
          targetPos = r.topLeft;
          targetSize = r.size;
        }
      });
    });

    // if a notifer was passed in, means inside another overlay, so the target would change as the overlay gets moved or resized
    widget.targetChangedNotifier?.addListener(() {
      fca.logger.i("\n\ntime to update the target\n\n");
      // measure target again
      Rect? r = _targetMeasuringGK
          .globalPaintBounds(); //Measuring.findGlobalRect(_targetMeasuringGK);
      if (r != null) {
        targetPos = r.topLeft;
        targetSize = r.size;
      }
    });
  }

  @override
  void dispose() {
    fca.logger.i("callout disposed: ${_config.cId}");
    OE.deRegisterOE(fca.findOE(_config.cId), force: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: opController,
      // the CalloutConfig + overlayPortalChild + overlayContent are combined to make the Overlay
      overlayChildBuilder: (_) {
        Rect r = Rect.fromLTWH(
          targetPos?.dx ?? 0,
          targetPos?.dy ?? 0,
          targetSize?.width ?? 0,
          targetSize?.height ?? 0,
        );
        return _config.opContentWidget(
          context: context,
          targetRect: r,
          calloutContentF: (ctx) => Builder(
            builder: (context) {
              return widget.calloutBoxContentBuilderF(context);
            },
          ),
          wrapInPointerInterceptor: widget.wrapInPointerInterceptor,
          rebuildF: () => opController.show(),
        );
      },
      //     (BuildContext ctx) {
      //   fca.logger.i("overlayChildBuilder...");
      //   if (targetSize != null && targetPos != null) fca.logger.i("target not measured!");
      //   if (calloutSize != null) fca.logger.i("callout boxContent not measured!");
      //   return targetSize != null && targetPos != null
      //       ? _config.calloutOverlayEntryAlreadyMeasured(
      //           context: ctx,
      //           boxContent: widget.calloutBoxContentBuilderF(ctx),
      //         )
      //       : const Offstage();
      // }, // need the context of the State, so client app can access the opController
      child: Builder(
        key: _targetMeasuringGK,
        builder: (ctx) => widget.targetBuilderF(ctx),
      ),
    );
  }

  void unhide({bool animateSeparation = false, int hideAfterMs = 0}) {
    showOP();
  }

  void showOP() {
    // may be called before target sized properly
    //     if (false && _waitingForAnyImagesToRender) {
    //       fca.afterMsDelayDo(_AllowImagesToRenderMs, () {
    //         opController.show;
    //       });
    //       return;
    //     }

    if (opController.isShowing) {
      opController.show;
      return;
    }

    // restore content size - may be null
    _config.calloutW = boxContentInitialSize?.width;
    _config.calloutH = boxContentInitialSize?.height;
    //
    _config.calloutW ??= _config.initialCalloutW;
    _config.calloutH ??= _config.initialCalloutH;
    // possibly create the overlay after measuring the callout's content
    if (_config.initialCalloutW == null || _config.initialCalloutH == null) {
      fca
          .measureWidgetRect(
            context: fca.rootContext,
            widget: widget.calloutBoxContentBuilderF(fca.rootContext),
          )
          .then((rect) {});
      fca.afterNextBuildMeasureThenDo(
        skipWidthConstraintWarning: _config.calloutW != null,
        skipHeightConstraintWarning: _config.calloutH != null,
        (mctx) => widget.calloutBoxContentBuilderF(mctx),
        (Size size) {
          _config.calloutW ??= size.width;
          _config.calloutH ??= size.height;
          boxContentInitialSize ??= Size(_config.calloutW!, _config.calloutH!);
          opController.show();
        },
      );
    } else {
      // Useful.afterNextBuildDo(() {
      opController.show();
      // });
    }

    _possiblyAnimateSeparationOP(context);
  }

  void toggleOP() {
    context;
    if (opController.isShowing) {
      hideOP();
    } else {
      showOP();
    }
  }

  void _possiblyAnimateSeparationOP(BuildContext context) {
    if ((_config.finalSeparation ?? 0.0) > 0.0) {
      // animate separation, top or left
      AnimationController animationController = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      );
      Tween<double> tween = Tween<double>(
        begin: 0.0,
        end: _config.finalSeparation,
      );
      Animation<double> animation = tween.animate(animationController);
      animation.addListener(() {
        // fca.logger.i('--- ${_config.feature} --- animation value ${animation.value}');
        _config.setSeparation(animation.value); //, () => opController.show());
      });
      _config.startedAnimatingSeparation();
      animationController.forward().whenComplete(() {
        _config.finishedAnimatingSeparation();
        animationController.dispose();
      });
    }
  }

  void hideOP() {
    if (!opController.isShowing) return;
    opController.hide();
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }

  // OverlayEntry renderCalloutBoxContentOffstage(Widget boxContent) {
  //   OverlayEntry offstageEntry = OverlayEntry(
  //     builder: (BuildContext ctx) => MeasureSizeBox(
  //       onSizedCallback: (newSize) {
  //         fca.logger.i("measured callout: ${newSize.toString()}");
  //         calloutSize = newSize;
  //         _config.calloutW = newSize.width;
  //         _config.calloutH = newSize.height;
  //       },
  //       child: ConstrainedBox(
  //           constraints: BoxConstraints(maxHeight: 100, maxWidth: 200),
  //           child: Text('ABC')), //widget.calloutBoxContentBuilderF(Useful.cachedContext!),
  //     ),
  //   );
  //   Overlay.of(Useful.cachedContext!).insert(offstageEntry);
  //   return offstageEntry;
  // }
}
