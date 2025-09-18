
import 'dart:ui';

class UpTo6Colors {
  Color? color1;
  Color? color2;
  Color? color3;
  Color? color4;
  Color? color5;
  Color? color6;

  UpTo6Colors({
    this.color1,
    this.color2,
    this.color3,
    this.color4,
    this.color5,
    this.color6,
  });

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

  bool empty() =>
      color1 == null &&
      color2 == null &&
      color3 == null &&
      color4 == null &&
      color5 == null &&
      color6 == null;

  Color? get onlyColor => asList().isEmpty ? Color(255) : asList().first;

  List<Color> asList() => [
    if (color1 != null) color1!,
    if (color2 != null) color2!,
    if (color3 != null) color3!,
    if (color4 != null) color4!,
    if (color5 != null) color5!,
    if (color6 != null) color6!,
  ];

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
  int get hashCode =>
      Object.hash(color1, color2, color3, color4, color5, color6);
}
