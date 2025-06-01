// import 'package:dart_mappable/dart_mappable.dart';
// import 'package:flutter/material.dart';
//
// part 'alignment_model.mapper.dart';
//
// @MappableClass()
// class AlignmentModel with AlignmentModelMappable {
//   final double x;
//   final double y;
//
//   AlignmentModel(this.x, this.y);
//
//   factory AlignmentModel.fromAlignment(Alignment al) => AlignmentModel(
//     al.x,
//     al.y,
//   );
//
//   Offset withinRect(Rect rect) => value.withinRect(rect);
//
//   factory AlignmentModel.topLeft() => AlignmentModel(-1.0, -1.0);
//
//
//   /// The center point along the top edge.
//   factory AlignmentModel.topCenter()=> AlignmentModel(0.0, -1.0);
//
//   /// The top right corner.
//   factory AlignmentModel.topRight()=> AlignmentModel(1.0, -1.0);
//
//   /// The center point along the left edge.
//   factory AlignmentModel.centerLeft()=> AlignmentModel(-1.0, 0.0);
//
//   /// The center point, both horizontally and vertically.
//   factory AlignmentModel.center()=> AlignmentModel(0.0, 0.0);
//
//   /// The center point along the right edge.
//   factory AlignmentModel.centerRight()=> AlignmentModel(1.0, 0.0);
//
//   /// The bottom left corner.
//   factory AlignmentModel.bottomLeft()=> AlignmentModel(-1.0, 1.0);
//
//   /// The center point along the bottom edge.
//   factory AlignmentModel.bottomCenter()=> AlignmentModel(0.0, 1.0);
//
//   /// The bottom right corner.
//   factory AlignmentModel.bottomRight()=> AlignmentModel(1.0, 1.0);
//
//   Alignment get value => Alignment(x,y);
// }
