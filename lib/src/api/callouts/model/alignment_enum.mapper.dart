// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'alignment_enum.dart';

class AlignmentEnumMapper extends EnumMapper<AlignmentEnum> {
  AlignmentEnumMapper._();

  static AlignmentEnumMapper? _instance;
  static AlignmentEnumMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AlignmentEnumMapper._());
    }
    return _instance!;
  }

  static AlignmentEnum fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  AlignmentEnum decode(dynamic value) {
    switch (value) {
      case r'topLeft':
        return AlignmentEnum.topLeft;
      case r'topCenter':
        return AlignmentEnum.topCenter;
      case r'topRight':
        return AlignmentEnum.topRight;
      case r'centerLeft':
        return AlignmentEnum.centerLeft;
      case r'center':
        return AlignmentEnum.center;
      case r'centerRight':
        return AlignmentEnum.centerRight;
      case r'bottomLeft':
        return AlignmentEnum.bottomLeft;
      case r'bottomCenter':
        return AlignmentEnum.bottomCenter;
      case r'bottomRight':
        return AlignmentEnum.bottomRight;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(AlignmentEnum self) {
    switch (self) {
      case AlignmentEnum.topLeft:
        return r'topLeft';
      case AlignmentEnum.topCenter:
        return r'topCenter';
      case AlignmentEnum.topRight:
        return r'topRight';
      case AlignmentEnum.centerLeft:
        return r'centerLeft';
      case AlignmentEnum.center:
        return r'center';
      case AlignmentEnum.centerRight:
        return r'centerRight';
      case AlignmentEnum.bottomLeft:
        return r'bottomLeft';
      case AlignmentEnum.bottomCenter:
        return r'bottomCenter';
      case AlignmentEnum.bottomRight:
        return r'bottomRight';
    }
  }
}

extension AlignmentEnumMapperExtension on AlignmentEnum {
  String toValue() {
    AlignmentEnumMapper.ensureInitialized();
    return MapperContainer.globals.toValue<AlignmentEnum>(this) as String;
  }
}
