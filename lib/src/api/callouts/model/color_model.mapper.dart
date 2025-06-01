// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'color_model.dart';

class ColorModelMapper extends ClassMapperBase<ColorModel> {
  ColorModelMapper._();

  static ColorModelMapper? _instance;
  static ColorModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ColorModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ColorModel';

  static double _$a(ColorModel v) => v.a;
  static const Field<ColorModel, double> _f$a = Field('a', _$a);
  static double _$r(ColorModel v) => v.r;
  static const Field<ColorModel, double> _f$r = Field('r', _$r);
  static double _$g(ColorModel v) => v.g;
  static const Field<ColorModel, double> _f$g = Field('g', _$g);
  static double _$b(ColorModel v) => v.b;
  static const Field<ColorModel, double> _f$b = Field('b', _$b);

  @override
  final MappableFields<ColorModel> fields = const {
    #a: _f$a,
    #r: _f$r,
    #g: _f$g,
    #b: _f$b,
  };

  static ColorModel _instantiate(DecodingData data) {
    return ColorModel(
        data.dec(_f$a), data.dec(_f$r), data.dec(_f$g), data.dec(_f$b));
  }

  @override
  final Function instantiate = _instantiate;

  static ColorModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ColorModel>(map);
  }

  static ColorModel fromJson(String json) {
    return ensureInitialized().decodeJson<ColorModel>(json);
  }
}

mixin ColorModelMappable {
  String toJson() {
    return ColorModelMapper.ensureInitialized()
        .encodeJson<ColorModel>(this as ColorModel);
  }

  Map<String, dynamic> toMap() {
    return ColorModelMapper.ensureInitialized()
        .encodeMap<ColorModel>(this as ColorModel);
  }

  ColorModelCopyWith<ColorModel, ColorModel, ColorModel> get copyWith =>
      _ColorModelCopyWithImpl<ColorModel, ColorModel>(
          this as ColorModel, $identity, $identity);
  @override
  String toString() {
    return ColorModelMapper.ensureInitialized()
        .stringifyValue(this as ColorModel);
  }

  @override
  bool operator ==(Object other) {
    return ColorModelMapper.ensureInitialized()
        .equalsValue(this as ColorModel, other);
  }

  @override
  int get hashCode {
    return ColorModelMapper.ensureInitialized().hashValue(this as ColorModel);
  }
}

extension ColorModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ColorModel, $Out> {
  ColorModelCopyWith<$R, ColorModel, $Out> get $asColorModel =>
      $base.as((v, t, t2) => _ColorModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ColorModelCopyWith<$R, $In extends ColorModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({double? a, double? r, double? g, double? b});
  ColorModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ColorModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ColorModel, $Out>
    implements ColorModelCopyWith<$R, ColorModel, $Out> {
  _ColorModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ColorModel> $mapper =
      ColorModelMapper.ensureInitialized();
  @override
  $R call({double? a, double? r, double? g, double? b}) =>
      $apply(FieldCopyWithData({
        if (a != null) #a: a,
        if (r != null) #r: r,
        if (g != null) #g: g,
        if (b != null) #b: b
      }));
  @override
  ColorModel $make(CopyWithData data) => ColorModel(
      data.get(#a, or: $value.a),
      data.get(#r, or: $value.r),
      data.get(#g, or: $value.g),
      data.get(#b, or: $value.b));

  @override
  ColorModelCopyWith<$R2, ColorModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ColorModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
