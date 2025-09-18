import 'dart:collection';

import 'package:flutter/material.dart';


enum TargetPointerTypeEnum {
  NONE,
  BUBBLE,
  VERY_THIN_LINE,
  VERY_THIN_REVERSED_LINE,
  THIN_LINE,
  THIN_REVERSED_LINE,
  MEDIUM_LINE,
  MEDIUM_REVERSED_LINE,
  LARGE_LINE,
  LARGE_REVERSED_LINE,
  // HUGE,
  // HUGE_REVERSED
  ;

  bool get reverse =>
      this == TargetPointerTypeEnum.VERY_THIN_REVERSED_LINE ||
          this == TargetPointerTypeEnum.THIN_REVERSED_LINE ||
          this == TargetPointerTypeEnum.MEDIUM_REVERSED_LINE ||
          this == TargetPointerTypeEnum.LARGE_REVERSED_LINE
  // || this == ArrowType.HUGE_REVERSED
      ;

  static final List<ArrowTypeEntry> entries = UnmodifiableListView<ArrowTypeEntry>(
    values.map<ArrowTypeEntry>(
          (TargetPointerTypeEnum pointerType) =>
          ArrowTypeEntry(
            value: pointerType,
            label: pointerType.name,
            // enabled: color.label != 'Grey',
            // style: MenuItemButton.styleFrom(foregroundColor: color.color),
          ),
    ),
  );
}

typedef ArrowTypeEntry = DropdownMenuEntry<TargetPointerTypeEnum>;
