// import 'dart:collection';
//
// import 'package:flutter/material.dart';
//
//
// enum TargetPointerType {
//   NONE,
//   BUBBLE,
//   VERY_THIN_LINE,
//   VERY_THIN_REVERSED_LINE,
//   THIN_LINE,
//   THIN_REVERSED_LINE,
//   MEDIUM_LINE,
//   MEDIUM_REVERSED_LINE,
//   LARGE_LINE,
//   LARGE_REVERSED_LINE,
//   // HUGE,
//   // HUGE_REVERSED
//   ;
//
//   bool get reverse =>
//       this == TargetPointerType.VERY_THIN_REVERSED_LINE ||
//           this == TargetPointerType.THIN_REVERSED_LINE ||
//           this == TargetPointerType.MEDIUM_REVERSED_LINE ||
//           this == TargetPointerType.LARGE_REVERSED_LINE
//   // || this == ArrowType.HUGE_REVERSED
//       ;
//
//   static final List<ArrowTypeEntry> entries = UnmodifiableListView<ArrowTypeEntry>(
//     values.map<ArrowTypeEntry>(
//           (TargetPointerType pointerType) =>
//           ArrowTypeEntry(
//             value: pointerType,
//             label: pointerType.name,
//             // enabled: color.label != 'Grey',
//             // style: MenuItemButton.styleFrom(foregroundColor: color.color),
//           ),
//     ),
//   );
// }
//
// typedef ArrowTypeEntry = DropdownMenuEntry<TargetPointerType>;
