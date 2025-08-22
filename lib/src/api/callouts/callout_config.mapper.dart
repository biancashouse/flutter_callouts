// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'callout_config.dart';

class CalloutConfigModelMapper extends ClassMapperBase<CalloutConfigModel> {
  CalloutConfigModelMapper._();

  static CalloutConfigModelMapper? _instance;
  static CalloutConfigModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CalloutConfigModelMapper._());
      AlignmentEnumMapper.ensureInitialized();
      ColorModelMapper.ensureInitialized();
      DecorationShapeEnumMapper.ensureInitialized();
      ArrowTypeEnumMapper.ensureInitialized();
      OffsetModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CalloutConfigModel';

  static String _$cId(CalloutConfigModel v) => v.cId;
  static const Field<CalloutConfigModel, String> _f$cId = Field('cId', _$cId);
  static GlobalKey<State<StatefulWidget>>? _$callerGK(CalloutConfigModel v) =>
      v.callerGK;
  static const Field<CalloutConfigModel, GlobalKey<State<StatefulWidget>>>
  _f$callerGK = Field('callerGK', _$callerGK, opt: true);
  static ValueNotifier<int>? _$movedOrResizedNotifier(CalloutConfigModel v) =>
      v.movedOrResizedNotifier;
  static const Field<CalloutConfigModel, ValueNotifier<int>>
  _f$movedOrResizedNotifier = Field(
    'movedOrResizedNotifier',
    _$movedOrResizedNotifier,
    opt: true,
  );
  static AlignmentEnum? _$gravity(CalloutConfigModel v) => v.gravity;
  static const Field<CalloutConfigModel, AlignmentEnum> _f$gravity = Field(
    'gravity',
    _$gravity,
    opt: true,
  );
  static String? _$scrollControllerName(CalloutConfigModel v) =>
      v.scrollControllerName;
  static const Field<CalloutConfigModel, String> _f$scrollControllerName =
      Field('scrollControllerName', _$scrollControllerName);
  static bool _$followScroll(CalloutConfigModel v) => v.followScroll;
  static const Field<CalloutConfigModel, bool> _f$followScroll = Field(
    'followScroll',
    _$followScroll,
    opt: true,
    def: true,
  );
  static bool _$forceMeasure(CalloutConfigModel v) => v.forceMeasure;
  static const Field<CalloutConfigModel, bool> _f$forceMeasure = Field(
    'forceMeasure',
    _$forceMeasure,
    opt: true,
    def: false,
  );
  static double? _$initialCalloutW(CalloutConfigModel v) => v.initialCalloutW;
  static const Field<CalloutConfigModel, double> _f$initialCalloutW = Field(
    'initialCalloutW',
    _$initialCalloutW,
    opt: true,
  );
  static double? _$initialCalloutH(CalloutConfigModel v) => v.initialCalloutH;
  static const Field<CalloutConfigModel, double> _f$initialCalloutH = Field(
    'initialCalloutH',
    _$initialCalloutH,
    opt: true,
  );
  static double? _$minWidth(CalloutConfigModel v) => v.minWidth;
  static const Field<CalloutConfigModel, double> _f$minWidth = Field(
    'minWidth',
    _$minWidth,
    opt: true,
  );
  static double? _$minHeight(CalloutConfigModel v) => v.minHeight;
  static const Field<CalloutConfigModel, double> _f$minHeight = Field(
    'minHeight',
    _$minHeight,
    opt: true,
  );
  static ColorModel? _$fillColor(CalloutConfigModel v) => v.fillColor;
  static const Field<CalloutConfigModel, ColorModel> _f$fillColor = Field(
    'fillColor',
    _$fillColor,
    opt: true,
  );
  static DecorationShapeEnum _$decorationShape(CalloutConfigModel v) =>
      v.decorationShape;
  static const Field<CalloutConfigModel, DecorationShapeEnum>
  _f$decorationShape = Field(
    'decorationShape',
    _$decorationShape,
    opt: true,
    def: DecorationShapeEnum.rectangle,
  );
  static ColorModel? _$borderColor(CalloutConfigModel v) => v.borderColor;
  static const Field<CalloutConfigModel, ColorModel> _f$borderColor = Field(
    'borderColor',
    _$borderColor,
    opt: true,
  );
  static double _$borderRadius(CalloutConfigModel v) => v.borderRadius;
  static const Field<CalloutConfigModel, double> _f$borderRadius = Field(
    'borderRadius',
    _$borderRadius,
    opt: true,
    def: 0,
  );
  static double _$borderThickness(CalloutConfigModel v) => v.borderThickness;
  static const Field<CalloutConfigModel, double> _f$borderThickness = Field(
    'borderThickness',
    _$borderThickness,
    opt: true,
    def: 0,
  );
  static int? _$starPoints(CalloutConfigModel v) => v.starPoints;
  static const Field<CalloutConfigModel, int> _f$starPoints = Field(
    'starPoints',
    _$starPoints,
    opt: true,
  );
  static double _$lengthDeltaPc(CalloutConfigModel v) => v.lengthDeltaPc;
  static const Field<CalloutConfigModel, double> _f$lengthDeltaPc = Field(
    'lengthDeltaPc',
    _$lengthDeltaPc,
    opt: true,
    def: 0.95,
  );
  static double? _$contentTranslateX(CalloutConfigModel v) =>
      v.contentTranslateX;
  static const Field<CalloutConfigModel, double> _f$contentTranslateX = Field(
    'contentTranslateX',
    _$contentTranslateX,
    opt: true,
  );
  static double? _$contentTranslateY(CalloutConfigModel v) =>
      v.contentTranslateY;
  static const Field<CalloutConfigModel, double> _f$contentTranslateY = Field(
    'contentTranslateY',
    _$contentTranslateY,
    opt: true,
  );
  static double? _$targetTranslateX(CalloutConfigModel v) => v.targetTranslateX;
  static const Field<CalloutConfigModel, double> _f$targetTranslateX = Field(
    'targetTranslateX',
    _$targetTranslateX,
    opt: true,
  );
  static double? _$targetTranslateY(CalloutConfigModel v) => v.targetTranslateY;
  static const Field<CalloutConfigModel, double> _f$targetTranslateY = Field(
    'targetTranslateY',
    _$targetTranslateY,
    opt: true,
  );
  static ArrowTypeEnum _$arrowType(CalloutConfigModel v) => v.arrowType;
  static const Field<CalloutConfigModel, ArrowTypeEnum> _f$arrowType = Field(
    'arrowType',
    _$arrowType,
    opt: true,
    def: ArrowTypeEnum.THIN,
  );
  static ColorModel? _$arrowColor(CalloutConfigModel v) => v.arrowColor;
  static const Field<CalloutConfigModel, ColorModel> _f$arrowColor = Field(
    'arrowColor',
    _$arrowColor,
    opt: true,
  );
  static CalloutBarrierConfig? _$barrier(CalloutConfigModel v) => v.barrier;
  static const Field<CalloutConfigModel, CalloutBarrierConfig> _f$barrier =
      Field('barrier', _$barrier, opt: true);
  static bool _$modal(CalloutConfigModel v) => v.modal;
  static const Field<CalloutConfigModel, bool> _f$modal = Field(
    'modal',
    _$modal,
    opt: true,
    def: false,
  );
  static bool _$showCloseButton(CalloutConfigModel v) => v.showCloseButton;
  static const Field<CalloutConfigModel, bool> _f$showCloseButton = Field(
    'showCloseButton',
    _$showCloseButton,
    opt: true,
    def: false,
  );
  static Offset _$closeButtonPos(CalloutConfigModel v) => v.closeButtonPos;
  static const Field<CalloutConfigModel, Offset> _f$closeButtonPos = Field(
    'closeButtonPos',
    _$closeButtonPos,
    opt: true,
    def: const Offset(10, 10),
  );
  static Function? _$onCloseButtonPressF(CalloutConfigModel v) =>
      (v as dynamic).onCloseButtonPressF as Function?;
  static dynamic _arg$onCloseButtonPressF(f) => f<void Function()>();
  static const Field<CalloutConfigModel, Function?> _f$onCloseButtonPressF =
      Field(
        'onCloseButtonPressF',
        _$onCloseButtonPressF,
        opt: true,
        arg: _arg$onCloseButtonPressF,
      );
  static Color _$closeButtonColor(CalloutConfigModel v) => v.closeButtonColor;
  static const Field<CalloutConfigModel, Color> _f$closeButtonColor = Field(
    'closeButtonColor',
    _$closeButtonColor,
    opt: true,
    def: Colors.red,
  );
  static AlignmentEnum? _$initialTargetAlignment(CalloutConfigModel v) =>
      v.initialTargetAlignment;
  static const Field<CalloutConfigModel, AlignmentEnum>
  _f$initialTargetAlignment = Field(
    'initialTargetAlignment',
    _$initialTargetAlignment,
    opt: true,
  );
  static AlignmentEnum? _$initialCalloutAlignment(CalloutConfigModel v) =>
      v.initialCalloutAlignment;
  static const Field<CalloutConfigModel, AlignmentEnum>
  _f$initialCalloutAlignment = Field(
    'initialCalloutAlignment',
    _$initialCalloutAlignment,
    opt: true,
  );
  static OffsetModel? _$initialCalloutPos(CalloutConfigModel v) =>
      v.initialCalloutPos;
  static const Field<CalloutConfigModel, OffsetModel> _f$initialCalloutPos =
      Field('initialCalloutPos', _$initialCalloutPos, opt: true);
  static bool _$animate(CalloutConfigModel v) => v.animate;
  static const Field<CalloutConfigModel, bool> _f$animate = Field(
    'animate',
    _$animate,
    opt: true,
    def: false,
  );
  static double? _$toDelta(CalloutConfigModel v) => v.toDelta;
  static const Field<CalloutConfigModel, double> _f$toDelta = Field(
    'toDelta',
    _$toDelta,
    opt: true,
  );
  static double? _$fromDelta(CalloutConfigModel v) => v.fromDelta;
  static const Field<CalloutConfigModel, double> _f$fromDelta = Field(
    'fromDelta',
    _$fromDelta,
    opt: true,
  );
  static Widget? _$lineLabel(CalloutConfigModel v) => v.lineLabel;
  static const Field<CalloutConfigModel, Widget> _f$lineLabel = Field(
    'lineLabel',
    _$lineLabel,
    opt: true,
  );
  static bool _$frameTarget(CalloutConfigModel v) => v.frameTarget;
  static const Field<CalloutConfigModel, bool> _f$frameTarget = Field(
    'frameTarget',
    _$frameTarget,
    opt: true,
    def: false,
  );
  static double _$scaleTarget(CalloutConfigModel v) => v.scaleTarget;
  static const Field<CalloutConfigModel, double> _f$scaleTarget = Field(
    'scaleTarget',
    _$scaleTarget,
    opt: true,
    def: 1.0,
  );
  static bool _$noBorder(CalloutConfigModel v) => v.noBorder;
  static const Field<CalloutConfigModel, bool> _f$noBorder = Field(
    'noBorder',
    _$noBorder,
    opt: true,
    def: false,
  );
  static double _$elevation(CalloutConfigModel v) => v.elevation;
  static const Field<CalloutConfigModel, double> _f$elevation = Field(
    'elevation',
    _$elevation,
    opt: true,
    def: 0,
  );
  static bool _$circleShape(CalloutConfigModel v) => v.circleShape;
  static const Field<CalloutConfigModel, bool> _f$circleShape = Field(
    'circleShape',
    _$circleShape,
    opt: true,
    def: false,
  );
  static double? _$dragHandleHeight(CalloutConfigModel v) => v.dragHandleHeight;
  static const Field<CalloutConfigModel, double> _f$dragHandleHeight = Field(
    'dragHandleHeight',
    _$dragHandleHeight,
    opt: true,
  );
  static bool _$draggable(CalloutConfigModel v) => v.draggable;
  static const Field<CalloutConfigModel, bool> _f$draggable = Field(
    'draggable',
    _$draggable,
    opt: true,
    def: true,
  );
  static bool _$canToggleDraggable(CalloutConfigModel v) =>
      v.canToggleDraggable;
  static const Field<CalloutConfigModel, bool> _f$canToggleDraggable = Field(
    'canToggleDraggable',
    _$canToggleDraggable,
    opt: true,
    def: false,
  );
  static Function? _$onDragF(CalloutConfigModel v) =>
      (v as dynamic).onDragF as Function?;
  static dynamic _arg$onDragF(f) => f<void Function(Offset)>();
  static const Field<CalloutConfigModel, Function?> _f$onDragF = Field(
    'onDragF',
    _$onDragF,
    opt: true,
    arg: _arg$onDragF,
  );
  static Function? _$onDragEndedF(CalloutConfigModel v) =>
      (v as dynamic).onDragEndedF as Function?;
  static dynamic _arg$onDragEndedF(f) => f<void Function(Offset)>();
  static const Field<CalloutConfigModel, Function?> _f$onDragEndedF = Field(
    'onDragEndedF',
    _$onDragEndedF,
    opt: true,
    arg: _arg$onDragEndedF,
  );
  static Function? _$onDragStartedF(CalloutConfigModel v) =>
      (v as dynamic).onDragStartedF as Function?;
  static dynamic _arg$onDragStartedF(f) => f<void Function()>();
  static const Field<CalloutConfigModel, Function?> _f$onDragStartedF = Field(
    'onDragStartedF',
    _$onDragStartedF,
    opt: true,
    arg: _arg$onDragStartedF,
  );
  static bool _$skipOnScreenCheck(CalloutConfigModel v) => v.skipOnScreenCheck;
  static const Field<CalloutConfigModel, bool> _f$skipOnScreenCheck = Field(
    'skipOnScreenCheck',
    _$skipOnScreenCheck,
    opt: true,
    def: false,
  );
  static bool _$resizeableH(CalloutConfigModel v) => v.resizeableH;
  static const Field<CalloutConfigModel, bool> _f$resizeableH = Field(
    'resizeableH',
    _$resizeableH,
    opt: true,
    def: false,
  );
  static bool _$resizeableV(CalloutConfigModel v) => v.resizeableV;
  static const Field<CalloutConfigModel, bool> _f$resizeableV = Field(
    'resizeableV',
    _$resizeableV,
    opt: true,
    def: false,
  );
  static Function? _$onResizeF(CalloutConfigModel v) =>
      (v as dynamic).onResizeF as Function?;
  static dynamic _arg$onResizeF(f) => f<void Function(Size)>();
  static const Field<CalloutConfigModel, Function?> _f$onResizeF = Field(
    'onResizeF',
    _$onResizeF,
    opt: true,
    arg: _arg$onResizeF,
  );
  static Color? _$draggableColor(CalloutConfigModel v) => v.draggableColor;
  static const Field<CalloutConfigModel, Color> _f$draggableColor = Field(
    'draggableColor',
    _$draggableColor,
    opt: true,
  );
  static bool _$showGotitButton(CalloutConfigModel v) => v.showGotitButton;
  static const Field<CalloutConfigModel, bool> _f$showGotitButton = Field(
    'showGotitButton',
    _$showGotitButton,
    opt: true,
    def: false,
  );
  static Axis? _$gotitAxis(CalloutConfigModel v) => v.gotitAxis;
  static const Field<CalloutConfigModel, Axis> _f$gotitAxis = Field(
    'gotitAxis',
    _$gotitAxis,
    opt: true,
  );
  static Function? _$onGotitPressedF(CalloutConfigModel v) =>
      (v as dynamic).onGotitPressedF as Function?;
  static const Field<CalloutConfigModel, Function> _f$onGotitPressedF = Field(
    'onGotitPressedF',
    _$onGotitPressedF,
    opt: true,
  );
  static bool _$showcpi(CalloutConfigModel v) => v.showcpi;
  static const Field<CalloutConfigModel, bool> _f$showcpi = Field(
    'showcpi',
    _$showcpi,
    opt: true,
    def: false,
  );
  static bool? _$onlyOnce(CalloutConfigModel v) => v.onlyOnce;
  static const Field<CalloutConfigModel, bool> _f$onlyOnce = Field(
    'onlyOnce',
    _$onlyOnce,
    opt: true,
  );
  static bool _$containsTextField(CalloutConfigModel v) => v.containsTextField;
  static const Field<CalloutConfigModel, bool> _f$containsTextField = Field(
    'containsTextField',
    _$containsTextField,
    opt: true,
    def: false,
  );
  static bool _$alwaysReCalcSize(CalloutConfigModel v) => v.alwaysReCalcSize;
  static const Field<CalloutConfigModel, bool> _f$alwaysReCalcSize = Field(
    'alwaysReCalcSize',
    _$alwaysReCalcSize,
    opt: true,
    def: false,
  );
  static bool _$ignoreCalloutResult(CalloutConfigModel v) =>
      v.ignoreCalloutResult;
  static const Field<CalloutConfigModel, bool> _f$ignoreCalloutResult = Field(
    'ignoreCalloutResult',
    _$ignoreCalloutResult,
    opt: true,
    def: false,
  );
  static double? _$finalSeparation(CalloutConfigModel v) => v.finalSeparation;
  static const Field<CalloutConfigModel, double> _f$finalSeparation = Field(
    'finalSeparation',
    _$finalSeparation,
    opt: true,
  );
  static Function? _$onDismissedF(CalloutConfigModel v) =>
      (v as dynamic).onDismissedF as Function?;
  static dynamic _arg$onDismissedF(f) => f<void Function()>();
  static const Field<CalloutConfigModel, Function?> _f$onDismissedF = Field(
    'onDismissedF',
    _$onDismissedF,
    opt: true,
    arg: _arg$onDismissedF,
  );
  static Function? _$onTickedF(CalloutConfigModel v) =>
      (v as dynamic).onTickedF as Function?;
  static dynamic _arg$onTickedF(f) => f<void Function(String)>();
  static const Field<CalloutConfigModel, Function?> _f$onTickedF = Field(
    'onTickedF',
    _$onTickedF,
    opt: true,
    arg: _arg$onTickedF,
  );
  static Function? _$onHiddenF(CalloutConfigModel v) =>
      (v as dynamic).onHiddenF as Function?;
  static dynamic _arg$onHiddenF(f) => f<void Function()>();
  static const Field<CalloutConfigModel, Function?> _f$onHiddenF = Field(
    'onHiddenF',
    _$onHiddenF,
    opt: true,
    arg: _arg$onHiddenF,
  );
  static Function? _$onAcceptedF(CalloutConfigModel v) =>
      (v as dynamic).onAcceptedF as Function?;
  static dynamic _arg$onAcceptedF(f) => f<void Function()>();
  static const Field<CalloutConfigModel, Function?> _f$onAcceptedF = Field(
    'onAcceptedF',
    _$onAcceptedF,
    opt: true,
    arg: _arg$onAcceptedF,
  );
  static bool _$notUsingHydratedStorage(CalloutConfigModel v) =>
      v.notUsingHydratedStorage;
  static const Field<CalloutConfigModel, bool> _f$notUsingHydratedStorage =
      Field(
        'notUsingHydratedStorage',
        _$notUsingHydratedStorage,
        opt: true,
        def: false,
      );
  static Alignment? _$targetAlignment(CalloutConfigModel v) =>
      v.targetAlignment;
  static const Field<CalloutConfigModel, Alignment> _f$targetAlignment = Field(
    'targetAlignment',
    _$targetAlignment,
    mode: FieldMode.member,
  );
  static Alignment? _$calloutAlignment(CalloutConfigModel v) =>
      v.calloutAlignment;
  static const Field<CalloutConfigModel, Alignment> _f$calloutAlignment = Field(
    'calloutAlignment',
    _$calloutAlignment,
    mode: FieldMode.member,
  );
  static double _$draggableEdgeThickness(CalloutConfigModel v) =>
      v.draggableEdgeThickness;
  static const Field<CalloutConfigModel, double> _f$draggableEdgeThickness =
      Field(
        'draggableEdgeThickness',
        _$draggableEdgeThickness,
        mode: FieldMode.member,
      );
  static bool _$initialised(CalloutConfigModel v) => v.initialised;
  static const Field<CalloutConfigModel, bool> _f$initialised = Field(
    'initialised',
    _$initialised,
    mode: FieldMode.member,
  );
  static FocusNode _$focusNode(CalloutConfigModel v) => v.focusNode;
  static const Field<CalloutConfigModel, FocusNode> _f$focusNode = Field(
    'focusNode',
    _$focusNode,
    mode: FieldMode.member,
  );
  static BuildContext? _$opDescendantContext(CalloutConfigModel v) =>
      v.opDescendantContext;
  static const Field<CalloutConfigModel, BuildContext> _f$opDescendantContext =
      Field(
        'opDescendantContext',
        _$opDescendantContext,
        mode: FieldMode.member,
      );
  static OverlayEntry? _$offstageEntry(CalloutConfigModel v) => v.offstageEntry;
  static const Field<CalloutConfigModel, OverlayEntry> _f$offstageEntry = Field(
    'offstageEntry',
    _$offstageEntry,
    mode: FieldMode.member,
  );
  static double? _$top(CalloutConfigModel v) => v.top;
  static const Field<CalloutConfigModel, double> _f$top = Field(
    'top',
    _$top,
    mode: FieldMode.member,
  );
  static double? _$left(CalloutConfigModel v) => v.left;
  static const Field<CalloutConfigModel, double> _f$left = Field(
    'left',
    _$left,
    mode: FieldMode.member,
  );
  static DraggableEdge_OP? _$topEdge(CalloutConfigModel v) => v.topEdge;
  static const Field<CalloutConfigModel, DraggableEdge_OP> _f$topEdge = Field(
    'topEdge',
    _$topEdge,
    mode: FieldMode.member,
  );
  static DraggableEdge_OP? _$leftEdge(CalloutConfigModel v) => v.leftEdge;
  static const Field<CalloutConfigModel, DraggableEdge_OP> _f$leftEdge = Field(
    'leftEdge',
    _$leftEdge,
    mode: FieldMode.member,
  );
  static DraggableEdge_OP? _$bottomEdge(CalloutConfigModel v) => v.bottomEdge;
  static const Field<CalloutConfigModel, DraggableEdge_OP> _f$bottomEdge =
      Field('bottomEdge', _$bottomEdge, mode: FieldMode.member);
  static DraggableEdge_OP? _$rightEdge(CalloutConfigModel v) => v.rightEdge;
  static const Field<CalloutConfigModel, DraggableEdge_OP> _f$rightEdge = Field(
    'rightEdge',
    _$rightEdge,
    mode: FieldMode.member,
  );
  static DraggableCorner_OP? _$topLeftCorner(CalloutConfigModel v) =>
      v.topLeftCorner;
  static const Field<CalloutConfigModel, DraggableCorner_OP> _f$topLeftCorner =
      Field('topLeftCorner', _$topLeftCorner, mode: FieldMode.member);
  static DraggableCorner_OP? _$topRightCorner(CalloutConfigModel v) =>
      v.topRightCorner;
  static const Field<CalloutConfigModel, DraggableCorner_OP> _f$topRightCorner =
      Field('topRightCorner', _$topRightCorner, mode: FieldMode.member);
  static DraggableCorner_OP? _$bottomLeftCorner(CalloutConfigModel v) =>
      v.bottomLeftCorner;
  static const Field<CalloutConfigModel, DraggableCorner_OP>
  _f$bottomLeftCorner = Field(
    'bottomLeftCorner',
    _$bottomLeftCorner,
    mode: FieldMode.member,
  );
  static DraggableCorner_OP? _$bottomRightCorner(CalloutConfigModel v) =>
      v.bottomRightCorner;
  static const Field<CalloutConfigModel, DraggableCorner_OP>
  _f$bottomRightCorner = Field(
    'bottomRightCorner',
    _$bottomRightCorner,
    mode: FieldMode.member,
  );
  static Coord? _$lineLabelPos(CalloutConfigModel v) => v.lineLabelPos;
  static const Field<CalloutConfigModel, Coord> _f$lineLabelPos = Field(
    'lineLabelPos',
    _$lineLabelPos,
    mode: FieldMode.member,
  );
  static bool _$isHidden(CalloutConfigModel v) => v.isHidden;
  static const Field<CalloutConfigModel, bool> _f$isHidden = Field(
    'isHidden',
    _$isHidden,
    mode: FieldMode.member,
  );
  static bool _$needsToScrollH(CalloutConfigModel v) => v.needsToScrollH;
  static const Field<CalloutConfigModel, bool> _f$needsToScrollH = Field(
    'needsToScrollH',
    _$needsToScrollH,
    mode: FieldMode.member,
  );
  static bool _$needsToScrollV(CalloutConfigModel v) => v.needsToScrollV;
  static const Field<CalloutConfigModel, bool> _f$needsToScrollV = Field(
    'needsToScrollV',
    _$needsToScrollV,
    mode: FieldMode.member,
  );
  static Offset _$dragCalloutOffset(CalloutConfigModel v) =>
      v.dragCalloutOffset;
  static const Field<CalloutConfigModel, Offset> _f$dragCalloutOffset = Field(
    'dragCalloutOffset',
    _$dragCalloutOffset,
    mode: FieldMode.member,
  );
  static bool _$dragging(CalloutConfigModel v) => v.dragging;
  static const Field<CalloutConfigModel, bool> _f$dragging = Field(
    'dragging',
    _$dragging,
    mode: FieldMode.member,
  );
  static double? _$savedTop(CalloutConfigModel v) => v.savedTop;
  static const Field<CalloutConfigModel, double> _f$savedTop = Field(
    'savedTop',
    _$savedTop,
    mode: FieldMode.member,
  );
  static double? _$savedLeft(CalloutConfigModel v) => v.savedLeft;
  static const Field<CalloutConfigModel, double> _f$savedLeft = Field(
    'savedLeft',
    _$savedLeft,
    mode: FieldMode.member,
  );
  static double _$actualTop(CalloutConfigModel v) => v.actualTop;
  static const Field<CalloutConfigModel, double> _f$actualTop = Field(
    'actualTop',
    _$actualTop,
    mode: FieldMode.member,
  );
  static double _$actualLeft(CalloutConfigModel v) => v.actualLeft;
  static const Field<CalloutConfigModel, double> _f$actualLeft = Field(
    'actualLeft',
    _$actualLeft,
    mode: FieldMode.member,
  );
  static bool _$isDraggable(CalloutConfigModel v) => v.isDraggable;
  static const Field<CalloutConfigModel, bool> _f$isDraggable = Field(
    'isDraggable',
    _$isDraggable,
    mode: FieldMode.member,
  );
  static bool _$preventDrag(CalloutConfigModel v) => v.preventDrag;
  static const Field<CalloutConfigModel, bool> _f$preventDrag = Field(
    'preventDrag',
    _$preventDrag,
    mode: FieldMode.member,
  );
  static Timer? _$removalTimer(CalloutConfigModel v) => v.removalTimer;
  static const Field<CalloutConfigModel, Timer> _f$removalTimer = Field(
    'removalTimer',
    _$removalTimer,
    mode: FieldMode.member,
  );
  static Coord? _$tE(CalloutConfigModel v) => v.tE;
  static const Field<CalloutConfigModel, Coord> _f$tE = Field(
    'tE',
    _$tE,
    mode: FieldMode.member,
  );
  static Coord? _$cE(CalloutConfigModel v) => v.cE;
  static const Field<CalloutConfigModel, Coord> _f$cE = Field(
    'cE',
    _$cE,
    mode: FieldMode.member,
  );
  static double? _$calloutW(CalloutConfigModel v) => v.calloutW;
  static const Field<CalloutConfigModel, double> _f$calloutW = Field(
    'calloutW',
    _$calloutW,
    mode: FieldMode.member,
  );
  static double? _$calloutH(CalloutConfigModel v) => v.calloutH;
  static const Field<CalloutConfigModel, double> _f$calloutH = Field(
    'calloutH',
    _$calloutH,
    mode: FieldMode.member,
  );
  static bool _$notToast(CalloutConfigModel v) => v.notToast;
  static const Field<CalloutConfigModel, bool> _f$notToast = Field(
    'notToast',
    _$notToast,
    mode: FieldMode.member,
  );

  @override
  final MappableFields<CalloutConfigModel> fields = const {
    #cId: _f$cId,
    #callerGK: _f$callerGK,
    #movedOrResizedNotifier: _f$movedOrResizedNotifier,
    #gravity: _f$gravity,
    #scrollControllerName: _f$scrollControllerName,
    #followScroll: _f$followScroll,
    #forceMeasure: _f$forceMeasure,
    #initialCalloutW: _f$initialCalloutW,
    #initialCalloutH: _f$initialCalloutH,
    #minWidth: _f$minWidth,
    #minHeight: _f$minHeight,
    #fillColor: _f$fillColor,
    #decorationShape: _f$decorationShape,
    #borderColor: _f$borderColor,
    #borderRadius: _f$borderRadius,
    #borderThickness: _f$borderThickness,
    #starPoints: _f$starPoints,
    #lengthDeltaPc: _f$lengthDeltaPc,
    #contentTranslateX: _f$contentTranslateX,
    #contentTranslateY: _f$contentTranslateY,
    #targetTranslateX: _f$targetTranslateX,
    #targetTranslateY: _f$targetTranslateY,
    #arrowType: _f$arrowType,
    #arrowColor: _f$arrowColor,
    #barrier: _f$barrier,
    #modal: _f$modal,
    #showCloseButton: _f$showCloseButton,
    #closeButtonPos: _f$closeButtonPos,
    #onCloseButtonPressF: _f$onCloseButtonPressF,
    #closeButtonColor: _f$closeButtonColor,
    #initialTargetAlignment: _f$initialTargetAlignment,
    #initialCalloutAlignment: _f$initialCalloutAlignment,
    #initialCalloutPos: _f$initialCalloutPos,
    #animate: _f$animate,
    #toDelta: _f$toDelta,
    #fromDelta: _f$fromDelta,
    #lineLabel: _f$lineLabel,
    #frameTarget: _f$frameTarget,
    #scaleTarget: _f$scaleTarget,
    #noBorder: _f$noBorder,
    #elevation: _f$elevation,
    #circleShape: _f$circleShape,
    #dragHandleHeight: _f$dragHandleHeight,
    #draggable: _f$draggable,
    #canToggleDraggable: _f$canToggleDraggable,
    #onDragF: _f$onDragF,
    #onDragEndedF: _f$onDragEndedF,
    #onDragStartedF: _f$onDragStartedF,
    #skipOnScreenCheck: _f$skipOnScreenCheck,
    #resizeableH: _f$resizeableH,
    #resizeableV: _f$resizeableV,
    #onResizeF: _f$onResizeF,
    #draggableColor: _f$draggableColor,
    #showGotitButton: _f$showGotitButton,
    #gotitAxis: _f$gotitAxis,
    #onGotitPressedF: _f$onGotitPressedF,
    #showcpi: _f$showcpi,
    #onlyOnce: _f$onlyOnce,
    #containsTextField: _f$containsTextField,
    #alwaysReCalcSize: _f$alwaysReCalcSize,
    #ignoreCalloutResult: _f$ignoreCalloutResult,
    #finalSeparation: _f$finalSeparation,
    #onDismissedF: _f$onDismissedF,
    #onTickedF: _f$onTickedF,
    #onHiddenF: _f$onHiddenF,
    #onAcceptedF: _f$onAcceptedF,
    #notUsingHydratedStorage: _f$notUsingHydratedStorage,
    #targetAlignment: _f$targetAlignment,
    #calloutAlignment: _f$calloutAlignment,
    #draggableEdgeThickness: _f$draggableEdgeThickness,
    #initialised: _f$initialised,
    #focusNode: _f$focusNode,
    #opDescendantContext: _f$opDescendantContext,
    #offstageEntry: _f$offstageEntry,
    #top: _f$top,
    #left: _f$left,
    #topEdge: _f$topEdge,
    #leftEdge: _f$leftEdge,
    #bottomEdge: _f$bottomEdge,
    #rightEdge: _f$rightEdge,
    #topLeftCorner: _f$topLeftCorner,
    #topRightCorner: _f$topRightCorner,
    #bottomLeftCorner: _f$bottomLeftCorner,
    #bottomRightCorner: _f$bottomRightCorner,
    #lineLabelPos: _f$lineLabelPos,
    #isHidden: _f$isHidden,
    #needsToScrollH: _f$needsToScrollH,
    #needsToScrollV: _f$needsToScrollV,
    #dragCalloutOffset: _f$dragCalloutOffset,
    #dragging: _f$dragging,
    #savedTop: _f$savedTop,
    #savedLeft: _f$savedLeft,
    #actualTop: _f$actualTop,
    #actualLeft: _f$actualLeft,
    #isDraggable: _f$isDraggable,
    #preventDrag: _f$preventDrag,
    #removalTimer: _f$removalTimer,
    #tE: _f$tE,
    #cE: _f$cE,
    #calloutW: _f$calloutW,
    #calloutH: _f$calloutH,
    #notToast: _f$notToast,
  };

  static CalloutConfigModel _instantiate(DecodingData data) {
    return CalloutConfigModel(
      cId: data.dec(_f$cId),
      callerGK: data.dec(_f$callerGK),
      movedOrResizedNotifier: data.dec(_f$movedOrResizedNotifier),
      gravity: data.dec(_f$gravity),
      scrollControllerName: data.dec(_f$scrollControllerName),
      followScroll: data.dec(_f$followScroll),
      forceMeasure: data.dec(_f$forceMeasure),
      initialCalloutW: data.dec(_f$initialCalloutW),
      initialCalloutH: data.dec(_f$initialCalloutH),
      minWidth: data.dec(_f$minWidth),
      minHeight: data.dec(_f$minHeight),
      fillColor: data.dec(_f$fillColor),
      decorationShape: data.dec(_f$decorationShape),
      borderColor: data.dec(_f$borderColor),
      borderRadius: data.dec(_f$borderRadius),
      borderThickness: data.dec(_f$borderThickness),
      starPoints: data.dec(_f$starPoints),
      lengthDeltaPc: data.dec(_f$lengthDeltaPc),
      contentTranslateX: data.dec(_f$contentTranslateX),
      contentTranslateY: data.dec(_f$contentTranslateY),
      targetTranslateX: data.dec(_f$targetTranslateX),
      targetTranslateY: data.dec(_f$targetTranslateY),
      arrowType: data.dec(_f$arrowType),
      arrowColor: data.dec(_f$arrowColor),
      barrier: data.dec(_f$barrier),
      modal: data.dec(_f$modal),
      showCloseButton: data.dec(_f$showCloseButton),
      closeButtonPos: data.dec(_f$closeButtonPos),
      onCloseButtonPressF: data.dec(_f$onCloseButtonPressF),
      closeButtonColor: data.dec(_f$closeButtonColor),
      initialTargetAlignment: data.dec(_f$initialTargetAlignment),
      initialCalloutAlignment: data.dec(_f$initialCalloutAlignment),
      initialCalloutPos: data.dec(_f$initialCalloutPos),
      animate: data.dec(_f$animate),
      toDelta: data.dec(_f$toDelta),
      fromDelta: data.dec(_f$fromDelta),
      lineLabel: data.dec(_f$lineLabel),
      frameTarget: data.dec(_f$frameTarget),
      scaleTarget: data.dec(_f$scaleTarget),
      noBorder: data.dec(_f$noBorder),
      elevation: data.dec(_f$elevation),
      circleShape: data.dec(_f$circleShape),
      dragHandleHeight: data.dec(_f$dragHandleHeight),
      draggable: data.dec(_f$draggable),
      canToggleDraggable: data.dec(_f$canToggleDraggable),
      onDragF: data.dec(_f$onDragF),
      onDragEndedF: data.dec(_f$onDragEndedF),
      onDragStartedF: data.dec(_f$onDragStartedF),
      skipOnScreenCheck: data.dec(_f$skipOnScreenCheck),
      resizeableH: data.dec(_f$resizeableH),
      resizeableV: data.dec(_f$resizeableV),
      onResizeF: data.dec(_f$onResizeF),
      draggableColor: data.dec(_f$draggableColor),
      showGotitButton: data.dec(_f$showGotitButton),
      gotitAxis: data.dec(_f$gotitAxis),
      onGotitPressedF: data.dec(_f$onGotitPressedF),
      showcpi: data.dec(_f$showcpi),
      onlyOnce: data.dec(_f$onlyOnce),
      containsTextField: data.dec(_f$containsTextField),
      alwaysReCalcSize: data.dec(_f$alwaysReCalcSize),
      ignoreCalloutResult: data.dec(_f$ignoreCalloutResult),
      finalSeparation: data.dec(_f$finalSeparation),
      onDismissedF: data.dec(_f$onDismissedF),
      onTickedF: data.dec(_f$onTickedF),
      onHiddenF: data.dec(_f$onHiddenF),
      onAcceptedF: data.dec(_f$onAcceptedF),
      notUsingHydratedStorage: data.dec(_f$notUsingHydratedStorage),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CalloutConfigModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CalloutConfigModel>(map);
  }

  static CalloutConfigModel fromJson(String json) {
    return ensureInitialized().decodeJson<CalloutConfigModel>(json);
  }
}

mixin CalloutConfigModelMappable {
  String toJson() {
    return CalloutConfigModelMapper.ensureInitialized()
        .encodeJson<CalloutConfigModel>(this as CalloutConfigModel);
  }

  Map<String, dynamic> toMap() {
    return CalloutConfigModelMapper.ensureInitialized()
        .encodeMap<CalloutConfigModel>(this as CalloutConfigModel);
  }

  CalloutConfigModelCopyWith<
    CalloutConfigModel,
    CalloutConfigModel,
    CalloutConfigModel
  >
  get copyWith =>
      _CalloutConfigModelCopyWithImpl<CalloutConfigModel, CalloutConfigModel>(
        this as CalloutConfigModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CalloutConfigModelMapper.ensureInitialized().stringifyValue(
      this as CalloutConfigModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return CalloutConfigModelMapper.ensureInitialized().equalsValue(
      this as CalloutConfigModel,
      other,
    );
  }

  @override
  int get hashCode {
    return CalloutConfigModelMapper.ensureInitialized().hashValue(
      this as CalloutConfigModel,
    );
  }
}

extension CalloutConfigModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CalloutConfigModel, $Out> {
  CalloutConfigModelCopyWith<$R, CalloutConfigModel, $Out>
  get $asCalloutConfigModel => $base.as(
    (v, t, t2) => _CalloutConfigModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CalloutConfigModelCopyWith<
  $R,
  $In extends CalloutConfigModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ColorModelCopyWith<$R, ColorModel, ColorModel>? get fillColor;
  ColorModelCopyWith<$R, ColorModel, ColorModel>? get borderColor;
  ColorModelCopyWith<$R, ColorModel, ColorModel>? get arrowColor;
  OffsetModelCopyWith<$R, OffsetModel, OffsetModel>? get initialCalloutPos;
  $R call({
    String? cId,
    GlobalKey<State<StatefulWidget>>? callerGK,
    ValueNotifier<int>? movedOrResizedNotifier,
    AlignmentEnum? gravity,
    String? scrollControllerName,
    bool? followScroll,
    bool? forceMeasure,
    double? initialCalloutW,
    double? initialCalloutH,
    double? minWidth,
    double? minHeight,
    ColorModel? fillColor,
    DecorationShapeEnum? decorationShape,
    ColorModel? borderColor,
    double? borderRadius,
    double? borderThickness,
    int? starPoints,
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
    void Function()? onCloseButtonPressF,
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
    void Function(Offset)? onDragF,
    void Function(Offset)? onDragEndedF,
    void Function()? onDragStartedF,
    bool? skipOnScreenCheck,
    bool? resizeableH,
    bool? resizeableV,
    void Function(Size)? onResizeF,
    Color? draggableColor,
    bool? showGotitButton,
    Axis? gotitAxis,
    Function? onGotitPressedF,
    bool? showcpi,
    bool? onlyOnce,
    bool? containsTextField,
    bool? alwaysReCalcSize,
    bool? ignoreCalloutResult,
    double? finalSeparation,
    void Function()? onDismissedF,
    void Function(String)? onTickedF,
    void Function()? onHiddenF,
    void Function()? onAcceptedF,
    bool? notUsingHydratedStorage,
  });
  CalloutConfigModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CalloutConfigModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CalloutConfigModel, $Out>
    implements CalloutConfigModelCopyWith<$R, CalloutConfigModel, $Out> {
  _CalloutConfigModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CalloutConfigModel> $mapper =
      CalloutConfigModelMapper.ensureInitialized();
  @override
  ColorModelCopyWith<$R, ColorModel, ColorModel>? get fillColor =>
      $value.fillColor?.copyWith.$chain((v) => call(fillColor: v));
  @override
  ColorModelCopyWith<$R, ColorModel, ColorModel>? get borderColor =>
      $value.borderColor?.copyWith.$chain((v) => call(borderColor: v));
  @override
  ColorModelCopyWith<$R, ColorModel, ColorModel>? get arrowColor =>
      $value.arrowColor?.copyWith.$chain((v) => call(arrowColor: v));
  @override
  OffsetModelCopyWith<$R, OffsetModel, OffsetModel>? get initialCalloutPos =>
      $value.initialCalloutPos?.copyWith.$chain(
        (v) => call(initialCalloutPos: v),
      );
  @override
  $R call({
    String? cId,
    Object? callerGK = $none,
    Object? movedOrResizedNotifier = $none,
    Object? gravity = $none,
    Object? scrollControllerName = $none,
    bool? followScroll,
    bool? forceMeasure,
    Object? initialCalloutW = $none,
    Object? initialCalloutH = $none,
    Object? minWidth = $none,
    Object? minHeight = $none,
    Object? fillColor = $none,
    DecorationShapeEnum? decorationShape,
    Object? borderColor = $none,
    double? borderRadius,
    double? borderThickness,
    Object? starPoints = $none,
    double? lengthDeltaPc,
    Object? contentTranslateX = $none,
    Object? contentTranslateY = $none,
    Object? targetTranslateX = $none,
    Object? targetTranslateY = $none,
    ArrowTypeEnum? arrowType,
    Object? arrowColor = $none,
    Object? barrier = $none,
    bool? modal,
    bool? showCloseButton,
    Offset? closeButtonPos,
    Object? onCloseButtonPressF = $none,
    Color? closeButtonColor,
    Object? initialTargetAlignment = $none,
    Object? initialCalloutAlignment = $none,
    Object? initialCalloutPos = $none,
    bool? animate,
    Object? toDelta = $none,
    Object? fromDelta = $none,
    Object? lineLabel = $none,
    bool? frameTarget,
    double? scaleTarget,
    bool? noBorder,
    double? elevation,
    bool? circleShape,
    Object? dragHandleHeight = $none,
    bool? draggable,
    bool? canToggleDraggable,
    Object? onDragF = $none,
    Object? onDragEndedF = $none,
    Object? onDragStartedF = $none,
    bool? skipOnScreenCheck,
    bool? resizeableH,
    bool? resizeableV,
    Object? onResizeF = $none,
    Object? draggableColor = $none,
    bool? showGotitButton,
    Object? gotitAxis = $none,
    Object? onGotitPressedF = $none,
    bool? showcpi,
    Object? onlyOnce = $none,
    bool? containsTextField,
    bool? alwaysReCalcSize,
    bool? ignoreCalloutResult,
    Object? finalSeparation = $none,
    Object? onDismissedF = $none,
    Object? onTickedF = $none,
    Object? onHiddenF = $none,
    Object? onAcceptedF = $none,
    bool? notUsingHydratedStorage,
  }) => $apply(
    FieldCopyWithData({
      if (cId != null) #cId: cId,
      if (callerGK != $none) #callerGK: callerGK,
      if (movedOrResizedNotifier != $none)
        #movedOrResizedNotifier: movedOrResizedNotifier,
      if (gravity != $none) #gravity: gravity,
      if (scrollControllerName != $none)
        #scrollControllerName: scrollControllerName,
      if (followScroll != null) #followScroll: followScroll,
      if (forceMeasure != null) #forceMeasure: forceMeasure,
      if (initialCalloutW != $none) #initialCalloutW: initialCalloutW,
      if (initialCalloutH != $none) #initialCalloutH: initialCalloutH,
      if (minWidth != $none) #minWidth: minWidth,
      if (minHeight != $none) #minHeight: minHeight,
      if (fillColor != $none) #fillColor: fillColor,
      if (decorationShape != null) #decorationShape: decorationShape,
      if (borderColor != $none) #borderColor: borderColor,
      if (borderRadius != null) #borderRadius: borderRadius,
      if (borderThickness != null) #borderThickness: borderThickness,
      if (starPoints != $none) #starPoints: starPoints,
      if (lengthDeltaPc != null) #lengthDeltaPc: lengthDeltaPc,
      if (contentTranslateX != $none) #contentTranslateX: contentTranslateX,
      if (contentTranslateY != $none) #contentTranslateY: contentTranslateY,
      if (targetTranslateX != $none) #targetTranslateX: targetTranslateX,
      if (targetTranslateY != $none) #targetTranslateY: targetTranslateY,
      if (arrowType != null) #arrowType: arrowType,
      if (arrowColor != $none) #arrowColor: arrowColor,
      if (barrier != $none) #barrier: barrier,
      if (modal != null) #modal: modal,
      if (showCloseButton != null) #showCloseButton: showCloseButton,
      if (closeButtonPos != null) #closeButtonPos: closeButtonPos,
      if (onCloseButtonPressF != $none)
        #onCloseButtonPressF: onCloseButtonPressF,
      if (closeButtonColor != null) #closeButtonColor: closeButtonColor,
      if (initialTargetAlignment != $none)
        #initialTargetAlignment: initialTargetAlignment,
      if (initialCalloutAlignment != $none)
        #initialCalloutAlignment: initialCalloutAlignment,
      if (initialCalloutPos != $none) #initialCalloutPos: initialCalloutPos,
      if (animate != null) #animate: animate,
      if (toDelta != $none) #toDelta: toDelta,
      if (fromDelta != $none) #fromDelta: fromDelta,
      if (lineLabel != $none) #lineLabel: lineLabel,
      if (frameTarget != null) #frameTarget: frameTarget,
      if (scaleTarget != null) #scaleTarget: scaleTarget,
      if (noBorder != null) #noBorder: noBorder,
      if (elevation != null) #elevation: elevation,
      if (circleShape != null) #circleShape: circleShape,
      if (dragHandleHeight != $none) #dragHandleHeight: dragHandleHeight,
      if (draggable != null) #draggable: draggable,
      if (canToggleDraggable != null) #canToggleDraggable: canToggleDraggable,
      if (onDragF != $none) #onDragF: onDragF,
      if (onDragEndedF != $none) #onDragEndedF: onDragEndedF,
      if (onDragStartedF != $none) #onDragStartedF: onDragStartedF,
      if (skipOnScreenCheck != null) #skipOnScreenCheck: skipOnScreenCheck,
      if (resizeableH != null) #resizeableH: resizeableH,
      if (resizeableV != null) #resizeableV: resizeableV,
      if (onResizeF != $none) #onResizeF: onResizeF,
      if (draggableColor != $none) #draggableColor: draggableColor,
      if (showGotitButton != null) #showGotitButton: showGotitButton,
      if (gotitAxis != $none) #gotitAxis: gotitAxis,
      if (onGotitPressedF != $none) #onGotitPressedF: onGotitPressedF,
      if (showcpi != null) #showcpi: showcpi,
      if (onlyOnce != $none) #onlyOnce: onlyOnce,
      if (containsTextField != null) #containsTextField: containsTextField,
      if (alwaysReCalcSize != null) #alwaysReCalcSize: alwaysReCalcSize,
      if (ignoreCalloutResult != null)
        #ignoreCalloutResult: ignoreCalloutResult,
      if (finalSeparation != $none) #finalSeparation: finalSeparation,
      if (onDismissedF != $none) #onDismissedF: onDismissedF,
      if (onTickedF != $none) #onTickedF: onTickedF,
      if (onHiddenF != $none) #onHiddenF: onHiddenF,
      if (onAcceptedF != $none) #onAcceptedF: onAcceptedF,
      if (notUsingHydratedStorage != null)
        #notUsingHydratedStorage: notUsingHydratedStorage,
    }),
  );
  @override
  CalloutConfigModel $make(CopyWithData data) => CalloutConfigModel(
    cId: data.get(#cId, or: $value.cId),
    callerGK: data.get(#callerGK, or: $value.callerGK),
    movedOrResizedNotifier: data.get(
      #movedOrResizedNotifier,
      or: $value.movedOrResizedNotifier,
    ),
    gravity: data.get(#gravity, or: $value.gravity),
    scrollControllerName: data.get(
      #scrollControllerName,
      or: $value.scrollControllerName,
    ),
    followScroll: data.get(#followScroll, or: $value.followScroll),
    forceMeasure: data.get(#forceMeasure, or: $value.forceMeasure),
    initialCalloutW: data.get(#initialCalloutW, or: $value.initialCalloutW),
    initialCalloutH: data.get(#initialCalloutH, or: $value.initialCalloutH),
    minWidth: data.get(#minWidth, or: $value.minWidth),
    minHeight: data.get(#minHeight, or: $value.minHeight),
    fillColor: data.get(#fillColor, or: $value.fillColor),
    decorationShape: data.get(#decorationShape, or: $value.decorationShape),
    borderColor: data.get(#borderColor, or: $value.borderColor),
    borderRadius: data.get(#borderRadius, or: $value.borderRadius),
    borderThickness: data.get(#borderThickness, or: $value.borderThickness),
    starPoints: data.get(#starPoints, or: $value.starPoints),
    lengthDeltaPc: data.get(#lengthDeltaPc, or: $value.lengthDeltaPc),
    contentTranslateX: data.get(
      #contentTranslateX,
      or: $value.contentTranslateX,
    ),
    contentTranslateY: data.get(
      #contentTranslateY,
      or: $value.contentTranslateY,
    ),
    targetTranslateX: data.get(#targetTranslateX, or: $value.targetTranslateX),
    targetTranslateY: data.get(#targetTranslateY, or: $value.targetTranslateY),
    arrowType: data.get(#arrowType, or: $value.arrowType),
    arrowColor: data.get(#arrowColor, or: $value.arrowColor),
    barrier: data.get(#barrier, or: $value.barrier),
    modal: data.get(#modal, or: $value.modal),
    showCloseButton: data.get(#showCloseButton, or: $value.showCloseButton),
    closeButtonPos: data.get(#closeButtonPos, or: $value.closeButtonPos),
    onCloseButtonPressF: data.get(
      #onCloseButtonPressF,
      or: $value.onCloseButtonPressF,
    ),
    closeButtonColor: data.get(#closeButtonColor, or: $value.closeButtonColor),
    initialTargetAlignment: data.get(
      #initialTargetAlignment,
      or: $value.initialTargetAlignment,
    ),
    initialCalloutAlignment: data.get(
      #initialCalloutAlignment,
      or: $value.initialCalloutAlignment,
    ),
    initialCalloutPos: data.get(
      #initialCalloutPos,
      or: $value.initialCalloutPos,
    ),
    animate: data.get(#animate, or: $value.animate),
    toDelta: data.get(#toDelta, or: $value.toDelta),
    fromDelta: data.get(#fromDelta, or: $value.fromDelta),
    lineLabel: data.get(#lineLabel, or: $value.lineLabel),
    frameTarget: data.get(#frameTarget, or: $value.frameTarget),
    scaleTarget: data.get(#scaleTarget, or: $value.scaleTarget),
    noBorder: data.get(#noBorder, or: $value.noBorder),
    elevation: data.get(#elevation, or: $value.elevation),
    circleShape: data.get(#circleShape, or: $value.circleShape),
    dragHandleHeight: data.get(#dragHandleHeight, or: $value.dragHandleHeight),
    draggable: data.get(#draggable, or: $value.draggable),
    canToggleDraggable: data.get(
      #canToggleDraggable,
      or: $value.canToggleDraggable,
    ),
    onDragF: data.get(#onDragF, or: $value.onDragF),
    onDragEndedF: data.get(#onDragEndedF, or: $value.onDragEndedF),
    onDragStartedF: data.get(#onDragStartedF, or: $value.onDragStartedF),
    skipOnScreenCheck: data.get(
      #skipOnScreenCheck,
      or: $value.skipOnScreenCheck,
    ),
    resizeableH: data.get(#resizeableH, or: $value.resizeableH),
    resizeableV: data.get(#resizeableV, or: $value.resizeableV),
    onResizeF: data.get(#onResizeF, or: $value.onResizeF),
    draggableColor: data.get(#draggableColor, or: $value.draggableColor),
    showGotitButton: data.get(#showGotitButton, or: $value.showGotitButton),
    gotitAxis: data.get(#gotitAxis, or: $value.gotitAxis),
    onGotitPressedF: data.get(#onGotitPressedF, or: $value.onGotitPressedF),
    showcpi: data.get(#showcpi, or: $value.showcpi),
    onlyOnce: data.get(#onlyOnce, or: $value.onlyOnce),
    containsTextField: data.get(
      #containsTextField,
      or: $value.containsTextField,
    ),
    alwaysReCalcSize: data.get(#alwaysReCalcSize, or: $value.alwaysReCalcSize),
    ignoreCalloutResult: data.get(
      #ignoreCalloutResult,
      or: $value.ignoreCalloutResult,
    ),
    finalSeparation: data.get(#finalSeparation, or: $value.finalSeparation),
    onDismissedF: data.get(#onDismissedF, or: $value.onDismissedF),
    onTickedF: data.get(#onTickedF, or: $value.onTickedF),
    onHiddenF: data.get(#onHiddenF, or: $value.onHiddenF),
    onAcceptedF: data.get(#onAcceptedF, or: $value.onAcceptedF),
    notUsingHydratedStorage: data.get(
      #notUsingHydratedStorage,
      or: $value.notUsingHydratedStorage,
    ),
  );

  @override
  CalloutConfigModelCopyWith<$R2, CalloutConfigModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CalloutConfigModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

