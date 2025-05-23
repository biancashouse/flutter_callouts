import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'offset_model.mapper.dart';

@MappableClass()
class OffsetModel with OffsetModelMappable {
  final double dx;
  final double dy;

  OffsetModel(this.dx, this.dy);

  factory OffsetModel.fromOffset(Offset offset) =>
      OffsetModel(offset.dx, offset.dy);

  Offset get value => Offset(dx, dy);
}
