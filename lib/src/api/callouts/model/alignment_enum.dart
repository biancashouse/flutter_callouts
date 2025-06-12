import 'dart:collection';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'alignment_enum.mapper.dart';

@MappableEnum()
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

  // used by example app
  static final List<GravityEntry> entries = UnmodifiableListView<GravityEntry>(
    values.map<GravityEntry>(
          (AlignmentEnum gravity) => GravityEntry(
        value: gravity,
        label: gravity.name,
        // enabled: color.label != 'Grey',
        // style: MenuItemButton.styleFrom(foregroundColor: color.color),
      ),
    ),
  );

  String toSource() => 'Alignment.$name';

  static AlignmentEnum? of(int? index) => index != null ? AlignmentEnum.values.elementAtOrNull(index) : null;
}

typedef GravityEntry = DropdownMenuEntry<AlignmentEnum>;

