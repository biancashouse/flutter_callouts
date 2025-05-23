import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'alignment_model.mapper.dart';

@MappableClass()
class AlignmentModel with AlignmentModelMappable {
  final double x;
  final double y;

  const AlignmentModel(this.x, this.y);

  static const AlignmentModel topLeft = AlignmentModel(-1.0, -1.0);

  /// The center point along the top edge.
  static const AlignmentModel topCenter = AlignmentModel(0.0, -1.0);

  /// The top right corner.
  static const AlignmentModel topRight = AlignmentModel(1.0, -1.0);

  /// The center point along the left edge.
  static const AlignmentModel centerLeft = AlignmentModel(-1.0, 0.0);

  /// The center point, both horizontally and vertically.
  static const AlignmentModel center = AlignmentModel(0.0, 0.0);

  /// The center point along the right edge.
  static const AlignmentModel centerRight = AlignmentModel(1.0, 0.0);

  /// The bottom left corner.
  static const AlignmentModel bottomLeft = AlignmentModel(-1.0, 1.0);

  /// The center point along the bottom edge.
  static const AlignmentModel bottomCenter = AlignmentModel(0.0, 1.0);

  /// The bottom right corner.
  static const AlignmentModel bottomRight = AlignmentModel(1.0, 1.0);

  Alignment get value => Alignment(x,y);
}
