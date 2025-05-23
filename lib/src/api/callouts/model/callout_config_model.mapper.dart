// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'callout_config_model.dart';

class CalloutConfigModelMapper extends ClassMapperBase<CalloutConfigModel> {
  CalloutConfigModelMapper._();

  static CalloutConfigModelMapper? _instance;
  static CalloutConfigModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CalloutConfigModelMapper._());
      DecorationShapeEnumMapper.ensureInitialized();
      ArrowTypeEnumMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CalloutConfigModel';

  static String _$cId(CalloutConfigModel v) => v.cId;
  static const Field<CalloutConfigModel, String> _f$cId = Field('cId', _$cId);
  static double? _$initialCalloutW(CalloutConfigModel v) => v.initialCalloutW;
  static const Field<CalloutConfigModel, double> _f$initialCalloutW =
      Field('initialCalloutW', _$initialCalloutW, opt: true);
  static double? _$initialCalloutH(CalloutConfigModel v) => v.initialCalloutH;
  static const Field<CalloutConfigModel, double> _f$initialCalloutH =
      Field('initialCalloutH', _$initialCalloutH, opt: true);
  static double? _$minWidth(CalloutConfigModel v) => v.minWidth;
  static const Field<CalloutConfigModel, double> _f$minWidth =
      Field('minWidth', _$minWidth, opt: true);
  static double? _$minHeight(CalloutConfigModel v) => v.minHeight;
  static const Field<CalloutConfigModel, double> _f$minHeight =
      Field('minHeight', _$minHeight, opt: true);
  static Color? _$fillColor(CalloutConfigModel v) => v.fillColor;
  static const Field<CalloutConfigModel, Color> _f$fillColor =
      Field('fillColor', _$fillColor, opt: true);
  static DecorationShapeEnum _$decorationShape(CalloutConfigModel v) =>
      v.decorationShape;
  static const Field<CalloutConfigModel, DecorationShapeEnum>
      _f$decorationShape = Field('decorationShape', _$decorationShape,
          opt: true, def: DecorationShapeEnum.rectangle);
  static Color? _$borderColor(CalloutConfigModel v) => v.borderColor;
  static const Field<CalloutConfigModel, Color> _f$borderColor =
      Field('borderColor', _$borderColor, opt: true);
  static double _$borderRadius(CalloutConfigModel v) => v.borderRadius;
  static const Field<CalloutConfigModel, double> _f$borderRadius =
      Field('borderRadius', _$borderRadius, opt: true, def: 0);
  static double _$borderThickness(CalloutConfigModel v) => v.borderThickness;
  static const Field<CalloutConfigModel, double> _f$borderThickness =
      Field('borderThickness', _$borderThickness, opt: true, def: 0);
  static int? _$starPoints(CalloutConfigModel v) => v.starPoints;
  static const Field<CalloutConfigModel, int> _f$starPoints =
      Field('starPoints', _$starPoints, opt: true);
  static double _$lengthDeltaPc(CalloutConfigModel v) => v.lengthDeltaPc;
  static const Field<CalloutConfigModel, double> _f$lengthDeltaPc =
      Field('lengthDeltaPc', _$lengthDeltaPc, opt: true, def: 0.95);
  static double? _$contentTranslateX(CalloutConfigModel v) =>
      v.contentTranslateX;
  static const Field<CalloutConfigModel, double> _f$contentTranslateX =
      Field('contentTranslateX', _$contentTranslateX, opt: true);
  static double? _$contentTranslateY(CalloutConfigModel v) =>
      v.contentTranslateY;
  static const Field<CalloutConfigModel, double> _f$contentTranslateY =
      Field('contentTranslateY', _$contentTranslateY, opt: true);
  static double? _$targetTranslateX(CalloutConfigModel v) => v.targetTranslateX;
  static const Field<CalloutConfigModel, double> _f$targetTranslateX =
      Field('targetTranslateX', _$targetTranslateX, opt: true);
  static double? _$targetTranslateY(CalloutConfigModel v) => v.targetTranslateY;
  static const Field<CalloutConfigModel, double> _f$targetTranslateY =
      Field('targetTranslateY', _$targetTranslateY, opt: true);
  static ArrowTypeEnum _$arrowType(CalloutConfigModel v) => v.arrowType;
  static const Field<CalloutConfigModel, ArrowTypeEnum> _f$arrowType =
      Field('arrowType', _$arrowType, opt: true, def: ArrowTypeEnum.THIN);
  static Color? _$arrowColor(CalloutConfigModel v) => v.arrowColor;
  static const Field<CalloutConfigModel, Color> _f$arrowColor =
      Field('arrowColor', _$arrowColor, opt: true);
  static Alignment? _$initialTargetAlignment(CalloutConfigModel v) =>
      v.initialTargetAlignment;
  static const Field<CalloutConfigModel, Alignment> _f$initialTargetAlignment =
      Field('initialTargetAlignment', _$initialTargetAlignment, opt: true);
  static Alignment? _$initialCalloutAlignment(CalloutConfigModel v) =>
      v.initialCalloutAlignment;
  static const Field<CalloutConfigModel, Alignment> _f$initialCalloutAlignment =
      Field('initialCalloutAlignment', _$initialCalloutAlignment, opt: true);
  static Offset? _$initialCalloutPos(CalloutConfigModel v) =>
      v.initialCalloutPos;
  static const Field<CalloutConfigModel, Offset> _f$initialCalloutPos =
      Field('initialCalloutPos', _$initialCalloutPos, opt: true);
  static bool _$animate(CalloutConfigModel v) => v.animate;
  static const Field<CalloutConfigModel, bool> _f$animate =
      Field('animate', _$animate, opt: true, def: false);
  static double? _$toDelta(CalloutConfigModel v) => v.toDelta;
  static const Field<CalloutConfigModel, double> _f$toDelta =
      Field('toDelta', _$toDelta, opt: true);
  static double? _$fromDelta(CalloutConfigModel v) => v.fromDelta;
  static const Field<CalloutConfigModel, double> _f$fromDelta =
      Field('fromDelta', _$fromDelta, opt: true);
  static Widget? _$lineLabel(CalloutConfigModel v) => v.lineLabel;
  static const Field<CalloutConfigModel, Widget> _f$lineLabel =
      Field('lineLabel', _$lineLabel, opt: true);
  static bool _$frameTarget(CalloutConfigModel v) => v.frameTarget;
  static const Field<CalloutConfigModel, bool> _f$frameTarget =
      Field('frameTarget', _$frameTarget, opt: true, def: false);
  static double _$scaleTarget(CalloutConfigModel v) => v.scaleTarget;
  static const Field<CalloutConfigModel, double> _f$scaleTarget =
      Field('scaleTarget', _$scaleTarget, opt: true, def: 1.0);
  static bool _$noBorder(CalloutConfigModel v) => v.noBorder;
  static const Field<CalloutConfigModel, bool> _f$noBorder =
      Field('noBorder', _$noBorder, opt: true, def: false);
  static double _$elevation(CalloutConfigModel v) => v.elevation;
  static const Field<CalloutConfigModel, double> _f$elevation =
      Field('elevation', _$elevation, opt: true, def: 0);
  static bool _$circleShape(CalloutConfigModel v) => v.circleShape;
  static const Field<CalloutConfigModel, bool> _f$circleShape =
      Field('circleShape', _$circleShape, opt: true, def: false);
  static bool _$draggable(CalloutConfigModel v) => v.draggable;
  static const Field<CalloutConfigModel, bool> _f$draggable =
      Field('draggable', _$draggable, opt: true, def: true);
  static bool _$resizeableH(CalloutConfigModel v) => v.resizeableH;
  static const Field<CalloutConfigModel, bool> _f$resizeableH =
      Field('resizeableH', _$resizeableH, opt: true, def: false);
  static bool _$resizeableV(CalloutConfigModel v) => v.resizeableV;
  static const Field<CalloutConfigModel, bool> _f$resizeableV =
      Field('resizeableV', _$resizeableV, opt: true, def: false);
  static double? _$finalSeparation(CalloutConfigModel v) => v.finalSeparation;
  static const Field<CalloutConfigModel, double> _f$finalSeparation =
      Field('finalSeparation', _$finalSeparation, opt: true);
  static double _$draggableEdgeThickness(CalloutConfigModel v) =>
      v.draggableEdgeThickness;
  static const Field<CalloutConfigModel, double> _f$draggableEdgeThickness =
      Field('draggableEdgeThickness', _$draggableEdgeThickness,
          mode: FieldMode.member);

  @override
  final MappableFields<CalloutConfigModel> fields = const {
    #cId: _f$cId,
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
    #draggable: _f$draggable,
    #resizeableH: _f$resizeableH,
    #resizeableV: _f$resizeableV,
    #finalSeparation: _f$finalSeparation,
    #draggableEdgeThickness: _f$draggableEdgeThickness,
  };

  static CalloutConfigModel _instantiate(DecodingData data) {
    return CalloutConfigModel(
        cId: data.dec(_f$cId),
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
        draggable: data.dec(_f$draggable),
        resizeableH: data.dec(_f$resizeableH),
        resizeableV: data.dec(_f$resizeableV),
        finalSeparation: data.dec(_f$finalSeparation));
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

  CalloutConfigModelCopyWith<CalloutConfigModel, CalloutConfigModel,
          CalloutConfigModel>
      get copyWith => _CalloutConfigModelCopyWithImpl<CalloutConfigModel,
          CalloutConfigModel>(this as CalloutConfigModel, $identity, $identity);
  @override
  String toString() {
    return CalloutConfigModelMapper.ensureInitialized()
        .stringifyValue(this as CalloutConfigModel);
  }

  @override
  bool operator ==(Object other) {
    return CalloutConfigModelMapper.ensureInitialized()
        .equalsValue(this as CalloutConfigModel, other);
  }

  @override
  int get hashCode {
    return CalloutConfigModelMapper.ensureInitialized()
        .hashValue(this as CalloutConfigModel);
  }
}

extension CalloutConfigModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CalloutConfigModel, $Out> {
  CalloutConfigModelCopyWith<$R, CalloutConfigModel, $Out>
      get $asCalloutConfigModel => $base.as(
          (v, t, t2) => _CalloutConfigModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CalloutConfigModelCopyWith<$R, $In extends CalloutConfigModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? cId,
      double? initialCalloutW,
      double? initialCalloutH,
      double? minWidth,
      double? minHeight,
      Color? fillColor,
      DecorationShapeEnum? decorationShape,
      Color? borderColor,
      double? borderRadius,
      double? borderThickness,
      int? starPoints,
      double? lengthDeltaPc,
      double? contentTranslateX,
      double? contentTranslateY,
      double? targetTranslateX,
      double? targetTranslateY,
      ArrowTypeEnum? arrowType,
      Color? arrowColor,
      Alignment? initialTargetAlignment,
      Alignment? initialCalloutAlignment,
      Offset? initialCalloutPos,
      bool? animate,
      double? toDelta,
      double? fromDelta,
      Widget? lineLabel,
      bool? frameTarget,
      double? scaleTarget,
      bool? noBorder,
      double? elevation,
      bool? circleShape,
      bool? draggable,
      bool? resizeableH,
      bool? resizeableV,
      double? finalSeparation});
  CalloutConfigModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CalloutConfigModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CalloutConfigModel, $Out>
    implements CalloutConfigModelCopyWith<$R, CalloutConfigModel, $Out> {
  _CalloutConfigModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CalloutConfigModel> $mapper =
      CalloutConfigModelMapper.ensureInitialized();
  @override
  $R call(
          {String? cId,
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
          bool? draggable,
          bool? resizeableH,
          bool? resizeableV,
          Object? finalSeparation = $none}) =>
      $apply(FieldCopyWithData({
        if (cId != null) #cId: cId,
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
        if (draggable != null) #draggable: draggable,
        if (resizeableH != null) #resizeableH: resizeableH,
        if (resizeableV != null) #resizeableV: resizeableV,
        if (finalSeparation != $none) #finalSeparation: finalSeparation
      }));
  @override
  CalloutConfigModel $make(CopyWithData data) => CalloutConfigModel(
      cId: data.get(#cId, or: $value.cId),
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
      contentTranslateX:
          data.get(#contentTranslateX, or: $value.contentTranslateX),
      contentTranslateY:
          data.get(#contentTranslateY, or: $value.contentTranslateY),
      targetTranslateX:
          data.get(#targetTranslateX, or: $value.targetTranslateX),
      targetTranslateY:
          data.get(#targetTranslateY, or: $value.targetTranslateY),
      arrowType: data.get(#arrowType, or: $value.arrowType),
      arrowColor: data.get(#arrowColor, or: $value.arrowColor),
      initialTargetAlignment:
          data.get(#initialTargetAlignment, or: $value.initialTargetAlignment),
      initialCalloutAlignment: data.get(#initialCalloutAlignment,
          or: $value.initialCalloutAlignment),
      initialCalloutPos:
          data.get(#initialCalloutPos, or: $value.initialCalloutPos),
      animate: data.get(#animate, or: $value.animate),
      toDelta: data.get(#toDelta, or: $value.toDelta),
      fromDelta: data.get(#fromDelta, or: $value.fromDelta),
      lineLabel: data.get(#lineLabel, or: $value.lineLabel),
      frameTarget: data.get(#frameTarget, or: $value.frameTarget),
      scaleTarget: data.get(#scaleTarget, or: $value.scaleTarget),
      noBorder: data.get(#noBorder, or: $value.noBorder),
      elevation: data.get(#elevation, or: $value.elevation),
      circleShape: data.get(#circleShape, or: $value.circleShape),
      draggable: data.get(#draggable, or: $value.draggable),
      resizeableH: data.get(#resizeableH, or: $value.resizeableH),
      resizeableV: data.get(#resizeableV, or: $value.resizeableV),
      finalSeparation: data.get(#finalSeparation, or: $value.finalSeparation));

  @override
  CalloutConfigModelCopyWith<$R2, CalloutConfigModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CalloutConfigModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
