import 'package:flutter/material.dart';


enum AlignmentEnum   {
  topLeft(Alignment.topLeft),
  topCenter(Alignment.topCenter),
  topRight(Alignment.topRight),
  centerLeft(Alignment.centerLeft),
  center(Alignment.center),
  centerRight(Alignment.centerRight),
  bottomLeft(Alignment.bottomLeft),
  bottomCenter(Alignment.bottomCenter),
  bottomRight(Alignment.bottomRight);

  const AlignmentEnum(this.flutterValue);

  final Alignment flutterValue;

  @override
  String toString() => flutterValue.toString();

  static AlignmentEnum fromFlutterValue(Alignment flutterValue) => switch (flutterValue) {
    Alignment.topLeft => AlignmentEnum.topLeft,
    Alignment.topCenter => AlignmentEnum.topCenter,
    Alignment.topRight => AlignmentEnum.topRight,
    Alignment.centerLeft => AlignmentEnum.centerLeft,
    Alignment.center => AlignmentEnum.center,
    Alignment.centerRight => AlignmentEnum.centerRight,
    Alignment.bottomLeft => AlignmentEnum.bottomLeft,
    Alignment.bottomCenter => AlignmentEnum.bottomCenter,
    _ => AlignmentEnum.bottomRight,
  };

  AlignmentEnum get oppositeEnum => switch (this) {
    AlignmentEnum.topLeft => AlignmentEnum.bottomRight,
    AlignmentEnum.topCenter => AlignmentEnum.bottomCenter,
    AlignmentEnum.topRight => AlignmentEnum.bottomLeft,
    AlignmentEnum.centerLeft => AlignmentEnum.centerRight,
    AlignmentEnum.center => AlignmentEnum.center,
    AlignmentEnum.centerRight => AlignmentEnum.centerLeft,
    AlignmentEnum.bottomLeft => AlignmentEnum.topRight,
    AlignmentEnum.bottomCenter => AlignmentEnum.topCenter,
    AlignmentEnum.bottomRight => AlignmentEnum.topLeft,
  };

  Widget toMenuItem() => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const SizedBox(
        width: 8,
      ),
      Container(
        width: 30,
        height: 30,
        alignment: flutterValue,
        decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
        ),
        child: Container(
          width: 10,
          height: 10,
          color: Colors.white,
        ),
      ),
      const SizedBox(
        width: 8,
      ),
    ],
  );

  static AlignmentEnum? of(int? index) => index != null ? AlignmentEnum.values.elementAtOrNull(index) : null;
}

extension ExtendedAlignment on Alignment {
  Alignment get opposite => Alignment(-this.x, -this.y);

}
