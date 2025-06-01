import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'color_model.mapper.dart';

@MappableClass()
class ColorModel with ColorModelMappable {
  final double a;
  final double r;
  final double g;
  final double b;

  const ColorModel(this.a, this.r, this.g, this.b);

  factory ColorModel.fromColor(Color color) => ColorModel(
        color.a,
        color.r,
        color.g,
        color.b,
      );

  factory ColorModel.transparent() => ColorModel.fromColor(Colors.transparent);
  factory ColorModel.black() => ColorModel.fromColor(Colors.black);
  factory ColorModel.black87() => ColorModel.fromColor(Colors.black87);
  factory ColorModel.black54() => ColorModel.fromColor(Colors.black54);
  factory ColorModel.black45() => ColorModel.fromColor(Colors.black45);
  factory ColorModel.black38() => ColorModel.fromColor(Colors.black38);
  factory ColorModel.black26() => ColorModel.fromColor(Colors.black26);
  factory ColorModel.black12() => ColorModel.fromColor(Colors.black12);
  factory ColorModel.white() => ColorModel.fromColor(Colors.white);
  factory ColorModel.white70() => ColorModel.fromColor(Colors.white70);
  factory ColorModel.white60() => ColorModel.fromColor(Colors.white60);
  factory ColorModel.white54() => ColorModel.fromColor(Colors.white54);
  factory ColorModel.white38() => ColorModel.fromColor(Colors.white38);
  factory ColorModel.white30() => ColorModel.fromColor(Colors.white30);
  factory ColorModel.white24() => ColorModel.fromColor(Colors.white24);
  factory ColorModel.white12() => ColorModel.fromColor(Colors.white12);
  factory ColorModel.white10() => ColorModel.fromColor(Colors.white10);
  factory ColorModel.blue() => ColorModel.fromColor(Colors.blue);
  factory ColorModel.blueAccent() => ColorModel.fromColor(Colors.blueAccent);
  factory ColorModel.blueGrey() => ColorModel.fromColor(Colors.blueGrey);
  factory ColorModel.lightBlue() => ColorModel.fromColor(Colors.lightBlue);
  factory ColorModel.lightBlueAccent() => ColorModel.fromColor(Colors.lightBlueAccent);
  factory ColorModel.red() => ColorModel.fromColor(Colors.red);
  factory ColorModel.redAccent() => ColorModel.fromColor(Colors.redAccent);
  factory ColorModel.pink() => ColorModel.fromColor(Colors.pink);
  factory ColorModel.pinkAccent() => ColorModel.fromColor(Colors.pinkAccent);
  factory ColorModel.purple() => ColorModel.fromColor(Colors.purple);
  factory ColorModel.purpleAccent() => ColorModel.fromColor(Colors.purpleAccent);
  factory ColorModel.deepPurple() => ColorModel.fromColor(Colors.deepPurple);
  factory ColorModel.deepPurpleAccent() => ColorModel.fromColor(Colors.deepPurpleAccent);
  factory ColorModel.indigo() => ColorModel.fromColor(Colors.indigo);
  factory ColorModel.indigoAccent() => ColorModel.fromColor(Colors.indigoAccent);
  factory ColorModel.cyan() => ColorModel.fromColor(Colors.cyan);
  factory ColorModel.cyanAccent() => ColorModel.fromColor(Colors.cyanAccent);
  factory ColorModel.teal() => ColorModel.fromColor(Colors.teal);
  factory ColorModel.tealAccent() => ColorModel.fromColor(Colors.tealAccent);
  factory ColorModel.green() => ColorModel.fromColor(Colors.green);
  factory ColorModel.greenAccent() => ColorModel.fromColor(Colors.greenAccent);
  factory ColorModel.lightGreen() => ColorModel.fromColor(Colors.lightGreen);
  factory ColorModel.lightGreenAccent() => ColorModel.fromColor(Colors.lightGreenAccent);
  factory ColorModel.lime() => ColorModel.fromColor(Colors.lime);
  factory ColorModel.limeAccent() => ColorModel.fromColor(Colors.limeAccent);
  factory ColorModel.yellow() => ColorModel.fromColor(Colors.yellow);
  factory ColorModel.yellowAccent() => ColorModel.fromColor(Colors.yellowAccent);
  factory ColorModel.amber() => ColorModel.fromColor(Colors.amber);
  factory ColorModel.amberAccent() => ColorModel.fromColor(Colors.amberAccent);
  factory ColorModel.orange() => ColorModel.fromColor(Colors.orange);
  factory ColorModel.orangeAccent() => ColorModel.fromColor(Colors.orangeAccent);
  factory ColorModel.deepOrange() => ColorModel.fromColor(Colors.deepOrange);
  factory ColorModel.deepOrangeAccent() => ColorModel.fromColor(Colors.deepOrangeAccent);
  factory ColorModel.brown() => ColorModel.fromColor(Colors.brown);
  factory ColorModel.grey() => ColorModel.fromColor(Colors.grey);

  Color get flutterValue => Color.from(alpha: a, red: r, green: g, blue: b);
}
