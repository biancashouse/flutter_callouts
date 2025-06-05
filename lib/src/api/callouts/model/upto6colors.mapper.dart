// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'upto6colors.dart';

class UpTo6ColorsMapper extends ClassMapperBase<UpTo6Colors> {
  UpTo6ColorsMapper._();

  static UpTo6ColorsMapper? _instance;
  static UpTo6ColorsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UpTo6ColorsMapper._());
      ColorModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'UpTo6Colors';

  static ColorModel? _$color1(UpTo6Colors v) => v.color1;
  static const Field<UpTo6Colors, ColorModel> _f$color1 =
      Field('color1', _$color1, opt: true);
  static ColorModel? _$color2(UpTo6Colors v) => v.color2;
  static const Field<UpTo6Colors, ColorModel> _f$color2 =
      Field('color2', _$color2, opt: true);
  static ColorModel? _$color3(UpTo6Colors v) => v.color3;
  static const Field<UpTo6Colors, ColorModel> _f$color3 =
      Field('color3', _$color3, opt: true);
  static ColorModel? _$color4(UpTo6Colors v) => v.color4;
  static const Field<UpTo6Colors, ColorModel> _f$color4 =
      Field('color4', _$color4, opt: true);
  static ColorModel? _$color5(UpTo6Colors v) => v.color5;
  static const Field<UpTo6Colors, ColorModel> _f$color5 =
      Field('color5', _$color5, opt: true);
  static ColorModel? _$color6(UpTo6Colors v) => v.color6;
  static const Field<UpTo6Colors, ColorModel> _f$color6 =
      Field('color6', _$color6, opt: true);
  static int? _$color1Value(UpTo6Colors v) => v.color1Value;
  static const Field<UpTo6Colors, int> _f$color1Value =
      Field('color1Value', _$color1Value, opt: true);
  static int? _$color2Value(UpTo6Colors v) => v.color2Value;
  static const Field<UpTo6Colors, int> _f$color2Value =
      Field('color2Value', _$color2Value, opt: true);
  static int? _$color3Value(UpTo6Colors v) => v.color3Value;
  static const Field<UpTo6Colors, int> _f$color3Value =
      Field('color3Value', _$color3Value, opt: true);
  static int? _$color4Value(UpTo6Colors v) => v.color4Value;
  static const Field<UpTo6Colors, int> _f$color4Value =
      Field('color4Value', _$color4Value, opt: true);
  static int? _$color5Value(UpTo6Colors v) => v.color5Value;
  static const Field<UpTo6Colors, int> _f$color5Value =
      Field('color5Value', _$color5Value, opt: true);
  static int? _$color6Value(UpTo6Colors v) => v.color6Value;
  static const Field<UpTo6Colors, int> _f$color6Value =
      Field('color6Value', _$color6Value, opt: true);

  @override
  final MappableFields<UpTo6Colors> fields = const {
    #color1: _f$color1,
    #color2: _f$color2,
    #color3: _f$color3,
    #color4: _f$color4,
    #color5: _f$color5,
    #color6: _f$color6,
    #color1Value: _f$color1Value,
    #color2Value: _f$color2Value,
    #color3Value: _f$color3Value,
    #color4Value: _f$color4Value,
    #color5Value: _f$color5Value,
    #color6Value: _f$color6Value,
  };

  static UpTo6Colors _instantiate(DecodingData data) {
    return UpTo6Colors(
        color1: data.dec(_f$color1),
        color2: data.dec(_f$color2),
        color3: data.dec(_f$color3),
        color4: data.dec(_f$color4),
        color5: data.dec(_f$color5),
        color6: data.dec(_f$color6),
        color1Value: data.dec(_f$color1Value),
        color2Value: data.dec(_f$color2Value),
        color3Value: data.dec(_f$color3Value),
        color4Value: data.dec(_f$color4Value),
        color5Value: data.dec(_f$color5Value),
        color6Value: data.dec(_f$color6Value));
  }

  @override
  final Function instantiate = _instantiate;

  static UpTo6Colors fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UpTo6Colors>(map);
  }

  static UpTo6Colors fromJson(String json) {
    return ensureInitialized().decodeJson<UpTo6Colors>(json);
  }
}

mixin UpTo6ColorsMappable {
  String toJson() {
    return UpTo6ColorsMapper.ensureInitialized()
        .encodeJson<UpTo6Colors>(this as UpTo6Colors);
  }

  Map<String, dynamic> toMap() {
    return UpTo6ColorsMapper.ensureInitialized()
        .encodeMap<UpTo6Colors>(this as UpTo6Colors);
  }

  UpTo6ColorsCopyWith<UpTo6Colors, UpTo6Colors, UpTo6Colors> get copyWith =>
      _UpTo6ColorsCopyWithImpl<UpTo6Colors, UpTo6Colors>(
          this as UpTo6Colors, $identity, $identity);
  @override
  String toString() {
    return UpTo6ColorsMapper.ensureInitialized()
        .stringifyValue(this as UpTo6Colors);
  }

  @override
  bool operator ==(Object other) {
    return UpTo6ColorsMapper.ensureInitialized()
        .equalsValue(this as UpTo6Colors, other);
  }

  @override
  int get hashCode {
    return UpTo6ColorsMapper.ensureInitialized().hashValue(this as UpTo6Colors);
  }
}

extension UpTo6ColorsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UpTo6Colors, $Out> {
  UpTo6ColorsCopyWith<$R, UpTo6Colors, $Out> get $asUpTo6Colors =>
      $base.as((v, t, t2) => _UpTo6ColorsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UpTo6ColorsCopyWith<$R, $In extends UpTo6Colors, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ColorModelCopyWith<$R, ColorModel, ColorModel>? get color1;
  ColorModelCopyWith<$R, ColorModel, ColorModel>? get color2;
  ColorModelCopyWith<$R, ColorModel, ColorModel>? get color3;
  ColorModelCopyWith<$R, ColorModel, ColorModel>? get color4;
  ColorModelCopyWith<$R, ColorModel, ColorModel>? get color5;
  ColorModelCopyWith<$R, ColorModel, ColorModel>? get color6;
  $R call(
      {ColorModel? color1,
      ColorModel? color2,
      ColorModel? color3,
      ColorModel? color4,
      ColorModel? color5,
      ColorModel? color6,
      int? color1Value,
      int? color2Value,
      int? color3Value,
      int? color4Value,
      int? color5Value,
      int? color6Value});
  UpTo6ColorsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UpTo6ColorsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UpTo6Colors, $Out>
    implements UpTo6ColorsCopyWith<$R, UpTo6Colors, $Out> {
  _UpTo6ColorsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UpTo6Colors> $mapper =
      UpTo6ColorsMapper.ensureInitialized();
  @override
  ColorModelCopyWith<$R, ColorModel, ColorModel>? get color1 =>
      $value.color1?.copyWith.$chain((v) => call(color1: v));
  @override
  ColorModelCopyWith<$R, ColorModel, ColorModel>? get color2 =>
      $value.color2?.copyWith.$chain((v) => call(color2: v));
  @override
  ColorModelCopyWith<$R, ColorModel, ColorModel>? get color3 =>
      $value.color3?.copyWith.$chain((v) => call(color3: v));
  @override
  ColorModelCopyWith<$R, ColorModel, ColorModel>? get color4 =>
      $value.color4?.copyWith.$chain((v) => call(color4: v));
  @override
  ColorModelCopyWith<$R, ColorModel, ColorModel>? get color5 =>
      $value.color5?.copyWith.$chain((v) => call(color5: v));
  @override
  ColorModelCopyWith<$R, ColorModel, ColorModel>? get color6 =>
      $value.color6?.copyWith.$chain((v) => call(color6: v));
  @override
  $R call(
          {Object? color1 = $none,
          Object? color2 = $none,
          Object? color3 = $none,
          Object? color4 = $none,
          Object? color5 = $none,
          Object? color6 = $none,
          Object? color1Value = $none,
          Object? color2Value = $none,
          Object? color3Value = $none,
          Object? color4Value = $none,
          Object? color5Value = $none,
          Object? color6Value = $none}) =>
      $apply(FieldCopyWithData({
        if (color1 != $none) #color1: color1,
        if (color2 != $none) #color2: color2,
        if (color3 != $none) #color3: color3,
        if (color4 != $none) #color4: color4,
        if (color5 != $none) #color5: color5,
        if (color6 != $none) #color6: color6,
        if (color1Value != $none) #color1Value: color1Value,
        if (color2Value != $none) #color2Value: color2Value,
        if (color3Value != $none) #color3Value: color3Value,
        if (color4Value != $none) #color4Value: color4Value,
        if (color5Value != $none) #color5Value: color5Value,
        if (color6Value != $none) #color6Value: color6Value
      }));
  @override
  UpTo6Colors $make(CopyWithData data) => UpTo6Colors(
      color1: data.get(#color1, or: $value.color1),
      color2: data.get(#color2, or: $value.color2),
      color3: data.get(#color3, or: $value.color3),
      color4: data.get(#color4, or: $value.color4),
      color5: data.get(#color5, or: $value.color5),
      color6: data.get(#color6, or: $value.color6),
      color1Value: data.get(#color1Value, or: $value.color1Value),
      color2Value: data.get(#color2Value, or: $value.color2Value),
      color3Value: data.get(#color3Value, or: $value.color3Value),
      color4Value: data.get(#color4Value, or: $value.color4Value),
      color5Value: data.get(#color5Value, or: $value.color5Value),
      color6Value: data.get(#color6Value, or: $value.color6Value));

  @override
  UpTo6ColorsCopyWith<$R2, UpTo6Colors, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UpTo6ColorsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
