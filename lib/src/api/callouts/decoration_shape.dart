import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class DecorationShape {
  final String name;

  const DecorationShape.rectangle({this.name="rectangle"});
  const DecorationShape.rounded_rectangle({this.name="rounded_rectangle"});
  const DecorationShape.rectangle_dotted({this.name="rectangle_dotted"});
  const DecorationShape.rounded_rectangle_dotted({this.name="rounded_rectangle_dotted"});
  const DecorationShape.circle({this.name="circle"});
  const DecorationShape.bevelled({this.name="bevelled"});
  const DecorationShape.stadium({this.name="stadium"});
  const DecorationShape.star({this.name="star"});

  Decoration toDecoration({
    UpTo6Colors? upTo6FillColors,
    UpTo6Colors? upTo6BorderColors,
    double? borderThickness,
    double? borderRadius,
    int? starPoints,
    bool? gradientIsLinear,
  }) {
    // if (this != DecorationShapeEnum.rectangle) {
    //   print('blah');
    // }
    // if no fill colors supplied, default to black.
    // if only one color supplied use that as color param
    // if >1 colors supplied use the colors in a gradient
    Color? fillColor;
    List<Color> fillColors = [];
    if (upTo6FillColors?.color1 != null) {
      fillColors.add(upTo6FillColors!.color1!);
    }
    if (upTo6FillColors?.color2 != null) {
      fillColors.add(upTo6FillColors!.color2!);
    }
    if (upTo6FillColors?.color3 != null) {
      fillColors.add(upTo6FillColors!.color3!);
    }
    if (upTo6FillColors?.color4 != null) {
      fillColors.add(upTo6FillColors!.color4!);
    }
    if (upTo6FillColors?.color5 != null) {
      fillColors.add(upTo6FillColors!.color5!);
    }
    if (upTo6FillColors?.color6 != null) {
      fillColors.add(upTo6FillColors!.color6!);
    }
    // fill color or gradient,
    Gradient? fillGradient;
    if (fillColors.length > 1) {
      fillGradient = (gradientIsLinear ?? true)
          ? LinearGradient(colors: fillColors)
          : RadialGradient(colors: fillColors.reversed.toList());
    }
    if (fillColors.length == 1) fillColor = fillColors.first;
    if (fillColors.isEmpty) fillColor = Colors.white;
    List<Color> borderColors = [];
    if (upTo6BorderColors?.color1 != null) {
      borderColors.add(upTo6BorderColors!.color1!);
    }
    if (upTo6BorderColors?.color2 != null) {
      borderColors.add(upTo6BorderColors!.color2!);
    }
    if (upTo6BorderColors?.color3 != null) {
      borderColors.add(upTo6BorderColors!.color3!);
    }
    if (upTo6BorderColors?.color4 != null) {
      borderColors.add(upTo6BorderColors!.color4!);
    }
    if (upTo6BorderColors?.color5 != null) {
      borderColors.add(upTo6BorderColors!.color5!);
    }
    if (upTo6BorderColors?.color6 != null) {
      borderColors.add(upTo6BorderColors!.color6!);
    }
    BoxBorder? border;
    if (borderColors.length == 1) {
      border = Border.all(color: borderColors.first, width: borderThickness??0.0);
    } else if (borderColors.length > 1) {
      // const rainbowGradient = LinearGradient(colors: [Colors.blue, Colors.green, Colors.yellow, Colors.red, Colors.purpleAccent]);
      LinearGradient borderGradient = LinearGradient(colors: borderColors);
      border = GradientBoxBorder(
        gradient: borderGradient,
        width: borderThickness ?? 3,
      );
    }
    if (name == "rectangle")
      return BoxDecoration(
        shape: BoxShape.rectangle,
        border: border,
        gradient: fillGradient,
        color: fillColor,
      );
    if (name == "rounded_rectangle")
      return BoxDecoration(
        shape: BoxShape.rectangle,
        border: border,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 8)),
        gradient: fillGradient,
        color: fillColor,
      );
    if (name == "rectangle_dotted")
      return DottedDecoration(
        shape: Shape.box,
        dash: const <int>[3, 3],
        borderColor: borderColors.firstOrNull ?? Colors.grey,
        strokeWidth: 3,
        fillColor: fillColor ?? Colors.white,
        fillGradient: fillGradient,
      );
    if (name == "rounded_rectangle_dotted")
      return DottedDecoration(
        shape: Shape.box,
        dash: const <int>[3, 3],
        borderColor: borderColors.firstOrNull ?? Colors.grey,
        strokeWidth: 3,
        fillColor: fillColor ?? Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 8)),
        fillGradient: fillGradient,
      );
    if (name == "circle")
      return BoxDecoration(
        shape: BoxShape.circle,
        border: border,
        color: fillGradient != null ? null : fillColor ?? Colors.white,
        gradient: fillGradient,
      );
    if (name == "bevelled")
      return ShapeDecoration(
        shape: BeveledRectangleBorder(
          side: BorderSide(
            color: borderColors.firstOrNull ?? Colors.black,
            width: borderThickness??0.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 6)),
        ),
        color: fillGradient != null ? null : fillColor ?? Colors.white,
        gradient: fillGradient,
      );
    if (name == "stadium")
      return ShapeDecoration(
        shape: StadiumBorder(
          side: BorderSide(
            color: borderColors.firstOrNull ?? Colors.black,
            width: borderThickness??0.0,
          ),
        ),
        color: fillGradient != null ? null : fillColor ?? Colors.white,
        gradient: fillGradient,
      );
    // else its a star
    return ShapeDecoration(
      shape: StarBorder(
        side: BorderSide(
          color: borderColors.firstOrNull ?? Colors.black,
          width: borderThickness??0.0,
        ),
        points: starPoints?.toDouble() ?? 7,
        // innerRadiusRatio: _model.innerRadiusRatio,
        // pointRounding: _model.pointRounding,
        // valleyRounding: _model.valleyRounding,
        // rotation: 0,
      ),
      color: fillGradient != null ? null : fillColor ?? Colors.white,
      gradient: fillGradient,
    );
  }
}
