import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class DecorationShape {
  final String name;

  const DecorationShape.rectangle({this.name = "rectangle"});

  const DecorationShape.rounded_rectangle({this.name = "rounded_rectangle"});

  const DecorationShape.rectangle_dotted({this.name = "rectangle_dotted"});

  const DecorationShape.rounded_rectangle_dotted({
    this.name = "rounded_rectangle_dotted",
  });

  const DecorationShape.circle({this.name = "circle"});

  const DecorationShape.bevelled({this.name = "bevelled"});

  const DecorationShape.stadium({this.name = "stadium"});

  const DecorationShape.star({this.name = "star"});

  Decoration toDecoration({
    ColorOrGradient? fillColorOrGradient,
    ColorOrGradient? borderColorOrGradient,
    double? borderThickness,
    double? borderRadius,
    int? starPoints,
  }) {
    BoxBorder? border;
    if (borderColorOrGradient?.isASingleColor()??false) {
      border = Border.all(
        color: borderColorOrGradient!.color!,
        width: borderThickness ?? 0.0,
      );
    } else if (borderColorOrGradient?.isAGradient()??false) {
      border = GradientBoxBorder(
        gradient: borderColorOrGradient!.gradient!,
        width: borderThickness ?? 3,
      );
    }
    if (name == "rectangle")
      return BoxDecoration(
        shape: BoxShape.rectangle,
        border: border,
        gradient: fillColorOrGradient?.gradient,
        color: fillColorOrGradient?.color,
      );
    if (name == "rounded_rectangle")
      return BoxDecoration(
        shape: BoxShape.rectangle,
        border: border,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 8)),
        gradient: fillColorOrGradient?.gradient,
        color: fillColorOrGradient?.color,
      );
    if (name == "rectangle_dotted")
      return DottedDecoration(
        shape: Shape.box,
        dash: const <int>[3, 3],
        borderColor: borderColorOrGradient?.color ?? Colors.grey,
        strokeWidth: 3,
        fillGradient: fillColorOrGradient?.gradient,
        fillColor: fillColorOrGradient?.color ?? Colors.white,
      );
    if (name == "rounded_rectangle_dotted")
      return DottedDecoration(
        shape: Shape.box,
        dash: const <int>[3, 3],
        borderColor: borderColorOrGradient?.color ?? Colors.grey,
        strokeWidth: 3,
        fillColor: fillColorOrGradient?.color ?? Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 8)),
        fillGradient: fillColorOrGradient?.gradient,
      );
    if (name == "circle")
      return BoxDecoration(
        shape: BoxShape.circle,
        border: border,
        color: fillColorOrGradient?.color,
        gradient: fillColorOrGradient?.gradient,
      );
    if (name == "bevelled")
      return ShapeDecoration(
        shape: BeveledRectangleBorder(
          side: BorderSide(
            color: borderColorOrGradient?.colors.firstOrNull ?? Colors.black,
            width: borderThickness ?? 0.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 8)),
        ),
        color: fillColorOrGradient?.color,
        gradient: fillColorOrGradient?.gradient,
      );
    if (name == "stadium")
      return ShapeDecoration(
        shape: StadiumBorder(
          side: BorderSide(
            color: borderColorOrGradient?.colors.firstOrNull ?? Colors.black,
            width: borderThickness ?? 0.0,
          ),
        ),
        color: fillColorOrGradient?.color,
        gradient: fillColorOrGradient?.gradient,
      );
    // else its a star
    return ShapeDecoration(
      shape: StarBorder(
        side: BorderSide(
          color: borderColorOrGradient?.colors.firstOrNull ?? Colors.black,
          width: borderThickness ?? 0.0,
        ),
        points: starPoints?.toDouble() ?? 7,
        // innerRadiusRatio: _model.innerRadiusRatio,
        // pointRounding: _model.pointRounding,
        // valleyRounding: _model.valleyRounding,
        // rotation: 0,
      ),
      color: fillColorOrGradient?.color,
      gradient: fillColorOrGradient?.gradient,
    );
  }

  // Decoration toDecoration2({
  //   ColorOrGradient? fillColors,
  //   ColorOrGradient? borderColors,
  //   double? borderThickness,
  //   double? borderRadius,
  //   int? starPoints,
  //   bool? gradientIsLinear,
  // }) {
  //   // fill
  //   late Gradient? fillGradient;
  //   // fill color or gradient,
  //   if (fillColors == null) {
  //     fillColors = GradientColors([Colors.white]);
  //   } else if (fillColors.colors.isEmpty) {
  //     fillColors.colors.add(Colors.white);
  //   }
  //   if (fillColors.colors.length > 1) {
  //     fillGradient = (gradientIsLinear ?? true)
  //         ? LinearGradient(colors: fillColors.colors)
  //         : RadialGradient(colors: fillColors.colors.reversed.toList());
  //   }
  //   // border
  //   late Gradient? borderGradient;
  //   BoxBorder? border;
  //   if (borderColors != null) {
  //     if (borderColors.colors.length > 1) {
  //       // const rainbowGradient = LinearGradient(colors: [Colors.blue, Colors.green, Colors.yellow, Colors.red, Colors.purpleAccent]);
  //       borderGradient = LinearGradient(colors: borderColors.colors);
  //       border = GradientBoxBorder(
  //         gradient: borderGradient,
  //         width: borderThickness ?? 3,
  //       );
  //     }
  //   }
  //   if (name == "rectangle")
  //     return BoxDecoration(
  //       shape: BoxShape.rectangle,
  //       border: border,
  //       gradient: fillGradient,
  //       color: fillColors.colors.length == 1 ? fillColors.colors.first : null,
  //     );
  //   if (name == "rounded_rectangle")
  //     return BoxDecoration(
  //       shape: BoxShape.rectangle,
  //       border: border,
  //       borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 8)),
  //       gradient: fillGradient,
  //       color: fillColors.colors.length == 1 ? fillColors.colors.first : null,
  //     );
  //   if (name == "rectangle_dotted")
  //     return DottedDecoration(
  //       shape: Shape.box,
  //       dash: const <int>[3, 3],
  //       borderColor: borderColors?.colors.firstOrNull ?? Colors.grey,
  //       borderGradient: borderGradient,
  //       strokeWidth: 3,
  //       fillGradient: fillGradient,
  //       fillColor: fillColors.colors.length == 1
  //           ? fillColors.colors.first
  //           : Colors.white,
  //     );
  //   if (name == "rounded_rectangle_dotted")
  //     return DottedDecoration(
  //       shape: Shape.box,
  //       dash: const <int>[3, 3],
  //       strokeWidth: 3,
  //       fillColor: fillColors.colors.length == 1
  //           ? fillColors.colors.first
  //           : Colors.white,
  //       fillGradient: fillGradient,
  //       borderGradient: borderGradient,
  //       borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 8)),
  //     );
  //   if (name == "circle")
  //     return BoxDecoration(
  //       shape: BoxShape.circle,
  //       border: border,
  //       color: fillColors.colors.length == 1 ? fillColors.colors.first : null,
  //       gradient: fillGradient,
  //     );
  //   if (name == "bevelled")
  //     return ShapeDecoration(
  //       shape: BeveledRectangleBorder(
  //         side: BorderSide(
  //           color: borderColors?.colors.length == 1
  //               ? borderColors?.colors.firstOrNull ?? Colors.grey
  //               : Colors.grey,
  //           width: borderThickness ?? 0.0,
  //         ),
  //         borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 6)),
  //       ),
  //       color: fillColors.colors.length == 1 ? fillColors.colors.first : null,
  //       gradient: fillGradient,
  //     );
  //   if (name == "stadium")
  //     return ShapeDecoration(
  //       shape: StadiumBorder(
  //         side: BorderSide(
  //           color: borderColors?.colors.length == 1
  //               ? borderColors?.colors.firstOrNull ?? Colors.grey
  //               : Colors.grey,
  //           width: borderThickness ?? 0.0,
  //         ),
  //       ),
  //       color: fillColors.colors.length == 1 ? fillColors.colors.first : null,
  //       gradient: fillGradient,
  //     );
  //   // else its a star
  //   return ShapeDecoration(
  //     shape: StarBorder(
  //       side: BorderSide(
  //         color: borderColors?.colors.length == 1
  //             ? borderColors?.colors.firstOrNull ?? Colors.grey
  //             : Colors.grey,
  //         width: borderThickness ?? 0.0,
  //       ),
  //       points: starPoints?.toDouble() ?? 7,
  //       // innerRadiusRatio: _model.innerRadiusRatio,
  //       // pointRounding: _model.pointRounding,
  //       // valleyRounding: _model.valleyRounding,
  //       // rotation: 0,
  //     ),
  //     color: fillColors.colors.length == 1 ? fillColors.colors.first : null,
  //     gradient: fillGradient,
  //   );
  // }
}
