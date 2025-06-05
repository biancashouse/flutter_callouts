
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';
import 'package:flutter_callouts/src/api/callouts/dotted_decoration.dart';
import 'package:flutter_callouts/src/api/callouts/model/upto6colors.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

part 'decoration_shape_enum.mapper.dart';

@MappableEnum()
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
    UpTo6Colors? upTo6FillColors,
    UpTo6Colors? upTo6BorderColors,
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
    if (upTo6FillColors?.color1 != null)
      fillColors.add(upTo6FillColors!.color1!.flutterValue);
    if (upTo6FillColors?.color1 != null) {
      fillColors.add(upTo6FillColors!.color1!.flutterValue);
    }
    if (upTo6FillColors?.color2!= null) {
      fillColors.add(upTo6FillColors!.color2!.flutterValue);
    }
    if (upTo6FillColors?.color3!= null) {
      fillColors.add(upTo6FillColors!.color3!.flutterValue);
    }
    if (upTo6FillColors?.color4!= null) {
      fillColors.add(upTo6FillColors!.color4!.flutterValue);
    }
    if (upTo6FillColors?.color5!= null) {
      fillColors.add(upTo6FillColors!.color5!.flutterValue);
    }
    if (upTo6FillColors?.color6!= null) {
      fillColors.add(upTo6FillColors!.color6!.flutterValue);
    }
    Gradient? fillGradient =
        fillColors.length > 1 ? LinearGradient(colors: fillColors) : null;
    if (fillColors.length == 1) fillColor = fillColors.first;
    if (fillColors.isEmpty) fillColor = Colors.white;
    List<Color> borderColors = [];
    if (upTo6BorderColors?.color1!= null) {
      borderColors.add(upTo6BorderColors!.color1!.flutterValue);
    }
    if (upTo6BorderColors?.color2!= null) {
      borderColors.add(upTo6BorderColors!.color2!.flutterValue);
    }
    if (upTo6BorderColors?.color3!= null) {
      borderColors.add(upTo6BorderColors!.color3!.flutterValue);
    }
    if (upTo6BorderColors?.color4!= null) {
      borderColors.add(upTo6BorderColors!.color4!.flutterValue);
    }
    if (upTo6BorderColors?.color5!= null) {
      borderColors.add(upTo6BorderColors!.color5!.flutterValue);
    }
    if (upTo6BorderColors?.color6!= null) {
      borderColors.add(upTo6BorderColors!.color6!.flutterValue);
    }
    BoxBorder? border;
    if (borderColors.length == 1) {
      border = Border.all(color: borderColors.first, width: thickness ?? 3);
    } else if (borderColors.length > 1) {
      // const rainbowGradient = LinearGradient(colors: [Colors.blue, Colors.green, Colors.yellow, Colors.red, Colors.purpleAccent]);
      LinearGradient borderGradient = LinearGradient(colors: borderColors);
      border =
          GradientBoxBorder(gradient: borderGradient, width: thickness ?? 3);
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
            side: BorderSide(
                color: borderColors.firstOrNull ?? Colors.black,
                width: thickness ?? 1),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 6)),
          ),
          color: fillGradient != null ? null : fillColor ?? Colors.white,
          gradient: fillGradient,
        ),
      DecorationShapeEnum.stadium => ShapeDecoration(
          shape: StadiumBorder(
            side: BorderSide(
                color: borderColors.firstOrNull ?? Colors.black,
                width: thickness ?? 2),
          ),
          color: fillGradient != null ? null : fillColor ?? Colors.white,
          gradient: fillGradient,
        ),
      DecorationShapeEnum.star => ShapeDecoration(
          shape: StarBorder(
            side: BorderSide(
                color: borderColors.firstOrNull ?? Colors.black,
                width: thickness ?? 2),
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

  static DecorationShapeEnum? of(int? index) =>
      index != null ? DecorationShapeEnum.values.elementAtOrNull(index) : null;
}
