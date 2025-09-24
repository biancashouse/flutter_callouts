import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';
import 'package:gap/gap.dart' show Gap;
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

  static DecorationShape fromName(String shapeName) {
    switch (shapeName) {
      case "rectangle":
        return DecorationShape.rectangle();
      case "rounded_rectangle":
        return DecorationShape.rounded_rectangle();
        case "rectangle_dotted":
        return DecorationShape.rectangle_dotted();
      case "rounded_rectangle_dotted":
        return DecorationShape.rounded_rectangle_dotted();
      case "circle":
        return DecorationShape.circle();
      case "bevelled":
        return DecorationShape.bevelled();
      case "stadium":
        return DecorationShape.stadium();
      case "star":
        return DecorationShape.star();
      default:
        return DecorationShape.rectangle();
    }
  }

  static List<DecorationShape> shapeList() => [
      DecorationShape.rectangle(),
      DecorationShape.rounded_rectangle(),
      DecorationShape.rectangle_dotted(),
      DecorationShape.rounded_rectangle_dotted(),
      DecorationShape.circle(),
      DecorationShape.bevelled(),
      DecorationShape.stadium(),
      DecorationShape.star(),
    ];

  Widget toMenuItem({bool skipLabel = true}) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Gap(8),
      SizedBox(
        width: 50,
        height: 30,
        child: Container(width: 10, height: 10, decoration: toDecoration()),
      ),
      const Gap(8),
    ],
  );

  Decoration toDecoration({
    ColorOrGradient? fillColorOrGradient,
    ColorOrGradient? borderColorOrGradient,
    double? borderThickness,
    double? borderRadius,
    int? starPoints,
  }) {
    BoxBorder? border;
    if (borderColorOrGradient?.isASingleColor() ?? false) {
      border = Border.all(
        color: borderColorOrGradient!.color!,
        width: borderThickness ?? 0.0,
      );
    } else if (borderColorOrGradient?.isAGradient() ?? false) {
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

  // static final List<DecorationShapeEntry>
  // entries = UnmodifiableListView<DecorationShapeEntry>([
  //   DecorationShapeEntry(
  //     value: DecorationShape.rectangle(),
  //     label: 'rectangle',
  //   ),
  //   DecorationShapeEntry(
  //     value: DecorationShape.rectangle_dotted(),
  //     label: 'rectangle dotted',
  //   ),
  //   DecorationShapeEntry(
  //     value: DecorationShape.rounded_rectangle(),
  //     label: 'rounded rect',
  //   ),
  //   DecorationShapeEntry(
  //     value: DecorationShape.rounded_rectangle_dotted(),
  //     label: 'rounded rect, dotted',
  //   ),
  //   DecorationShapeEntry(value: DecorationShape.circle(), label: 'circle'),
  //   DecorationShapeEntry(value: DecorationShape.stadium(), label: 'stadium'),
  //   DecorationShapeEntry(value: DecorationShape.bevelled(), label: 'bevelled'),
  //   DecorationShapeEntry(value: DecorationShape.star(), label: 'star'),
  // ]);
}

// typedef DecorationShapeEntry = DropdownMenuEntry<DecorationShape>;
