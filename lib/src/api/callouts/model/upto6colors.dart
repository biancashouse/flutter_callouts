import 'dart:ui';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_callouts/flutter_callouts.dart' show ColorModel, ColorModelCopyWith, ColorModelMapper;

part 'upto6colors.mapper.dart';

@MappableClass()
class UpTo6Colors with UpTo6ColorsMappable {
  ColorModel? color1;
  ColorModel? color2;
  ColorModel? color3;
  ColorModel? color4;
  ColorModel? color5;
  ColorModel? color6;

  // deprecated
  int? color1Value;
  int? color2Value;
  int? color3Value;
  int? color4Value;
  int? color5Value;
  int? color6Value;

  UpTo6Colors({
    this.color1,
    this.color2,
    this.color3,
    this.color4,
    this.color5,
    this.color6,

    // deprecated: changed from ints to ColorModels
    this.color1Value,
    this.color2Value,
    this.color3Value,
    this.color4Value,
    this.color5Value,
    this.color6Value,
  }) {
    if (color1Value != null) {
      color1 = ColorModel.fromColor(Color(color1Value!));
    }
    if (color2Value != null) {
      color2 = ColorModel.fromColor(Color(color2Value!));
    }
    if (color3Value != null) {
      color3 = ColorModel.fromColor(Color(color3Value!));
    }
    if (color4Value != null) {
      color4 = ColorModel.fromColor(Color(color4Value!));
    }
    if (color5Value != null) {
      color5 = ColorModel.fromColor(Color(color5Value!));
    }
    if (color6Value != null) {
      color6 = ColorModel.fromColor(Color(color6Value!));
    }
  }

  bool isAGradient() {
    int count = 0;
    if (color1 != null) count++;
    if (color2 != null) count++;
    if (color3 != null) count++;
    if (color4 != null) count++;
    if (color5 != null) count++;
    if (color6 != null) count++;
    return count > 1;
  }

  @override
  operator ==(o) =>
      o is UpTo6Colors &&
          color1 == o.color1 &&
          color2 == o.color2 &&
          color3 == o.color3 &&
          color4 == o.color4 &&
          color5 == o.color5 &&
          color6 == o.color6;

  @override
  int get hashCode => Object.hash(color1, color2, color3, color4, color5, color6);
}
