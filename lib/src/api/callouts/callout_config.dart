import 'dart:async' show Timer;

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_callouts/flutter_callouts.dart';
import 'package:flutter_callouts/src/api/callouts/bubble_shape.dart';
import 'package:flutter_callouts/src/api/callouts/draggable_corner.dart';
import 'package:flutter_callouts/src/api/callouts/draggable_edge.dart';
import 'package:flutter_callouts/src/api/callouts/modal_barrier_with_cutout.dart';
import 'package:flutter_callouts/src/api/callouts/model/upto6colors.dart';
import 'package:flutter_callouts/src/api/callouts/pointing_line.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

part 'callout_config.mapper.dart';

// import 'package:transparent_pointer/transparent_pointer.dart';

// import 'callout_config_toolbar.dart';

@MappableClass()
class CalloutConfigModel
    with CalloutConfigModelMappable
    implements TickerProvider {
  // final VoidCallback refreshOPParent;

  // ignore: constant_identifier_names
  final String cId;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final ValueNotifier<int>? movedOrResizedNotifier;

  // will bump every time callout overlay moved or resized

  double? initialCalloutW;
  double? initialCalloutH;

  @JsonKey(includeFromJson: false, includeToJson: false)
  late Rect _targetRect;

  final AlignmentEnum? gravity; // not null indictates Toast

  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool showGotitButton;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Axis? gotitAxis;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Function? onGotitPressedF;

  final bool showcpi;

  final bool? onlyOnce;

  // final double scale;
  final ScrollControllerName? scrollControllerName;
  bool followScroll;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final GlobalKey? callerGK; // option, allowing caller context to be tracked

  // final VoidCallback? onHidden;

  // extend line in the to direction by delta
  double? fromDelta;

  // extend line in the from direction by delta
  double? toDelta;
  ArrowTypeEnum arrowType;

  ColorModel? arrowColor;
  final AlignmentEnum? initialTargetAlignment;
  final AlignmentEnum? initialCalloutAlignment;
  OffsetModel? initialCalloutPos;

  Alignment? targetAlignment;
  Alignment? calloutAlignment;

  // Alignment? onScreenAlignment;

  @JsonKey(includeFromJson: false, includeToJson: false)
  CalloutBarrierConfig? barrier;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool modal;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool showCloseButton;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Offset closeButtonPos;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final VoidCallback? onCloseButtonPressF;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Color closeButtonColor;

  // callout gets removed if on top of the overlay manager's stack when removeTop() Callout called.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool forceMeasure;

  final double? minWidth;
  final double? minHeight;
  ColorModel? fillColor;
  final ColorModel? borderColor;
  DecorationShapeEnum decorationShape;
  final double borderRadius;
  final double borderThickness;
  final int? starPoints;
  final double lengthDeltaPc;
  final double? contentTranslateX;
  final double? contentTranslateY;
  final double? targetTranslateX;
  final double? targetTranslateY;
  bool animate;
  final Widget? lineLabel;
  final bool frameTarget;
  final double scaleTarget;

  double? finalSeparation;

  final double? dragHandleHeight;
  bool draggable;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool canToggleDraggable;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final ValueChanged<Offset>? onDragF;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final VoidCallback? onDragStartedF;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final ValueChanged<Offset>? onDragEndedF;

  final bool noBorder;
  final double elevation;
  final bool circleShape;
  final bool skipOnScreenCheck;
  final bool resizeableH;
  final bool resizeableV;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final ValueChanged<Size>? onResizeF;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final VoidCallback? onDismissedF;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final TxtChangedF? onTickedF;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final VoidCallback? onHiddenF;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final VoidCallback? onAcceptedF;

  final double draggableEdgeThickness = 16.0;
  final bool alwaysReCalcSize;
  Color? draggableColor;

  final bool containsTextField;

  final bool notUsingHydratedStorage;

  bool initialised = false;

  // overlay class must set this callback
  @JsonKey(includeFromJson: false, includeToJson: false)
  VoidCallback? _rebuildOverlayEntryF;

  // MAYBE reinstate
  // better to pass these in to overcome the unwelcome rebuilding of TextField
  // TextEditingController? teC = TextEditingController();
  @JsonKey(includeFromJson: false, includeToJson: false)
  FocusNode focusNode = FocusNode();

  // WidgetBuilder? _cachedCalloutContent;

  double scrollOffsetX() =>
      NamedScrollController.hScrollOffset(scrollControllerName);

  double scrollOffsetY() =>
      NamedScrollController.vScrollOffset(scrollControllerName);

  void setRebuildCallback(VoidCallback newCallback) =>
      _rebuildOverlayEntryF = newCallback;

  // transient
  @JsonKey(includeFromJson: false, includeToJson: false)
  BuildContext? opDescendantContext; // passed in by fca.wrapTarget
  // ZoomerState? _zoomer;
  // GlobalKey? _opGK;
  @JsonKey(includeFromJson: false, includeToJson: false)
  OverlayEntry? offstageEntry;

  // GlobalKey? offstageGK;

  @JsonKey(includeFromJson: false, includeToJson: false)
  double? top;
  @JsonKey(includeFromJson: false, includeToJson: false)
  double? left;

  @JsonKey(includeFromJson: false, includeToJson: false)
  DraggableEdge_OP? topEdge;
  @JsonKey(includeFromJson: false, includeToJson: false)
  DraggableEdge_OP? leftEdge;
  @JsonKey(includeFromJson: false, includeToJson: false)
  DraggableEdge_OP? bottomEdge;
  @JsonKey(includeFromJson: false, includeToJson: false)
  DraggableEdge_OP? rightEdge;
  @JsonKey(includeFromJson: false, includeToJson: false)
  DraggableCorner_OP? topLeftCorner;
  @JsonKey(includeFromJson: false, includeToJson: false)
  DraggableCorner_OP? topRightCorner;
  @JsonKey(includeFromJson: false, includeToJson: false)
  DraggableCorner_OP? bottomLeftCorner;
  @JsonKey(includeFromJson: false, includeToJson: false)
  DraggableCorner_OP? bottomRightCorner;

  double? _initialTop;
  double? _initialLeft;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Coord? lineLabelPos;

  // get size of callout - ignore locn - it comes from the offstage overlay - not useful
  // we'll be adding the callout to the overlay relative to the targetRect
  // Size get calloutSize => Size(_calloutW, _calloutH);

  @JsonKey(includeFromJson: false, includeToJson: false)
  late bool isHidden;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool needsToScrollH = false;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool needsToScrollV = false;

  @JsonKey(includeFromJson: false, includeToJson: false)
  Offset dragCalloutOffset = Offset.zero;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool dragging = false;

  // for hiding / unhiding
  @JsonKey(includeFromJson: false, includeToJson: false)
  double? savedTop;
  @JsonKey(includeFromJson: false, includeToJson: false)
  double? savedLeft;

  @JsonKey(includeFromJson: false, includeToJson: false)
  late double actualTop;
  @JsonKey(includeFromJson: false, includeToJson: false)
  late double actualLeft;

  // either supplied else measured
  double? _calloutW;
  double? _calloutH;

  // ignore: unnecessary_getters_setters
  double? get calloutW => _calloutW;

  // ignore: unnecessary_getters_setters
  double? get calloutH => _calloutH;

  set calloutW(double? newW) => _calloutW = newW;

  set calloutH(double? newH) => _calloutH = newH;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool ignoreCalloutResult;

  // int initialAnimatedPositionDurationMs;

  //Timer? _timer;

  // bool _animatingSeparation = false;
  bool _finishedAnimatingSeparation = false;
  bool _animatingTopLeft = false;
  double _separation = 0;

  @JsonKey(includeFromJson: false, includeToJson: false)
  late bool isDraggable;

  // can be set by children in the callout content
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool preventDrag = false;

  Rectangle cR() =>
      Rectangle.fromRect(_calloutRect().translate(
          followScroll ? -scrollOffsetX() : 0.0 + (contentTranslateX ?? 0.0),
          followScroll ? -scrollOffsetY() : 0.0 + (contentTranslateY ?? 0.0)));

  @JsonKey(includeFromJson: false, includeToJson: false)
  Timer? removalTimer;

  // TargetModel? _configurableTarget;

  // bool get isConfigurable => _configurableTarget != null;

  // TargetModel? get tc => _configurableTarget;

  CalloutConfigModel({
    // required this.refreshOPParent,
    required this.cId,
    this.callerGK,
    this.movedOrResizedNotifier,
    this.gravity,
    // this.scale = 1.0,
    required this.scrollControllerName, // force developer to consider scrolling
    this.followScroll = true,
    this.forceMeasure = false,
    this.initialCalloutW,
    this.initialCalloutH,
    this.minWidth,
    this.minHeight,
    this.fillColor,
    this.decorationShape = DecorationShapeEnum.rectangle,
    this.borderColor,
    this.borderRadius = 0,
    this.borderThickness = 0,
    this.starPoints,
    this.lengthDeltaPc = 0.95,
    this.contentTranslateX,
    this.contentTranslateY,
    this.targetTranslateX,
    this.targetTranslateY,
    this.arrowType = ArrowTypeEnum.THIN,
    this.arrowColor,
    this.barrier,
    this.modal = false,
    this.showCloseButton = false,
    this.closeButtonPos = const Offset(10, 10),
    this.onCloseButtonPressF,
    this.closeButtonColor = Colors.red,
    this.initialTargetAlignment,
    this.initialCalloutAlignment,
    this.initialCalloutPos,
    // this.onScreenAlignment,
    this.animate = false,
    this.toDelta,
    this.fromDelta,
    this.lineLabel,
    this.frameTarget = false,
    this.scaleTarget = 1.0,
    this.noBorder = false,
    this.elevation = 0,
    this.circleShape = false,
    // this.dragHandle,
    this.dragHandleHeight,
    this.draggable = true,
    this.canToggleDraggable = false,
    this.onDragF,
    this.onDragEndedF,
    this.onDragStartedF,
    this.skipOnScreenCheck = false,
    this.resizeableH = false,
    this.resizeableV = false,
    this.onResizeF,
    this.draggableColor,
    this.showGotitButton = false,
    this.gotitAxis,
    this.onGotitPressedF,
    this.showcpi = false,
    this.onlyOnce,
    this.containsTextField = false,
    this.alwaysReCalcSize = false,
    this.ignoreCalloutResult = false,
    this.finalSeparation,
    this.onDismissedF,
    this.onTickedF,
    this.onHiddenF,
    this.onAcceptedF,
    // this.initialAnimatedPositionDurationMs = 150,
    this.notUsingHydratedStorage = false,
  }) {
    // fca.logger.i(
    //     'Feature: ${feature} CalloutConfig.decoration: ${decorationShape.toString()}');
    if (decorationShape == DecorationShapeEnum.rectangle && borderRadius > 0) {
      decorationShape = DecorationShapeEnum.rounded_rectangle;
    }
    // fillColor = ColorModel.fromColor(
    //     Colors.white); //FCallouts().FUCHSIA_X.withValues(alpha:.9);
    arrowColor ??= fillColor;
    // assert((dragHandle != null) && (dragHandleHeight != null), 'if using a drag handle, it must have height > 0.0 !');
    // assert((widthF != null && heightF != null) || context != null, 'if either widthF or heightF null, must provide a context for measuring !');
    // if ((widthF == null || heightF == null) && context == null) {
    //   fca.logger.i("doh!");
    // }
    // assert(context == null || (context!.mounted), 'context not mounted!');
    // assert(!fca.anyPresent([feature]) && !fca.alreadyGotit(feature, notUsingHydratedStorage: notUsingHydratedStorage));

    // originalWidth = width;
    // originalHeight = height;

    _calloutW ??= initialCalloutW;
    _calloutH ??= initialCalloutH;

    targetAlignment = initialTargetAlignment?.flutterValue;
    calloutAlignment = initialCalloutAlignment?.flutterValue;

    // if (initialCalloutPos != null) {
    //   calloutAlignment = targetAlignment = null;
    // }

    // if (barrier != null) {
    //   barrier!.gradientColors = [];
    //   if (barrier!.opacity > 0.0) {} else {
    //     barrier!.gradientColors ??= const [Colors.black12, Colors.black12];
    //   }
    // }

    initialised = true;
    // set gotit automatically once used
    if (onlyOnce ?? false) {
      fca.gotit(cId, notUsingHydratedStorage: notUsingHydratedStorage);
    }

    isDraggable = draggable;

    // calloutColor = fillColor ?? Colors.white;
    draggableColor ??= Colors.blue.withValues(alpha: .1); //JIC ??

    _separation = finalSeparation ?? 0;

    // this will be used by: final ticker = tickerProvider.createTicker(elapsed)
    // final TickerProvider tickerProvider;
  }

  /// copy constructor
  CalloutConfigModel cloneWith({
    required String cId,
    ValueNotifier<int>? movedOrResizedNotifier,
    AlignmentEnum? gravity,
    double? scale,
    ScrollControllerName? scrollControllerName,
    bool? forceMeasure,
    double? suppliedCalloutW,
    double? suppliedCalloutH,
    double? minWidth,
    double? minHeight,
    ColorModel? fillColor,
    required DecorationShapeEnum decorationShape,
    int? starPoints,
    ColorModel? borderColor,
    double? borderRadius,
    double? borderThickness,
    double? lengthDeltaPc,
    double? contentTranslateX,
    double? contentTranslateY,
    double? targetTranslateX,
    double? targetTranslateY,
    ArrowTypeEnum? arrowType,
    ColorModel? arrowColor,
    CalloutBarrierConfig? barrier,
    bool? modal,
    bool? showCloseButton,
    Offset? closeButtonPos,
    VoidCallback? onCloseButtonPressF,
    Color? closeButtonColor,
    AlignmentEnum? initialTargetAlignment,
    AlignmentEnum? initialCalloutAlignment,
    OffsetModel? initialCalloutPos,
    bool? animate,
    double? toDelta,
    double? fromDelta,
    Widget? lineLabel,
    bool? frameTarget,
    double? scaleTarget,
    bool? noBorder,
    double? elevation,
    bool? circleShape,
    double? dragHandleHeight,
    bool? draggable,
    bool? canToggleDraggable,
    Function? onDragF,
    Function? onDragEndedF,
    Function? onDragStartedF,
    bool? skipOnScreenCheck,
    bool? resizeableH,
    bool? resizeableV,
    ValueChanged<Size>? onResize,
    Color? draggableColor,
    bool? showGotitButton,
    Axis? gotitAxis,
    VoidCallback? onGotitPressedF,
    bool? showcpi,
    bool? onlyOnce,
    bool? containsTextField,
    bool? alwaysReCalcSize,
    bool? ignoreCalloutResult,
    double? finalSeparation,
    VoidCallback? onDismissedF,
    TxtChangedF? onTickedF,
    VoidCallback? onHiddenF,
    VoidCallback? onAcceptedF,
    int? initialAnimatedPositionDurationMs,
    bool? notUsingHydratedStorage,
    required bool allowScrolling,
  }) {
    return CalloutConfigModel(
        cId: cId,
        scrollControllerName: scrollControllerName,
        gravity: gravity ?? this.gravity,
        initialTargetAlignment:
        initialTargetAlignment ?? this.initialTargetAlignment,
        initialCalloutAlignment:
        initialCalloutAlignment ?? this.initialCalloutAlignment,
        initialCalloutPos: initialCalloutPos ?? this.initialCalloutPos,
        finalSeparation: finalSeparation ?? this.finalSeparation,
        barrier: barrier ?? this.barrier,
        initialCalloutW: suppliedCalloutW ?? initialCalloutW,
        initialCalloutH: suppliedCalloutH ?? initialCalloutH,
        borderRadius: borderRadius ?? this.borderRadius,
        borderColor: borderColor ?? this.borderColor,
        borderThickness: borderThickness ?? this.borderThickness,
        fillColor: fillColor ?? this.fillColor,
        elevation: elevation ?? this.elevation,
        frameTarget: frameTarget ?? this.frameTarget,
        showCloseButton: showCloseButton ?? this.showCloseButton,
        showGotitButton: showGotitButton ?? this.showGotitButton,
        closeButtonColor: closeButtonColor ?? this.closeButtonColor,
        closeButtonPos: closeButtonPos ?? this.closeButtonPos,
        gotitAxis: gotitAxis ?? this.gotitAxis,
        arrowColor: arrowColor ?? this.arrowColor,
        arrowType: arrowType ?? this.arrowType,
        animate: animate ?? this.animate,
        lineLabel: lineLabel ?? this.lineLabel,
        fromDelta: fromDelta ?? this.fromDelta,
        toDelta: toDelta ?? this.toDelta,
        lengthDeltaPc: lengthDeltaPc ?? this.lengthDeltaPc,
        contentTranslateX: contentTranslateX ?? this.contentTranslateX,
        contentTranslateY: contentTranslateY ?? this.contentTranslateY,
        targetTranslateX: targetTranslateX ?? this.targetTranslateX,
        targetTranslateY: targetTranslateY ?? this.targetTranslateY,
        scaleTarget: scaleTarget ?? this.scaleTarget,
        resizeableH: resizeableH ?? this.resizeableH,
        resizeableV: resizeableH ?? this.resizeableH,
        draggable: draggable ?? this.draggable,
        draggableColor: draggableColor ?? this.draggableColor,
        dragHandleHeight: dragHandleHeight ?? this.dragHandleHeight,
        skipOnScreenCheck: skipOnScreenCheck ?? this.skipOnScreenCheck,
        onDismissedF: onDismissedF ?? this.onDismissedF,
        onTickedF: onTickedF ?? this.onTickedF,
        followScroll: allowScrolling,
        decorationShape: decorationShape,
        starPoints: starPoints);
  }

  // // global, reusable offstage measuring overlay entry
  // void renderOffstage(WidgetBuilder widgetToMeasure) {
  //   offstageEntry = OverlayEntry(
  //       builder: (BuildContext ctx) => Offstage(
  //             child: Material(
  //               color: Colors.transparent,
  //               child: Center(
  //                 child: Container(
  //                   key: GetIt.I.get<GlobalKey>(instanceName: getIt_offstageGK),
  //                   child: widgetToMeasure(),
  //                 ),
  //               ),
  //             ),
  //           ));
  //   // only want to do this once, because it forces rebuilds !
  //   Overlay.of(Useful.cachedContext!).insert(offstageEntry!);
  // }

  // Future<Size?> measureThenRemoveOffstageWidget(OverlayEntry entry, GlobalKey gk) async {
  //   // renderOffstage(boxContent)
  //   // measure offstage widget
  //   Rect? rect = findGlobalRect(gk);
  //   await Future.delayed(const Duration(milliseconds: 500));
  //   entry.remove();
  //   fca.logger.i("measured size: $calloutW x $calloutH");
  //   return rect?.size;
  // }

  // Widget calloutOverlayEntryAlreadyMeasured({
  //   required BuildContext context,
  //   required Widget boxContent,
  //   TargetModel? configurableTarget,
  // }) {
  //   if (!initialised || _targetRect == null || calloutSize == Size.zero) return const Icon(Icons.error, color: Colors.deepOrange);
  //
  //   _configurableTarget = configurableTarget;
  //
  //   // // possibly measure content
  //   // if (width == null || height == null) {
  //   //   final rendered = renderOffstage(boxContent);
  //   //   await measureThenRemoveOffstageWidget(rendered.$1, rendered.$2);
  //   // }
  //
  //   // // if (width > Useful.screenW()) _calloutW = Useful.screenW() - 30;
  //   // //if (height > Useful.screenH()) _calloutH = Useful.screenH() - 30;
  //   //
  //   // // get size of callout - ignore locn - it comes from the offstage overlay - not useful
  //   // // we'll be adding the callout to the overlay relative to the targetRect
  //   //fca.logger.i('callout widget size: ${calloutSize}');
  //
  //   // separation should take into account the callout size
  //
  //   /// given a Rect, returns most appropriate alignment between target and callout
  //
  //   // fca.logger.i("overlayChild top:$top");
  //
  //   if ((initialCalloutAlignment == null || initialTargetAlignment == null)) {
  //     // double sw = Useful.scrW;
  //     // double sh = Useful.scrH;
  //
  //     // Offset targetC;
  //     // if (tR() == null) {
  //     //   // not specified target gk, so use screen centre
  //     //   targetC = Offset(
  //     //     (sw - width!) / 2,
  //     //     (sh - Useful.kbdH - height!) / 2,
  //     //   );
  //     // } else {
  //     //   targetC = tR().center;
  //     // }
  //
  //     Rect screenRect = Rect.fromLTWH(0, 0, Useful.scrW, Useful.scrH);
  //     initialTargetAlignment = -Useful.calcTargetAlignmentWithinWrapper(screenRect, tR());
  //     initialCalloutAlignment = -initialTargetAlignment!;
  //
  //     // fca.logger.i("initialCalloutAlignment: ${initialCalloutAlignment.toString()}");
  //     // fca.logger.i("initialTargetAlignment: ${initialTargetAlignment.toString()}");
  //   }
  //
  //   if (top == null) _calcContentTopLeft();
  //
  //   fca.logger.i('$feature: tR() (${tR?.width}x${tR?.height})');
  //
  //   if (tR() == null && initialCalloutPos == null) {
  //     // fca.logger.i('skipping callout(${feature}) - perhaps target not present for some reason.');
  //     return const Icon(Icons.error, color: Colors.orangeAccent, size: 60);
  //   }
  //
  //   if (!skipOnScreenCheck && (top ?? 999) < Useful.viewPadding.top) {
  //     top = Useful.viewPadding.top;
  //   }
  //
  //   // set before we start animating the separation gap
  //   _initialTop ??= top;
  //   _initialLeft ??= left;
  //
  //   if (!_finishedAnimatingSeparation && separation > 0.0 && tR() != null && cE != null) {
  //     var adjustedTopLeft = _adjustTopLeftForSeparation(separation, _initialTop!, _initialLeft!, cE!, tR());
  //     top = adjustedTopLeft.$1;
  //     left = adjustedTopLeft.$2;
  //   }
  //
  //   return Builder(builder: (context) {
  //     return Stack(
  //       children: [
  //         if (notToast && barrierOpacity > 0.0) _createBarrier(),
  //         if (resizeableH && resizeableV)
  //           DraggableCorner_OP(alignment: Alignment.topLeft, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV)
  //           DraggableCorner_OP(alignment: Alignment.topRight, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV)
  //           DraggableCorner_OP(alignment: Alignment.bottomLeft, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV)
  //           DraggableCorner_OP(alignment: Alignment.bottomRight, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV) DraggableEdge_OP(side: Side.LEFT, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV) DraggableEdge_OP(side: Side.TOP, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV) DraggableEdge_OP(side: Side.RIGHT, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV)
  //           DraggableEdge_OP(side: Side.BOTTOM, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && !resizeableV) DraggableEdge_OP(side: Side.LEFT, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && !resizeableV)
  //           DraggableEdge_OP(side: Side.RIGHT, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableV && !resizeableH) DraggableEdge_OP(side: Side.TOP, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableV && !resizeableH)
  //           DraggableEdge_OP(side: Side.BOTTOM, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (notToast && arrowType == ArrowType.POINTY) _positionedBubbleBg(),
  //         PositionedBoxContent(this, boxContent),
  //         if (notToast && arrowType != ArrowType.NO_CONNECTOR && arrowType != ArrowType.POINTY && tR() != null) _createPointingLine(),
  //         if (notToast && arrowType != ArrowType.NO_CONNECTOR && arrowType != ArrowType.POINTY && tR() != null && lineLabel != null) _createLineLabel(),
  //         if (notToast && frameTarget && tR() != null) _createTarget(),
  //         if (isConfigurable) _createConfigToolbar(Side.TOP),
  //       ],
  //     );
  //   });
  // }

  // Widget calloutOverlayEntry({
  //   required BuildContext context,
  //   required Widget boxContent,
  //   required GlobalKey? gk,
  //   TargetModel? configurableTarget,
  // }) {
  //   var state = fca.of(context);
  //
  //   if (!initialised) return const Icon(Icons.error, color: Colors.deepOrange);
  //
  //   // fca.logger.i("gk ${gk?.currentWidget.toString()}");
  //   _opGK = gk;
  //
  //   if (!(gk?.currentContext?.mounted ?? false)) {
  //     fca.logger.i('gk not mounted!');
  //   }
  //
  //   _configurableTarget = configurableTarget;
  //
  //   // // possibly measure content
  //   // if (width == null || height == null) {
  //   //   final rendered = renderOffstage(boxContent);
  //   //   await measureThenRemoveOffstageWidget(rendered.$1, rendered.$2);
  //   // }
  //
  //   // // if (width > Useful.screenW()) _calloutW = Useful.screenW() - 30;
  //   // //if (height > Useful.screenH()) _calloutH = Useful.screenH() - 30;
  //   //
  //   // // get size of callout - ignore locn - it comes from the offstage overlay - not useful
  //   // // we'll be adding the callout to the overlay relative to the targetRect
  //   //fca.logger.i('callout widget size: ${calloutSize}');
  //
  //   // separation should take into account the callout size
  //
  //   /// given a Rect, returns most appropriate alignment between target and callout
  //
  //   // fca.logger.i("overlayChild top:$top");
  //
  //   if ((initialCalloutAlignment == null || initialTargetAlignment == null)) {
  //     // double sw = Useful.scrW;
  //     // double sh = Useful.scrH;
  //
  //     // Offset targetC;
  //     // if (tR() == null) {
  //     //   // not specified target gk, so use screen centre
  //     //   targetC = Offset(
  //     //     (sw - width!) / 2,
  //     //     (sh - Useful.kbdH - height!) / 2,
  //     //   );
  //     // } else {
  //     //   targetC = tR().center;
  //     // }
  //
  //     Rect screenRect = Rect.fromLTWH(0, 0, Useful.scrW, Useful.scrH);
  //     initialTargetAlignment = -Useful.calcTargetAlignmentWithinWrapper(screenRect, tR());
  //     initialCalloutAlignment = -initialTargetAlignment!;
  //
  //     // fca.logger.i("initialCalloutAlignment: ${initialCalloutAlignment.toString()}");
  //     // fca.logger.i("initialTargetAlignment: ${initialTargetAlignment.toString()}");
  //   }
  //
  //   if (top == null) _calcContentTopLeft();
  //
  //   fca.logger.i('$feature: tR() (${tR?.width}x${tR?.height})');
  //
  //   if (tR() == null && initialCalloutPos == null) {
  //     // fca.logger.i('skipping callout(${feature}) - perhaps target not present for some reason.');
  //     return const Icon(Icons.error, color: Colors.orangeAccent, size: 60);
  //   }
  //
  //   if (!skipOnScreenCheck && (top ?? 999) < Useful.viewPadding.top) {
  //     top = Useful.viewPadding.top;
  //   }
  //
  //   // set before we start animating the separation gap
  //   _initialTop ??= top;
  //   _initialLeft ??= left;
  //
  //   if (!_finishedAnimatingSeparation && (separation ?? 0.0) > 0.0 && tR() != null && cE != null) {
  //     var adjustedTopLeft = _adjustTopLeftForSeparation(separation!, _initialTop!, _initialLeft!, cE!, tR());
  //     top = adjustedTopLeft.$1;
  //     left = adjustedTopLeft.$2;
  //   }
  //
  //   return Builder(builder: (context) {
  //     return Stack(
  //       children: [
  //         if (notToast && barrier != null && barrier!.opacity > 0.0) _createBarrier(),
  //         if (resizeableH && resizeableV)
  //           DraggableCorner_OP(alignment: Alignment.topLeft, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV)
  //           DraggableCorner_OP(alignment: Alignment.topRight, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV)
  //           DraggableCorner_OP(alignment: Alignment.bottomLeft, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV)
  //           DraggableCorner_OP(alignment: Alignment.bottomRight, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV) DraggableEdge_OP(side: Side.LEFT, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV) DraggableEdge_OP(side: Side.TOP, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV) DraggableEdge_OP(side: Side.RIGHT, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV)
  //           DraggableEdge_OP(side: Side.BOTTOM, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && !resizeableV) DraggableEdge_OP(side: Side.LEFT, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && !resizeableV)
  //           DraggableEdge_OP(side: Side.RIGHT, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableV && !resizeableH) DraggableEdge_OP(side: Side.TOP, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableV && !resizeableH)
  //           DraggableEdge_OP(side: Side.BOTTOM, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (notToast && arrowType == ArrowType.POINTY) _positionedBubbleBg(),
  //         PositionedBoxContent(this, boxContent),
  //         if (notToast && arrowType != ArrowType.NO_CONNECTOR && arrowType != ArrowType.POINTY && tR() != null) _createPointingLine(),
  //         if (notToast && arrowType != ArrowType.NO_CONNECTOR && arrowType != ArrowType.POINTY && tR() != null && lineLabel != null) _createLineLabel(),
  //         if (notToast && frameTarget && tR() != null) _createTarget(),
  //         if (isConfigurable) _createConfigToolbar(Side.TOP),
  //       ],
  //     );
  //   });
  // }

  Widget oeContentWidget({
    // ZoomerState? zoomer, // if supplied, will be a descendant of an OverlayPortal
    required Rect targetRect,
    required WidgetBuilder calloutContent,
    required VoidCallback rebuildF,
    // TargetModel? configurableTarget,
  }) {
    // print('isAnimating: ${isAnimating().toString()}');

    // experiment ------------------------------------------------------------
    // infer alignment from initialPos
    // if (initialCalloutPos != null) {
    //   var taX = (initialCalloutPos!.dx - targetRect.left) / targetRect.width;
    //   var taY = (initialCalloutPos!.dy - targetRect.top) / targetRect.height;
    //   initialTargetAlignment = Alignment(taX,taY);
    //   initialCalloutAlignment = -initialTargetAlignment!;
    //   _separation ??= 50;initialCalloutPos = null;
    // }
    // experiment ------------------------------------------------------------

    // _zoomer = zoomer;
    // _configurableTarget = configurableTarget;
    // opDescendantContext = context; // used to find nearest parent OverlayPortal for barrier tap to close

    // Rect r = Rect.fromLTWH(targetRect.left, targetRect.top,
    //     targetRect.width * scaleTarget, targetRect.height * scaleTarget);

    return Offstage(
      offstage: fca.isHidden(cId),
      child: _renderCallout(targetRect, calloutContent, rebuildF),
    );
  }

  Widget opContentWidget({
    required BuildContext
    context, // if supplied, will be a descendant of an OverlayPortal
    required Rect targetRect,
    required WidgetBuilder calloutContent,
    required VoidCallback rebuildF,
  }) {
    opDescendantContext =
        context; // used to find nearest parent OverlayPortal for barrier tap to close
    // _zoomer = Zoomer.of(context);
    return _calloutW == null || _calloutH == null
        ? const Offstage()
        : _renderCallout(targetRect, calloutContent, rebuildF);
  }

  // Future<Widget> _measureThenRenderCallout(
  //   BuildContext context,
  //   Rect targetRect,
  //   WidgetBuilder calloutContent,
  //   VoidCallback rebuildF,
  //   // TargetModel? configurableTarget,
  // ) async {
  //   // measure offstage widget
  //   // await Future.delayed(const Duration(milliseconds: 500));
  //
  //   Rect? rect = findGlobalRect(GetIt.I.get<GlobalKey>(instanceName: getIt_offstageGK)!);
  //   if (rect != null) {
  //     _calloutW ??= rect.width;
  //     _calloutH ??= rect.height;
  //     fca.logger.i('_measureThenRenderCallout: width:$calloutW, height:$calloutH');
  //   }
  //   fca.logger.i("measured size: $calloutW x $calloutH");
  //   return _renderCallout(context, targetRect, calloutContent, rebuildF);
  // }

  Widget _renderCallout(Rect targetRect,
      WidgetBuilder calloutContent,
      VoidCallback rebuildF,
      // TargetModel? configurableTarget,
      ) {
    _targetRect = targetRect;

    // print('_target: ${_targetRect.toString()}');
    setRebuildCallback(rebuildF);

    // // if (width > Useful.screenW()) _calloutW = Useful.screenW() - 30;
    // //if (height > Useful.screenH()) _calloutH = Useful.screenH() - 30;
    //
    // // get size of callout - ignore locn - it comes from the offstage overlay - not useful
    // // we'll be adding the callout to the overlay relative to the targetRect
    //fca.logger.i('callout widget size: ${calloutSize}');

    // separation should take into account the callout size

    /// given a Rect, returns most appropriate alignment between target and callout

    // fca.logger.i("overlayChild top:$top");

    if ((calloutAlignment == null || targetAlignment == null)) {
      // double sw = Useful.scrW;
      // double sh = Useful.scrH;

      // Offset targetC;
      // if (tR() == null) {
      //   // not specified target gk, so use screen centre
      //   targetC = Offset(
      //     (sw - width!) / 2,
      //     (sh - Useful.kbdH - height!) / 2,
      //   );
      // } else {
      //   targetC = tR().center;
      // }

      Rect screenRect = Rect.fromLTWH(0, 0, fca.scrW, fca.scrH);
      if (screenRect.width == _targetRect.width &&
          screenRect.height == _targetRect.height) {
        targetAlignment = calloutAlignment = Alignment.center;
      } else {
        targetAlignment = -fca.calcTargetAlignmentWithinWrapper(
            wrapperRect: screenRect, targetRect: tR());
        calloutAlignment = -targetAlignment!;
        targetAlignment =
            fca.calcTargetAlignmentWholeScreen(tR(), _calloutW!, _calloutH!);
        calloutAlignment = -targetAlignment!;
      }
    }

    if (top == null) calcContentTopLeft();

    // fca.logger.i('$feature: tR() (${tR?.width}x${tR?.height})');

    // if (tR() == null && initialCalloutPos == null) {
    //   // fca.logger.i('skipping callout(${feature}) - perhaps target not present for some reason.');
    //   return const Icon(Icons.error, color: Colors.orangeAccent, size: 60);
    // }

    if (!skipOnScreenCheck && (top ?? 999) < fca.viewPadding.top) {
      top = fca.viewPadding.top;
    }

    // set before we start animating the separation gap
    _initialTop ??= top;
    _initialLeft ??= left;

    if (cId == 'body panel:default-snippet') fca.logger.i("top $top");

    // fca.logger.i('before adjusting for separation($_separation): pos is $left, $top');

    if (!_finishedAnimatingSeparation && (_separation) > 0.0 && cE != null) {
      // fca.logger.i('ADJUSTING.');
      var adjustedTopLeft = _adjustTopLeftForSeparation(
          _separation, _initialTop!, _initialLeft!, cE!, tR());
      top = adjustedTopLeft.$1;
      left = adjustedTopLeft.$2;
    } else {
      // fca.logger.i('NOT ADJUSTING.');
    }

    // if (_finishedAnimatingSeparation) {
    //   if (!calloutWouldNotBeOffscreen(cE!, 0, 0)) {
    //     left = Useful.scrW / 2 - _calloutW! / 2;
    //     top = Useful.scrH / 2 - _calloutH! / 2;
    //   }
    // }

    // fca.logger.i('after adjusting for separation: pos is $left, $top');

    BuildContext ctx = fca.rootContext;
    var content = calloutContent(ctx);
    return Stack(
      children: [
        if (notToast && barrier != null && barrier!.opacity > 0.0)
          PointerInterceptor(child: _createBarrier()),
        if (notToast && frameTarget) _createTargetBorder(),
        if (resizeableH && resizeableV)
          topLeftCorner = DraggableCorner_OP(
              alignment: Alignment.topLeft,
              thickness: draggableEdgeThickness,
              color: draggableColor!,
              parent: this),
        if (resizeableH && resizeableV)
          topRightCorner = DraggableCorner_OP(
              alignment: Alignment.topRight,
              thickness: draggableEdgeThickness,
              color: draggableColor!,
              parent: this),
        if (resizeableH && resizeableV)
          bottomLeftCorner = DraggableCorner_OP(
              alignment: Alignment.bottomLeft,
              thickness: draggableEdgeThickness,
              color: draggableColor!,
              parent: this),
        if (resizeableH && resizeableV)
          bottomRightCorner = DraggableCorner_OP(
              alignment: Alignment.bottomRight,
              thickness: draggableEdgeThickness,
              color: draggableColor!,
              parent: this),
        if (resizeableH && resizeableV)
          leftEdge = DraggableEdge_OP(
              side: Side.LEFT,
              thickness: draggableEdgeThickness,
              color: draggableColor!,
              parent: this),
        if (resizeableH && resizeableV)
          topEdge = DraggableEdge_OP(
              side: Side.TOP,
              thickness: draggableEdgeThickness,
              color: draggableColor!,
              parent: this),
        if (resizeableH && resizeableV)
          rightEdge = DraggableEdge_OP(
              side: Side.RIGHT,
              thickness: draggableEdgeThickness,
              color: draggableColor!,
              parent: this),
        if (resizeableH && resizeableV)
          bottomEdge = DraggableEdge_OP(
              side: Side.BOTTOM,
              thickness: draggableEdgeThickness,
              color: draggableColor!,
              parent: this),
        if (resizeableH && !resizeableV)
          leftEdge = DraggableEdge_OP(
              side: Side.LEFT,
              thickness: draggableEdgeThickness,
              color: draggableColor!,
              parent: this),
        if (resizeableH && !resizeableV)
          rightEdge = DraggableEdge_OP(
              side: Side.RIGHT,
              thickness: draggableEdgeThickness,
              color: draggableColor!,
              parent: this),
        if (resizeableV && !resizeableH)
          topEdge = DraggableEdge_OP(
              side: Side.TOP,
              thickness: draggableEdgeThickness,
              color: draggableColor!,
              parent: this),
        if (resizeableV && !resizeableH)
          bottomEdge = DraggableEdge_OP(
              side: Side.BOTTOM,
              thickness: draggableEdgeThickness,
              color: draggableColor!,
              parent: this),
        if (notToast && arrowType == ArrowTypeEnum.POINTY)
          _positionedBubbleBg(),
        PositionedBoxContent(this, content),
        if (notToast &&
            arrowType != ArrowTypeEnum.NONE &&
            arrowType != ArrowTypeEnum.POINTY)
          _createPointingLine(),
        if (notToast &&
            arrowType != ArrowTypeEnum.NONE &&
            arrowType != ArrowTypeEnum.POINTY &&
            lineLabel != null)
          _createLineLabel(),
        // if (isConfigurable && _zoomer != null) _createConfigToolbar(Side.TOP),
      ],
    );
  }

  void setSeparation(double newSeparation) {
    _separation = newSeparation;
    _rebuildOverlayEntryF?.call();
  }

  void setTop(double newTop) {
    top = newTop;
    _rebuildOverlayEntryF?.call();
  }

  void setLeft(double newLeft) {
    left = newLeft;
    _rebuildOverlayEntryF?.call();
  }

  void setPos(Offset newPos) {
    top = newPos.dy;
    left = newPos.dx;
    // fca.logger.i('new pos ${newPos.toString()}');
    _rebuildOverlayEntryF?.call();
  }

  void startedAnimatingSeparation() => _finishedAnimatingSeparation = false;

  void finishedAnimatingSeparation() {
    _finishedAnimatingSeparation = true;
    //movedOrResizedNotifier?.value++;
  }

  void startedAnimatingTopLeft() => _animatingTopLeft = true;

  void finishedAnimatingTopLeft() => _animatingTopLeft = false;

  bool isAnimating() => !_finishedAnimatingSeparation || _animatingTopLeft;

  // function determines whether topLeft and bottomRioht are onScreen
  bool calloutWouldNotBeOffscreen(Coord cE, double deltaX, double deltaY) {
    Rect finalCR =
    Rect.fromLTWH(left! + deltaX, top! + deltaY, _calloutW!, _calloutH!);
    Rect scrRect = Rect.fromLTWH(0, 0, fca.scrW, fca.scrH);
    bool result = scrRect.contains(finalCR.topLeft) &&
        scrRect.contains(finalCR.bottomRight);
    // if (!result) {
    //   fca.logger.i("*************** OFFSCREEN ********************");
    // }
    return result;
  }

  (double, double) _adjustTopLeftForSeparation(double theSeparation,
      double initialTop,
      double inititalLeft,
      Coord initialCE,
      Rectangle initialTR) {
    top = initialTop;
    left = inititalLeft;
    // move cE
    Coord cEbefore = initialCE;
    var cEafter = Coord.changeDistanceBetweenPoints(
        Coord.fromOffset(initialTR.center), cEbefore, theSeparation)!;
    // translate callout by separation along line
    var deltaX = cEafter.x - cEbefore.x;
    var deltaY = cEafter.y - cEbefore.y;

    // fca.logger.i("initialLeft: $inititalLeft, separation: $theSeparation, delta: ($deltaX, $deltaY)");

    if (theSeparation <= 1 ||
        calloutWouldNotBeOffscreen(cEafter, deltaX, deltaY)) {
      double newLeft = left!;
      double newTop = top!;
      if (wouldBeOnscreenX(left! + deltaX)) {
        newLeft = left! + deltaX;
      }
      if (wouldBeOnscreenY(top! + deltaY)) {
        newTop = top! + deltaY;
      }
      return (newTop, newLeft);
    } else {
      // fca.logger.i("adjustTopLeftForSeparation(max(0, $theSeparation/2))");
      return (initialTop, inititalLeft);
      // return _adjustTopLeftForSeparation(max(0, theSeparation / 2), initialTop, inititalLeft, initialCE, initialTR);
    }
  }

  bool wouldBeOnscreenX(double left) {
    if (_finishedAnimatingSeparation) return true;
    return left + _calloutW! < fca.scrW;
  }

  bool wouldBeOnscreenY(double top) {
    if (_finishedAnimatingSeparation) return true;
    bool onscreen = top + _calloutH! < fca.scrH - fca.kbdH;
    return onscreen;
  }

// Alignment _rotateAlignmentBy45(Alignment a, bool clockwise) {
//   late double newX;
//   late double newY;
//   int direction = clockwise ? -1 : 1;
//   if (a.x == 0.0 && a.y == 0.0) return a;
//   if (a.y == 0.0) {
//     newY = a.x * direction;
//   } else {
//     newX = (a.y * direction);
//     if (newX == (a.y * 2 * direction)) {
//       newX = a.y * direction;
//       newY = 0;
//     }
//   }
//   return Alignment(newX, newY);
// }

  Rectangle tR() {
    // allow for scaling and cutout padding
    final cutoutPadding = barrier?.cutoutPadding ?? 0.0;
    final scaledRect = Rect.fromLTWH(
      _targetRect.left - (scaleTarget * cutoutPadding),
      _targetRect.top - (scaleTarget * cutoutPadding),
      scaleTarget * (_targetRect.width + cutoutPadding * 2),
      scaleTarget * (_targetRect.height + cutoutPadding * 2),
    );
    return Rectangle.fromRect(scaledRect);
  }

// if target is CalloutTarget, it automatically measures itself after a build,
// otherwise, just measure the widget having this key
//   Rectangle tR() {
//     Rect? rect;
//     if (initialCalloutPos != null) {
//       fca.logger.i('initialCalloutPos != null');
//       rect = Rect.fromLTWH(
//         initialCalloutPos!.dx,
//         initialCalloutPos!.dy,
//         _calloutW!,
//         _calloutH!,
//       );
//     } else if (_opGK?.currentWidget == null) {
//       fca.logger.i("$cId _targetRectangle(): opGK!?.currentWidget == null");
//       // Rect screenRect = Rect.fromLTWH(0, 0, Useful.scrW, Useful.scrH);
//       return Rectangle.fromRect(Rect.zero);
//     } else {
//       fca.logger.i('_opGK!.globalPaintBounds()');
//       Rect? r = _opGK!.globalPaintBounds(); //Measuring.findGlobalRect(_opGK!);
//       if (r == null) return Rectangle.fromRect(Rect.zero);
//       fca.logger.i("$cId findGlobalRect(_opGK!) = ${r.toString()}");
//       // adjust for possible scroll
//       rect = Rect.fromLTWH(
//         r.left,
//         r.top,
//         r.width, // * scaleTarget,
//         r.height,
//       ); // * scaleTarget));
//     }
//     return Rectangle.fromRect(Rect.fromLTWH(
//         rect.left + scrollOffsetX(),
//         rect.top + scrollOffsetY(),
//         rect.width, // * scaleTarget,
//         rect.height));
//   }

  Coord? tE, cE;

  // late Color calloutColor;

  void calcContentTopLeft() {
    double startingCalloutLeft;
    double startingCalloutTop;

    if (initialCalloutPos == null) {
      final targetAlignmentIntersectionPos = targetAlignment!
          .withinRect(Rect.fromLTWH(0, 0, _calloutW!, _calloutH!));
      final calloutAlignmentIntersectionPos = calloutAlignment!
          .withinRect(Rect.fromLTWH(0, 0, _calloutW!, _calloutH!));

      final startingCalloutTopLeftRelativeToTarget =
          targetAlignmentIntersectionPos - calloutAlignmentIntersectionPos;

      startingCalloutLeft = tR().left + startingCalloutTopLeftRelativeToTarget.dx;
      if (!skipOnScreenCheck && startingCalloutLeft < 0) {
        startingCalloutLeft = 0.0;
      }
      startingCalloutTop = tR().top + startingCalloutTopLeftRelativeToTarget.dy;
      if (!skipOnScreenCheck && startingCalloutTop < 0) {
        startingCalloutTop = 0.0;
      }
    } else {
      final targetAlignmentIntersectionPos = targetAlignment!
          .withinRect(Rect.fromLTWH(0, 0, _calloutW!, _calloutH!));
      final calloutAlignmentIntersectionPos = calloutAlignment!
          .withinRect(Rect.fromLTWH(0, 0, _calloutW!, _calloutH!));

      final startingCalloutTopLeftRelativeToTarget = finalSeparation != null
          ? targetAlignmentIntersectionPos - calloutAlignmentIntersectionPos : Offset.zero;

      startingCalloutTop = initialCalloutPos!.dy +
          (followScroll ? -scrollOffsetY() : 0.0) + startingCalloutTopLeftRelativeToTarget.dy;
      startingCalloutLeft = initialCalloutPos!.dx +
          (followScroll ? -scrollOffsetX() : 0.0) + startingCalloutTopLeftRelativeToTarget.dx;
    }

    actualTop = startingCalloutTop;
    actualLeft = startingCalloutLeft;

    // ensure callout will be on onscreen
    // only needs  to be scrollable when can't fit on screen
    // fca.logger.i('============   screenH = ${Useful.screenH()}');
    needsToScrollH = _calloutW! > fca.scrW;
    needsToScrollV = _calloutH! > (fca.scrH - fca.kbdH);
    if (!notToast) {
      fca.logger.i('must skip screen bounds check');
    }
    if ((!skipOnScreenCheck) && !needsToScrollV && !needsToScrollH) {
      var definitelyOnScreen = fca.ensureOnScreen(
        Rect.fromLTWH(
          actualLeft,
          actualTop,
          _calloutW!,
          _calloutH!,
        ),
        _calloutW!,
        _calloutH!,
      );
      actualLeft = definitelyOnScreen.$1;
      actualTop = definitelyOnScreen.$2;
    } else if (needsToScrollV) {
      actualTop = 0.0;
    } else if (needsToScrollH) {
      actualLeft = 0.0;
    }

    dragCalloutOffset = Offset.zero;

    // don't let callout be off screen
    top = actualTop;
    left = actualLeft;
    // fca.logger.i('top: $top');
    // fca.logger.i('left: $left');
  }

// bool _isOffscreen() {
//   // fca.logger.i('left: $actualLeft\ncalloutSize!.width: ${_calloutW!}\nUseful.screenW(): ${Useful.screenW()}');
//   // fca.logger.i(
//   //     'top: $actualTop\ncalloutSize!.height: ${_calloutH!}\nUseful.screenH(): ${Useful.screenH()}\nUseful.kbdH(): ${Useful.kbdH()}');
//   return !skipOnScreenCheck && ((actualLeft + _calloutW!) > Useful.scrW || (actualTop + _calloutH!) > (Useful.scrH - Useful.kbdH));
// }

  bool get notToast => gravity == null;

  Widget _positionedBubbleBg() {
    // fca.logger.i('_positionedBubbleBg');
    return Positioned(
      top: 0,
      left: 0,
      child: CustomPaint(
        painter: BubbleShape_OP(
            calloutConfig: this, fillColor: fillColor?.flutterValue),
        willChange: true,
      ),
    );
  }

  void _onDragStart(DragStartDetails event) {
    if (preventDrag ||
        !isDraggable ||
        event.localPosition.dy >= (dragHandleHeight ?? 9999)) return;
    dragCalloutOffset = event.localPosition;
    if (!dragging) {
      onDragStartedF?.call();
      dragging = true;
    }
  }

  void _onDragMove(DragUpdateDetails event) {
    if (preventDrag ||
        !isDraggable /* || event.localPosition.dy >= (dragHandleHeight ?? 9999) */) {
      return;
    }
    rebuild(() {
      top = event.globalPosition.dy -
          dragCalloutOffset.dy +
          (followScroll ? scrollOffsetY() : 0.0);
      left = event.globalPosition.dx -
          dragCalloutOffset.dx +
          (followScroll ? scrollOffsetX() : 0.0);
      var definitelyOnScreen = fca.ensureOnScreen(
        Rect.fromLTWH(
          left!,
          top!,
          _calloutW!,
          dragHandleHeight ?? _calloutH!,
        )
        // .translate(
        // followScroll ? scrollOffsetX() : 0.0,
        // followScroll ? scrollOffsetY() : 0.0,
        // )
            .translate(
          contentTranslateX != null ? -contentTranslateX! : 0.0,
          contentTranslateY != null ? -contentTranslateY! : 0.0,
        ),
        _calloutW!,
        0,
      );
      left = definitelyOnScreen.$1;
      top = definitelyOnScreen.$2;

      onDragF?.call(Offset(left!, top!));
      movedOrResizedNotifier?.value++;
    });
  }

  void moveBy(double hDelta, double vDelta) {
    rebuild(() {
      if (top == null) return;
      moveTo(
        left! + hDelta - dragCalloutOffset.dx,
        top! + vDelta - dragCalloutOffset.dy,
      );
    });
  }

  // void moveBy(double hDelta, double vDelta) {
  //   rebuild(() {
  //     if (top == null) return;
  //     top = top! + vDelta - dragCalloutOffset.dy;
  //     left = left! + hDelta - dragCalloutOffset.dx;
  //     var definitelyOnScreen = FCallouts().ensureOnScreen(
  //       Rect.fromLTWH(
  //         left!,
  //         top!,
  //         _calloutW!,
  //         dragHandleHeight ?? _calloutH!,
  //       ),
  //       _calloutW!,
  //       _calloutH!,
  //     );
  //     left = definitelyOnScreen.$1;
  //     top = definitelyOnScreen.$2;
  //
  //     onDragF?.call(Offset(left!, top!));
  //     movedOrResizedNotifier?.value++;
  //     fca.logger.i('top: $top, left: $left');
  //   });
  // }
  //
  void moveTo(double newLeft, double newTop) {
    rebuild(() {
      top = newTop;
      left = newLeft;
      var definitelyOnScreen = fca.ensureOnScreen(
        Rect.fromLTWH(
          left!,
          top!,
          _calloutW!,
          dragHandleHeight ?? _calloutH!,
        ),
        _calloutW!,
        _calloutH!,
      );
      left = definitelyOnScreen.$1;
      top = definitelyOnScreen.$2;

      onDragF?.call(Offset(left!, top!));
      movedOrResizedNotifier?.value++;
      // fca.logger.i('top: $top, left: $left');
    });
  }

  Future<void> animateResizeByCornerMove(Alignment alignment,
      double hDelta,
      double vDelta, {
        required Duration duration,
        VoidCallback? afterAnimationF,
      }) async {
    if (left == null || top == null) return;
    AnimationController animationController = AnimationController(
      duration: duration,
      vsync: this,
    );
    Tween<Offset> tween = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(hDelta, vDelta),
    );
    Animation<Offset>? animation = tween.animate(animationController);
    Offset prevValue = Offset.zero;
    int i = 0;
    animation.addListener(() =>
        rebuild(() {
          Offset delta = Offset(animation.value.dx - prevValue.dx,
              animation.value.dy - prevValue.dy);
          prevValue = animation.value;
          fca.logger.i(
              '${i++} av ${animation.value} delta ${delta
                  .toString()}, prevDelta ${prevValue.toString()}');
          if (alignment == Alignment.topLeft) {
            if (delta.dx < 0 || _calloutW! + delta.dx >= (minWidth ?? 30)) {
              left = left! + delta.dx;
              _calloutW = _calloutW! - delta.dx;
            }
            if (delta.dy < 0 || _calloutH! + delta.dy >= (minHeight ?? 30)) {
              top = top! + delta.dy;
              _calloutH = _calloutH! - delta.dy;
            }
          } else if (alignment == Alignment.topRight) {
            if (_calloutW! + delta.dx < (minWidth ?? 30)) {
              _calloutW = minWidth ?? 30;
            } else {
              _calloutW = _calloutW! + delta.dx;
            }
            if (delta.dy < 0 || _calloutH! + delta.dy >= (minHeight ?? 30)) {
              top = top! + delta.dy;
              _calloutH = _calloutH! - delta.dy;
            }
          } else if (alignment == Alignment.bottomLeft) {
            if (delta.dx < 0 || _calloutW! + delta.dx >= (minWidth ?? 30)) {
              left = left! + delta.dx;
              _calloutW = _calloutW! - delta.dx;
            }
            if (_calloutH! + delta.dy < (minHeight ?? 30)) {
              _calloutH = minHeight ?? 30;
            } else {
              _calloutH = _calloutH! + delta.dy;
            }
          } else if (alignment == Alignment.bottomRight) {
            if (_calloutW! + delta.dx < (minWidth ?? 30)) {
              _calloutW = minWidth ?? 30;
            } else {
              _calloutW = _calloutW! + delta.dx;
            }
            if (_calloutH! + delta.dy < (minHeight ?? 30)) {
              _calloutH = minHeight ?? 30;
            } else {
              _calloutH = _calloutH! + delta.dy;
            }
          }
        }));
    await animationController.forward();
    afterAnimationF?.call();
    animationController.dispose();
  }

  Future<void> animateCalloutBy(double hDelta, double vDelta,
      {required Duration durationMs, VoidCallback? afterAnimationF}) async {
    if (left == null || top == null) return;
    AnimationController animationController = AnimationController(
      duration: durationMs,
      vsync: this,
    );
    Tween<Offset> tween = Tween<Offset>(
      begin: Offset(left!, top!),
      end: Offset(left! + hDelta, top! + vDelta),
    );
    Animation<Offset> animation = tween.animate(animationController);
    animation.addListener(() {
      moveTo(animation.value.dx, animation.value.dy);
    });
    movedOrResizedNotifier?.value++;
    await animationController.forward();
    afterAnimationF?.call();
    animationController.dispose();
  }

  void _onDragEnd(DragEndDetails event) {
    //if (preventDrag || !isDraggable || event.localPosition.dy >= (dragHandleHeight ?? 9999)) return;
    if (dragging) {
      rebuild(() {
        var definitelyOnScreen = fca.ensureOnScreen(
          Rect.fromLTWH(
            left!,
            top!,
            _calloutW!,
            dragHandleHeight ?? _calloutH!,
          ),
          _calloutW!,
          0,
        );
        left = definitelyOnScreen.$1;
        top = definitelyOnScreen.$2;
        if (dragging) {
          onDragF?.call(Offset(left!, top!));
          onDragEndedF?.call(Offset(left!, top!));
          // update child overlay(s)
          movedOrResizedNotifier?.value++;
          // _refreshParentStateF(event.position);
        }
      });
      dragging = false;
    }
  }

  Widget _closeButton() =>
      Positioned(
        top: closeButtonPos.dy,
        right: closeButtonPos.dx,
        child: IconButton(
          iconSize: 24,
          icon: Icon(
            Icons.close,
            color: closeButtonColor,
          ),
          onPressed: () {
            onCloseButtonPressF?.call();
            fca.dismiss(cId);
            fca.findCallout<OverlayPortalController>(cId)?.hide();
          },
        ),
      );

  Widget _gotitButton() =>
      Blink(
        animateColor: false,
        child: IconButton(
          tooltip: "got it - don't show again.",
          iconSize: 36,
          icon: const Icon(
            Icons.thumb_up,
            color: Colors.orangeAccent,
          ),
          onPressed: () {
            fca.gotit(cId);
            fca.findCallout<OverlayEntry>(cId)?.remove();
            fca.findCallout<OverlayPortalController>(cId)?.hide();
            onGotitPressedF?.call();
          },
        ),
      );

  Widget _cpi() =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          backgroundColor: fillColor?.flutterValue,
        ),
      );

  Widget _possiblyScrollableContents(Widget contents) =>
      (needsToScrollV || needsToScrollH)
          ? SizedBox(
        width: calloutW,
        height: calloutH,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Hero(tag: 'callout-content', child: contents),
        ),
      )
          : SizedBox(
        width: _calloutW!,
        height: _calloutH!,
        child: contents,
      );

  Widget _createPointingLine() {
    if (calloutAlignment == null && targetAlignment == null) {
      Rect screenRect = Rect.fromLTWH(0, 0, fca.scrW, fca.scrH);
      targetAlignment = -fca.calcTargetAlignmentWithinWrapper(
          wrapperRect: screenRect, targetRect: tR());
      calloutAlignment = -targetAlignment!;
    }

    calcEndpoints();

    if (tE != null && cE != null) {
      Rect r = Rect.fromPoints(
        tE!.asOffset.translate(
          followScroll ? -scrollOffsetX() : 0.0,
          followScroll ? -scrollOffsetY() : 0.0,
        ),
        cE!.asOffset.translate(
          followScroll ? -scrollOffsetX() : 0.0,
          followScroll ? -scrollOffsetY() : 0.0,
        ),
      );
      Offset to = tE!.asOffset.translate(
        -r.left,
        -r.top,
      );
      Offset from = cE!.asOffset.translate(
        -r.left,
        -r.top,
        // )
        // .translate(
        //   followScroll ? -scrollOffsetX() : 0.0,
        //   followScroll ? -scrollOffsetY() : 0.0,
      );
      Line line = Line(Coord.fromOffset(from), Coord.fromOffset(to));
      double lineLen = line.length();
//Rect inflatedTargetRect = targetRect.inflate(separation / 2);
      Rect calloutrect = _calloutRect();
//bool overlaps = calloutrect.overlaps(inflatedTargetRect);
// don't show line if gap between endpoints < specifid separation
      bool veryClose = lineLen <= 30;
      if (veryClose || calloutrect.overlaps(tR())) {
        // fca.logger.i("not drawing pointing line");
        return const Offstage();
      }

// // only show the line if callout does not overlap (padded) target
// if (//targetRect.contains(cE.asOffset) ||
//     (calloutRect().overlaps(targetRect.inflate(50))))
//   return IgnoreP_contentointer(child: Offstage());

      Widget pointingLine = IgnorePointer(
        child: PointingLine(
          arrowType.reverse ? to : from,
          arrowType.reverse ? from : to,
          arrowType,
          arrowColor!.flutterValue,
          lengthDeltaPc: lengthDeltaPc,
          animate: animate,
        ),
      );

// computer pos for line label
//if (lineLabel != null) lineLabelPos = Line(tE,cE).midPoint();

      return Positioned(
        top: r.top,
        left: r.left,
        child: pointingLine,
      );
    } else {
      return const Offstage();
    }
  }

  Widget _createLineLabel() =>
      Positioned(
        top: (tE!.y + cE!.y) / 2,
        left: (tE!.x + cE!.x) / 2,
        child: Material(
          child: lineLabel,
        ),
      );

  Widget _createTargetBorder() {
    // final sh = scrollOffsetX();
    final sv = scrollOffsetY();
    final tr = tR();
    //.translate(-scrollOffsetX(), -scrollOffsetY());
    final top = tr.top; //+sv;
    final left = tr.left; //+sh;
    print('scrollOffset: $sv, tr.top: ${tr.top} pos top: $top');
    return Positioned(
      left: left,
      top: top,
      child: Material(
        color: Colors.yellow.withValues(alpha: .3),
        child: GestureDetector(
          onTap: onBarrierTap,
          child: Container(
            color: Colors.transparent,
            width: tr.width,
            height: tr.height,
          ),
        ),
      ),
    );
  }

//   Widget _createConfigToolbar(Side side) {
//     Widget toolbar = CalloutConfigToolbar(
//       zoomer: _zoomer!,
//       side: Side.TOP,
//       parent: this,
//       onParentBarrierTappedF: barrier?.onTappedF ??
//           () {
//             //fca.logger.i("missing onParentBarrierTappedF!");
//           },
//     );
// // toolbar = Container(width: 500, height:  20, color: Colors.red,);
//     return toolbar;
//   }

  Widget _createBarrier() {
    final tr = tR();
    if (barrier!.excludeTargetFromBarrier && tr.size != Size.zero) {
      return ModalBarrierWithCutout(
        cutoutRect: tr,
        round: barrier!.roundExclusion,
        color: barrier!.color.withValues(alpha: barrier!.opacity),
        opacity: barrier!.opacity,
        dismissible: barrier?.dismissible ?? true,
        onDismiss: onBarrierTap,
      );
    }
    return ModalBarrier(
      color: barrier!.color.withValues(alpha: barrier!.opacity),
      dismissible: barrier?.dismissible ?? true,
      onDismiss: onBarrierTap,
    );
  }

  void onBarrierTap() {
    if (barrier?.closeOnTapped ?? false) {
      if (opDescendantContext != null) {
        WrappedCalloutState? state = WrappedCallout.of(opDescendantContext!);
        state?.hideOP();
        onDismissedF?.call();
      } else {
        fca.dismiss(cId);
      }
    } else if (barrier?.hideOnTapped ?? false) {
      if (opDescendantContext != null) {
        WrappedCalloutState? state = WrappedCallout.of(opDescendantContext!);
        state?.hideOP();
        onHiddenF?.call();
      } else {
        fca.hide(cId);
        onHiddenF?.call();
      }
    }
    barrier?.onTappedF?.call();
  }

//   Widget _createBarrierOLD() => Positioned.fill(
//           child: PointerInterceptor(
//         child: IgnorePointer(
//           ignoring: !(modal || barrier!.closeOnTapped),
//           child: Listener(
//               behavior: HitTestBehavior.translucent,
//               onPointerUp: (_) {
//                 if (barrier!.closeOnTapped) {
//                   if (opDescendantContext != null) {
//                     CalloutState? state = fca.of(opDescendantContext!);
//                     state?.hideOP();
//                   } else {
//                     fca.dismiss(feature);
//                   }
//                 }
//                 barrier!.onTappedF?.call();
//               },
// // barrier now never tappable, because no way to pass taps through to lower widget, such as a button outside of the callout
// // onPointerDown: (_) {
// //   barrierTapped = true;
// //   completed(false);
// //   onBarrierTappedF?.call();
// // },
//               child: !kIsWeb && tR() != null
//                   ? ColorFiltered(
//                       colorFilter: ColorFilter.mode(Colors.black.withValues(alpha:barrier!.opacity), BlendMode.srcOut),
//                       child: Container(
//                         decoration: const BoxDecoration(
//                           color: Colors.transparent,
//                         ),
//                         child: Stack(
//                           children: [
//                             Positioned(
//                               top: tR().top - barrier!.holePadding - (vScrollController?.offset ?? 0.0),
//                               left: tR().left - barrier!.holePadding - (hScrollController?.offset ?? 0.0),
//                               child: Container(
//                                 height: tR().height + barrier!.holePadding * 2,
//                                 width: tR().width + barrier!.holePadding * 2,
//                                 decoration: BoxDecoration(
//                                   boxShadow: const [
//                                     BoxShadow(
//                                       color: Colors.red,
//                                       blurRadius: 5.0,
//                                       spreadRadius: 2.0,
//                                     ),
//                                   ],
//                                   color: Colors.black,
// // Color does not matter but should not be transparent
//                                   borderRadius:
//                                       barrier!.hasCircularHole ? BorderRadius.circular(tR().height / 2 + barrier!.holePadding) : BorderRadius.zero,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   : barrier!.gradientColors?.isNotEmpty ?? false
//                       ? Container(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               end: Alignment.topCenter,
//                               begin: Alignment.bottomCenter,
//                               colors: barrier!.gradientColors!,
//                             ),
//                           ),
//                         )
//                       : Container(
//                           color: Colors.black.withValues(alpha:barrier!.opacity),
//                         )
// //     : ClipPath(
// //   clipper: DarkScreenWithHolePainter1(tR, barrierOpacity, padding: barrierHolePadding, round: barrierHasCircularHole),
// //   child: Container(
// //     color: Colors.black.withValues(alpha:barrierOpacity),
// //   ),
// // )
// // CustomPaint(
// //     size: Size(screenW, screenH),
// //     painter: DarkScreenWithHolePainter2(tR, barrierOpacity, padding: barrierHolePadding, round: barrierHasCircularHole)
// // )
// // TweenAnimationBuilder<Color>(
// //   duration: kThemeAnimationDuration,
// //   tween: ColorTween(
// //     begin: Colors.transparent,
// //     end: barrierOpacity != null ? Colors.black.withValues(alpha:barrierOpacity) : Colors.transparent,
// //   ),
// //   builder: (context, color, child) {
// //     return ColoredBox(color: color);
// //   },
// // ),
//               ),
//         ),
//       ));

  Rect _calloutRect() =>
      Rect.fromLTWH(left ?? 0.0, top ?? 0.0,
          _calloutW ?? double.infinity, _calloutH ?? double.infinity);

// Offset _calloutCentre() => _calloutRect().center;

// return target rectangle if target found, otherwise null
  void calcEndpoints() {
    // allow for possible transform and cutout padding
    final tr = tR();

    Offset tCentre = tr.center;
    Rectangle scrollAwareCR = Rectangle.fromRect(cR());
    Offset cCentre = scrollAwareCR.center;
    Line line = Line.fromOffsets(cCentre, tCentre);
    tE = Rectangle.getTargetIntersectionPoint2(
        Coord.fromOffset(cCentre), line, Rectangle.fromRect(tr));
    // if (tE == null) {
    //   print('FUCK tE null!');
    // }
    cE = Rectangle.getTargetIntersectionPoint2(
        Coord.fromOffset(tCentre), line, scrollAwareCR);
    // if (cE == null) print('FUCK cE null!');
    if (toDelta != null && toDelta != 0.0) {
      tE = Coord.changeDistanceBetweenPoints(cE, tE, toDelta);
    }
    if (fromDelta != null && fromDelta != 0.0) {
      cE = Coord.changeDistanceBetweenPoints(tE, cE, fromDelta);
    }
  }

  void rebuild(VoidCallback? f) {
    f?.call();
    _rebuildOverlayEntryF?.call();
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }

// void redraw() {
//   if (_cachedCalloutContent == null || _rebuildOverlayEntryF == null) return;
//   oeContentWidget(
//     targetRect: tR(),
//     calloutContent: _cachedCalloutContent!,
//     rebuildF: _rebuildOverlayEntryF!,
//   );
// }
}

class CalloutBarrierConfig {
  final bool closeOnTapped;
  final bool hideOnTapped;
  final VoidCallback? onTappedF;
  double opacity;
  Color color;
  bool excludeTargetFromBarrier;
  final double cutoutPadding;

  // create a circular hole in the barrier? false means rectangular
  bool roundExclusion;
  final bool dismissible;

  CalloutBarrierConfig({
    this.closeOnTapped = true,
    this.hideOnTapped = false,
    this.onTappedF,
    this.opacity = 0.5,
    this.color = Colors.black,
    this.excludeTargetFromBarrier = false,
    this.cutoutPadding = 0.0,
    this.roundExclusion = false,
    this.dismissible = true,
  });
}

class PositionedBoxContent extends StatelessWidget {
  final CalloutConfigModel calloutConfig;
  final Widget child;

  const PositionedBoxContent(this.calloutConfig,
      this.child, {
        super.key,
      });

  static PositionedBoxContent? of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<PositionedBoxContent>();

  @override
  Widget build(BuildContext context) {
    final CalloutConfigModel cc = calloutConfig;

    if (cc.initialCalloutPos == null &&
        cc.calloutAlignment == null &&
        cc.targetAlignment == null) {
      Rect screenRect = Rect.fromLTWH(0, 0, fca.scrW, fca.scrH);
      cc.targetAlignment = -fca.calcTargetAlignmentWithinWrapper(
          wrapperRect: screenRect, targetRect: cc.tR());
      cc.calloutAlignment = -cc.targetAlignment!;
    }

    // var decoration = cc.decorationShape.toDecoration(
    //   fillColorValues: ColorValues(color1Value: cc.fillColor?.value),
    //   borderColorValues: ColorValues(color1Value: cc.borderColor?.value),
    //   borderRadius: cc.borderRadius,
    //   thickness: cc.borderThickness,
    //   starPoints: cc.starPoints,
    // );
    // ShapeBorder? sb;
    // if (decoration is ShapeDecoration) {
    //   final ob = decoration;
    //   sb = ob.shape;
    // }

    return Positioned(
        top: (cc.followScroll ? -cc.scrollOffsetY() : 0.0) +
            (cc.top ?? 0) +
            (cc.contentTranslateY ?? 0.0),
        left: (cc.followScroll ? -cc.scrollOffsetX() : 0.0) +
            (cc.left ?? 0) +
            (cc.contentTranslateX ?? 0.0),
        child: GestureDetector(
          onTap: () {
            fca.logger.i('PositionedBoxContent onTap');
          },
          // onTapDown: cc._onContentPointerDown,
          onPanStart: cc._onDragStart,
          onPanUpdate: cc._onDragMove,
          onPanEnd: cc._onDragEnd,
          onPanCancel: () {
            cc._onDragEnd(DragEndDetails());
          },
          // child: TransparentPointer(
          child: Container(
            decoration: cc.decorationShape.toDecoration(
              upTo6FillColors: UpTo6Colors(color1: cc.fillColor),
              upTo6BorderColors: UpTo6Colors(color1: cc.borderColor),
              borderRadius: cc.borderRadius,
              thickness: cc.borderThickness,
              starPoints: cc.starPoints,
            ),

            // decoration: ShapeDecoration(
            //   shape: outlinedBorderGroup!.outlinedBorderType!.toFlutterWidget(nodeSide: outlinedBorderGroup?.side, nodeRadius: borderRadius),
            //   color: fillColor1Value != null ? Color(fillColor1Value!) : null,
            // ),
            //width: cc._calloutW,
            //height: cc._calloutH,
            child: Material(
              type: cc.elevation > 0
                  ? MaterialType.canvas
                  : MaterialType.transparency,
              color: cc.fillColor?.flutterValue,
              elevation: cc.elevation,
              shape: RoundedRectangleBorder(
                // Optional: customize border shape
                borderRadius: BorderRadius.circular(cc.borderRadius),
              ),
              // cc.elevation,
              child: FocusableActionDetector(
                focusNode: calloutConfig.focusNode,
                autofocus: true,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: cc.showGotitButton
                          ? Flex(
                        direction: cc.gotitAxis ?? Axis.horizontal,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: calloutContent(cc),
                          ),
                          if (cc.gotitAxis != null && !cc.showcpi)
                            cc._gotitButton(),
                          if (cc.showcpi) cc._cpi(),
                        ],
                      )
                          : calloutContent(cc),
                    ),
                    if (cc.showCloseButton) cc._closeButton(),
                  ],
                ),
              ),
            ),
          ), // TRUE means treat as invisible, and pass events down below
//             child: Material(
//               // shape: const StarBorder(
//               //   side: BorderSide(color: Colors.black, width: 3),
//               //   points: 7,
//               //   // innerRadiusRatio: _model.innerRadiusRatio,
//               //   // pointRounding: _model.pointRounding,
//               //   // valleyRounding: _model.valleyRounding,
//               //   // rotation: 0,
//               // ),
//               shape: sb,
//               color: cc.fillColor,
//               type: MaterialType
//                   .transparency, //roundedCorners > 0 ? MaterialType.card : MaterialType.canvas,
//               borderRadius: sb != null ? null : BorderRadius.all(Radius.circular(cc.borderRadius)),
//               // child: MediaQuery(
//               //   data: MediaQuery.of(context).copyWith(
//               //     boldText: false,
//               //     textScaler: const TextScaler.linear(1.0),
//               //   ),
//               child: SizedBox(
//                 width: cc._calloutW!.abs(),
// // - (gotitAxis == Axis.horizontal ? 50 : 0),
//                 height: cc._calloutH!.abs(),
// // - (gotitAxis == Axis.vertical ? 50 : 0),
// //                 decoration: calloutConfig.circleShape
// //                     ? const BoxDecoration(
// //                         color: FUCHSIA_X, shape: BoxShape.circle)
// //                     : BoxDecoration(
// //                         color: cc.fillColor,
// //                         borderRadius:
// //                             BorderRadius.all(Radius.circular(cc.borderRadius)),
// //                         boxShadow: const [
// //                           BoxShadow(
// //                               color: Colors.black12,
// //                               blurRadius: 7,
// //                               spreadRadius: 9),
// //                         ],
// //                       ),
//           ),
        ));
  }

  Widget calloutContent(CalloutConfigModel cc) =>
      cc.draggable
          ? MouseRegion(
        cursor: SystemMouseCursors.grab,
        child: cc._possiblyScrollableContents(child),
      )
          : cc._possiblyScrollableContents(child);
}
