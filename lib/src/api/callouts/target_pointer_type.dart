import 'dart:collection';

import 'package:flutter/material.dart';


class TargetPointerType{
  final String name;

  const TargetPointerType.none({this.name="none"});
  const TargetPointerType.bubble({this.name="bubble"});
  const TargetPointerType.very_thin_line({this.name="very_thin_line"});
  const TargetPointerType.very_thin_reversed_line({this.name="very_thin_reversed_line"});
  const TargetPointerType.thin_line({this.name="thin_line"});
  const TargetPointerType.thin_reversed_line({this.name="thin_reversed_line"});
  const TargetPointerType.medium_line({this.name="medium_line"});
  const TargetPointerType.medium_reversed_line({this.name="medium_reversed_line"});
  const TargetPointerType.large_line({this.name="large_line"});
  const TargetPointerType.large_reversed_line({this.name="large_reversed_line"});

  bool get reverse =>
      name == "very_thin_reversed_line" ||
          name == "thin_reversed_line" ||
          name == "medium_reversed_line" ||
          name == "large_reversed_line"
  // || this == ArrowType.HUGE_REVERSED
      ;

  static final List<TargetPointerTypeEntry> entries = UnmodifiableListView<TargetPointerTypeEntry>(
    [
      TargetPointerTypeEntry(value: TargetPointerType.none(), label: 'none'),
      TargetPointerTypeEntry(value: TargetPointerType.bubble(), label: 'bubble'),
      TargetPointerTypeEntry(value: TargetPointerType.very_thin_line(), label: 'very thin line'),
      TargetPointerTypeEntry(value: TargetPointerType.very_thin_reversed_line(), label: 'very thin reversed line'),
      TargetPointerTypeEntry(value: TargetPointerType.thin_line(), label: 'thin line'),
      TargetPointerTypeEntry(value: TargetPointerType.thin_reversed_line(), label: 'thin reversed line'),
      TargetPointerTypeEntry(value: TargetPointerType.medium_line(), label: 'medium line'),
      TargetPointerTypeEntry(value: TargetPointerType.medium_reversed_line(), label: 'medium reversed line'),
      TargetPointerTypeEntry(value: TargetPointerType.large_line(), label: 'large line'),
      TargetPointerTypeEntry(value: TargetPointerType.large_reversed_line(), label: 'large reversed line'),
    ]
  );
}

typedef TargetPointerTypeEntry = DropdownMenuEntry<TargetPointerType>;
