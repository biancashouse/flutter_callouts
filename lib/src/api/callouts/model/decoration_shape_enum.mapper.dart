// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'decoration_shape_enum.dart';

class DecorationShapeEnumMapper extends EnumMapper<DecorationShapeEnum> {
  DecorationShapeEnumMapper._();

  static DecorationShapeEnumMapper? _instance;
  static DecorationShapeEnumMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DecorationShapeEnumMapper._());
    }
    return _instance!;
  }

  static DecorationShapeEnum fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  DecorationShapeEnum decode(dynamic value) {
    switch (value) {
      case r'rectangle':
        return DecorationShapeEnum.rectangle;
      case r'rounded_rectangle':
        return DecorationShapeEnum.rounded_rectangle;
      case r'rectangle_dotted':
        return DecorationShapeEnum.rectangle_dotted;
      case r'rounded_rectangle_dotted':
        return DecorationShapeEnum.rounded_rectangle_dotted;
      case r'circle':
        return DecorationShapeEnum.circle;
      case r'bevelled':
        return DecorationShapeEnum.bevelled;
      case r'stadium':
        return DecorationShapeEnum.stadium;
      case r'star':
        return DecorationShapeEnum.star;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(DecorationShapeEnum self) {
    switch (self) {
      case DecorationShapeEnum.rectangle:
        return r'rectangle';
      case DecorationShapeEnum.rounded_rectangle:
        return r'rounded_rectangle';
      case DecorationShapeEnum.rectangle_dotted:
        return r'rectangle_dotted';
      case DecorationShapeEnum.rounded_rectangle_dotted:
        return r'rounded_rectangle_dotted';
      case DecorationShapeEnum.circle:
        return r'circle';
      case DecorationShapeEnum.bevelled:
        return r'bevelled';
      case DecorationShapeEnum.stadium:
        return r'stadium';
      case DecorationShapeEnum.star:
        return r'star';
    }
  }
}

extension DecorationShapeEnumMapperExtension on DecorationShapeEnum {
  String toValue() {
    DecorationShapeEnumMapper.ensureInitialized();
    return MapperContainer.globals.toValue<DecorationShapeEnum>(this) as String;
  }
}

