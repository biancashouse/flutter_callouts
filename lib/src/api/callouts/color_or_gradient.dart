import 'package:flutter/material.dart';

class ColorOrGradient {
  final List<Color> colors;
  final bool isLinear;

  ColorOrGradient.gradient(this.colors, {this.isLinear = true /* always true for borders */});
  ColorOrGradient.color(Color singleColor) : colors = [singleColor], isLinear = true;

  bool isAGradient() => colors.length > 1;
  bool isASingleColor() => colors.length == 1;

  bool empty() => colors.isEmpty;

  Color? get color => colors.length == 1 ? colors.first : null;

  Gradient? get gradient => isAGradient()
      ? (isLinear
            ? LinearGradient(colors: colors)
            : RadialGradient(colors: colors))
      : null;

  Color? get color1 => colors.isNotEmpty ? colors[0] : null;

  Color? get color2 => colors.length > 1 ? colors[1] : null;

  Color? get color3 => colors.length > 2 ? colors[2] : null;

  Color? get color4 => colors.length > 3 ? colors[3] : null;

  Color? get color5 => colors.length > 4 ? colors[4] : null;

  Color? get color6 => colors.length > 5 ? colors[5] : null;
}
