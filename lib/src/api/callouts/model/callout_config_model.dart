import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

import 'alignment_model.dart';

part 'callout_config_model.mapper.dart';

@MappableClass()
class CalloutConfigModel with CalloutConfigModelMappable {
  final String cId;
  double? initialCalloutW;
  double? initialCalloutH;

  // extend line in the to direction by delta
  double? fromDelta;

  // extend line in the from direction by delta
  double? toDelta;

  ArrowTypeEnum arrowType;
  Color? arrowColor;
  Alignment? initialTargetAlignment;
  Alignment? initialCalloutAlignment;
  Offset? initialCalloutPos;
  final double? minWidth;
  final double? minHeight;
  Color? fillColor;
  final Color? borderColor;
  DecorationShapeEnum decorationShape;
  final double borderRadius;
  final double borderThickness;
  final int? starPoints;
  final double lengthDeltaPc;
  final double? contentTranslateX;
  final double? contentTranslateY;
  final double? targetTranslateX;
  final double? targetTranslateY;
  final bool animate;
  final Widget? lineLabel;
  bool frameTarget;
  final double scaleTarget;
  double? finalSeparation;
  bool draggable;
  final bool noBorder;
  final double elevation;
  final bool circleShape;
  final bool resizeableH;
  final bool resizeableV;
  final double draggableEdgeThickness = 16.0;

  CalloutConfigModel({
    // required this.refreshOPParent,
    required this.cId,
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
    this.initialTargetAlignment,
    this.initialCalloutAlignment,
    this.initialCalloutPos,
    this.animate = false,
    this.toDelta,
    this.fromDelta,
    this.lineLabel,
    this.frameTarget = false,
    this.scaleTarget = 1.0,
    this.noBorder = false,
    this.elevation = 0,
    this.circleShape = false,
    this.draggable = true,
    this.resizeableH = false,
    this.resizeableV = false,
    this.finalSeparation,
  });
}
