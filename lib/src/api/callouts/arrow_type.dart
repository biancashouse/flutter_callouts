// ignore: constant_identifier_names
enum ArrowType {
  NO_CONNECTOR,
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
      this == ArrowType.VERY_THIN_REVERSED ||
      this == ArrowType.THIN_REVERSED ||
      this == ArrowType.MEDIUM_REVERSED ||
      this == ArrowType.LARGE_REVERSED
      // || this == ArrowType.HUGE_REVERSED
  ;
}
