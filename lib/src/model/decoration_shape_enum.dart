import 'package:bh_shared/bh_shared.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

import 'color_values.dart';

enum DecorationShapeEnum {
  rectangle,
  rounded_rectangle,
  rectangle_dotted,
  rounded_rectangle_dotted,
  circle,
  bevelled,
  stadium,
  star;


  Decoration? toDecoration({
    ColorValues? fillColorValues,
    ColorValues? borderColorValues,
    double? thickness,
    double? borderRadius,
    int? starPoints,
  }) {
    // if (this != DecorationShapeEnum.rectangle) {
    //   print('blah');
    // }
    // if no fill colors supplied, default to black.
    // if only one color supplied use that as color param
    // if >1 colors supplied use the colors in a gradient
    Color? fillColor;
    List<Color> fillColors = [];
    if (fillColorValues?.color1Value != null) fillColors.add(Color(fillColorValues!.color1Value!));
    if (fillColorValues?.color2Value != null) fillColors.add(Color(fillColorValues!.color2Value!));
    if (fillColorValues?.color3Value != null) fillColors.add(Color(fillColorValues!.color3Value!));
    if (fillColorValues?.color4Value != null) fillColors.add(Color(fillColorValues!.color4Value!));
    if (fillColorValues?.color5Value != null) fillColors.add(Color(fillColorValues!.color5Value!));
    if (fillColorValues?.color6Value != null) fillColors.add(Color(fillColorValues!.color6Value!));
    Gradient? fillGradient = fillColors.length > 1 ? LinearGradient(colors: fillColors) : null;
    if (fillColors.length == 1) fillColor = fillColors.first;
    if (fillColors.isEmpty) fillColor = Colors.white;
    List<Color> borderColors = [];
    if (borderColorValues?.color1Value != null) borderColors.add(Color(borderColorValues!.color1Value!));
    if (borderColorValues?.color2Value != null) borderColors.add(Color(borderColorValues!.color2Value!));
    if (borderColorValues?.color3Value != null) borderColors.add(Color(borderColorValues!.color3Value!));
    if (borderColorValues?.color4Value != null) borderColors.add(Color(borderColorValues!.color4Value!));
    if (borderColorValues?.color5Value != null) borderColors.add(Color(borderColorValues!.color5Value!));
    if (borderColorValues?.color6Value != null) borderColors.add(Color(borderColorValues!.color6Value!));
    BoxBorder? border;
    if (borderColors.length == 1) {
      border = Border.all(color: borderColors.first, width: thickness ?? 3);
    } else if (borderColors.length > 1) {
      // const rainbowGradient = LinearGradient(colors: [Colors.blue, Colors.green, Colors.yellow, Colors.red, Colors.purpleAccent]);
      LinearGradient borderGradient = LinearGradient(colors: borderColors);
      border = GradientBoxBorder(gradient: borderGradient, width: thickness ?? 3);
    }
    return switch (this) {
      DecorationShapeEnum.rectangle => BoxDecoration(
        shape: BoxShape.rectangle,
        border: border,
        gradient: fillGradient,
        color: fillColor,
      ),
      DecorationShapeEnum.rounded_rectangle => BoxDecoration(
        shape: BoxShape.rectangle,
        border: border,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 8)),
        gradient: fillGradient,
        color: fillColor,
      ),
      DecorationShapeEnum.rectangle_dotted => DottedDecoration(
        shape: Shape.box,
        dash: const <int>[3, 3],
        borderColor: borderColors.firstOrNull ?? Colors.grey,
        strokeWidth: 3,
        fillColor: fillColor ?? Colors.white,
        fillGradient: fillGradient,
      ),
      DecorationShapeEnum.rounded_rectangle_dotted => DottedDecoration(
        shape: Shape.box,
        dash: const <int>[3, 3],
        borderColor: borderColors.firstOrNull ?? Colors.grey,
        strokeWidth: 3,
        fillColor: fillColor ?? Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 8)),
        fillGradient: fillGradient,
      ),
      DecorationShapeEnum.circle => BoxDecoration(
        shape: BoxShape.circle,
        border: border,
        color: fillGradient != null ? null : fillColor ?? Colors.white,
        gradient: fillGradient,
      ),
      DecorationShapeEnum.bevelled => ShapeDecoration(
        shape: BeveledRectangleBorder(
          side: BorderSide(color: borderColors.firstOrNull ?? Colors.black, width: thickness ?? 1),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 6)),
        ),
        color: fillGradient != null ? null : fillColor ?? Colors.white,
        gradient: fillGradient,
      ),
      DecorationShapeEnum.stadium => ShapeDecoration(
        shape: StadiumBorder(
          side: BorderSide(color: borderColors.firstOrNull ?? Colors.black, width: thickness ?? 2),
        ),
        color: fillGradient != null ? null : fillColor ?? Colors.white,
        gradient: fillGradient,
      ),
      DecorationShapeEnum.star => ShapeDecoration(
        shape: StarBorder(
          side: BorderSide(color: borderColors.firstOrNull ?? Colors.black, width: thickness ?? 2),
          points: starPoints?.toDouble() ?? 7,
          // innerRadiusRatio: _model.innerRadiusRatio,
          // pointRounding: _model.pointRounding,
          // valleyRounding: _model.valleyRounding,
          // rotation: 0,
        ),
        color: fillGradient != null ? null : fillColor ?? Colors.white,
        gradient: fillGradient,
      ),
    };
  }

  static DecorationShapeEnum? of(int? index) => index != null ? DecorationShapeEnum.values.elementAtOrNull(index) : null;
}
