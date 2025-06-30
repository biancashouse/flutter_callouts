import 'dart:collection';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'arrow_type_enum.mapper.dart';

@MappableEnum()
enum ArrowTypeEnum {
  NONE,
  POINTY,
  VERY_THIN,
  VERY_THIN_REVERSED,
  THIN,
  THIN_REVERSED,
  MEDIUM,
  MEDIUM_REVERSED,
  LARGE,
  LARGE_REVERSED,
  // HUGE,
  // HUGE_REVERSED
  ;

  bool get reverse =>
      this == ArrowTypeEnum.VERY_THIN_REVERSED ||
          this == ArrowTypeEnum.THIN_REVERSED ||
          this == ArrowTypeEnum.MEDIUM_REVERSED ||
          this == ArrowTypeEnum.LARGE_REVERSED
  // || this == ArrowType.HUGE_REVERSED
      ;

  static final List<ArrowTypeEntry> entries = UnmodifiableListView<ArrowTypeEntry>(
    values.map<ArrowTypeEntry>(
          (ArrowTypeEnum pointerType) =>
          ArrowTypeEntry(
            value: pointerType,
            label: pointerType.name,
            // enabled: color.label != 'Grey',
            // style: MenuItemButton.styleFrom(foregroundColor: color.color),
          ),
    ),
  );
}

typedef ArrowTypeEntry = DropdownMenuEntry<ArrowTypeEnum>;
