import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'offset_model.mapper.dart';

@MappableClass()
class OffsetModel extends Offset with OffsetModelMappable {
  const OffsetModel(super.dx, super.dy);

  factory OffsetModel.fromOffset(final Offset offset) =>
      OffsetModel(offset.dx, offset.dy);

  factory OffsetModel.zero() => const OffsetModel(0, 0);

  OffsetModel translate(double translateX, double translateY) =>
      OffsetModel(dx + translateX, dy + translateY);

  Offset get value => Offset(dx, dy);
}
