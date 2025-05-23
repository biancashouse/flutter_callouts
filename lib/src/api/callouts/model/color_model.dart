import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'color_model.mapper.dart';

@MappableClass()
class ColorModel with ColorModelMappable {
  final int a;
  final int r;
  final int g;
  final int b;

  ColorModel(this.a, this.r, this.g, this.b);

  factory ColorModel.fromColor(Color color) => ColorModel(
        color.a.toInt(),
        color.r.toInt(),
        color.g.toInt(),
        color.b.toInt(),
      );

  Color get value => Color.fromARGB(a, r, g, b);
}
