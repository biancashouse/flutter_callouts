// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'arrow_type_enum.dart';

class ArrowTypeEnumMapper extends EnumMapper<ArrowTypeEnum> {
  ArrowTypeEnumMapper._();

  static ArrowTypeEnumMapper? _instance;
  static ArrowTypeEnumMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ArrowTypeEnumMapper._());
    }
    return _instance!;
  }

  static ArrowTypeEnum fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ArrowTypeEnum decode(dynamic value) {
    switch (value) {
      case r'NONE':
        return ArrowTypeEnum.NONE;
      case r'POINTY':
        return ArrowTypeEnum.POINTY;
      case r'VERY_THIN':
        return ArrowTypeEnum.VERY_THIN;
      case r'VERY_THIN_REVERSED':
        return ArrowTypeEnum.VERY_THIN_REVERSED;
      case r'THIN':
        return ArrowTypeEnum.THIN;
      case r'THIN_REVERSED':
        return ArrowTypeEnum.THIN_REVERSED;
      case r'MEDIUM':
        return ArrowTypeEnum.MEDIUM;
      case r'MEDIUM_REVERSED':
        return ArrowTypeEnum.MEDIUM_REVERSED;
      case r'LARGE':
        return ArrowTypeEnum.LARGE;
      case r'LARGE_REVERSED':
        return ArrowTypeEnum.LARGE_REVERSED;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ArrowTypeEnum self) {
    switch (self) {
      case ArrowTypeEnum.NONE:
        return r'NONE';
      case ArrowTypeEnum.POINTY:
        return r'POINTY';
      case ArrowTypeEnum.VERY_THIN:
        return r'VERY_THIN';
      case ArrowTypeEnum.VERY_THIN_REVERSED:
        return r'VERY_THIN_REVERSED';
      case ArrowTypeEnum.THIN:
        return r'THIN';
      case ArrowTypeEnum.THIN_REVERSED:
        return r'THIN_REVERSED';
      case ArrowTypeEnum.MEDIUM:
        return r'MEDIUM';
      case ArrowTypeEnum.MEDIUM_REVERSED:
        return r'MEDIUM_REVERSED';
      case ArrowTypeEnum.LARGE:
        return r'LARGE';
      case ArrowTypeEnum.LARGE_REVERSED:
        return r'LARGE_REVERSED';
    }
  }
}

extension ArrowTypeEnumMapperExtension on ArrowTypeEnum {
  String toValue() {
    ArrowTypeEnumMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ArrowTypeEnum>(this) as String;
  }
}
