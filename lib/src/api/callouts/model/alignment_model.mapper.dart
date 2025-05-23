// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'alignment_model.dart';

class AlignmentModelMapper extends ClassMapperBase<AlignmentModel> {
  AlignmentModelMapper._();

  static AlignmentModelMapper? _instance;
  static AlignmentModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AlignmentModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AlignmentModel';

  static double _$x(AlignmentModel v) => v.x;
  static const Field<AlignmentModel, double> _f$x = Field('x', _$x);
  static double _$y(AlignmentModel v) => v.y;
  static const Field<AlignmentModel, double> _f$y = Field('y', _$y);

  @override
  final MappableFields<AlignmentModel> fields = const {
    #x: _f$x,
    #y: _f$y,
  };

  static AlignmentModel _instantiate(DecodingData data) {
    return AlignmentModel(data.dec(_f$x), data.dec(_f$y));
  }

  @override
  final Function instantiate = _instantiate;

  static AlignmentModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AlignmentModel>(map);
  }

  static AlignmentModel fromJson(String json) {
    return ensureInitialized().decodeJson<AlignmentModel>(json);
  }
}

mixin AlignmentModelMappable {
  String toJson() {
    return AlignmentModelMapper.ensureInitialized()
        .encodeJson<AlignmentModel>(this as AlignmentModel);
  }

  Map<String, dynamic> toMap() {
    return AlignmentModelMapper.ensureInitialized()
        .encodeMap<AlignmentModel>(this as AlignmentModel);
  }

  AlignmentModelCopyWith<AlignmentModel, AlignmentModel, AlignmentModel>
      get copyWith =>
          _AlignmentModelCopyWithImpl<AlignmentModel, AlignmentModel>(
              this as AlignmentModel, $identity, $identity);
  @override
  String toString() {
    return AlignmentModelMapper.ensureInitialized()
        .stringifyValue(this as AlignmentModel);
  }

  @override
  bool operator ==(Object other) {
    return AlignmentModelMapper.ensureInitialized()
        .equalsValue(this as AlignmentModel, other);
  }

  @override
  int get hashCode {
    return AlignmentModelMapper.ensureInitialized()
        .hashValue(this as AlignmentModel);
  }
}

extension AlignmentModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AlignmentModel, $Out> {
  AlignmentModelCopyWith<$R, AlignmentModel, $Out> get $asAlignmentModel =>
      $base.as((v, t, t2) => _AlignmentModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AlignmentModelCopyWith<$R, $In extends AlignmentModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({double? x, double? y});
  AlignmentModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AlignmentModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AlignmentModel, $Out>
    implements AlignmentModelCopyWith<$R, AlignmentModel, $Out> {
  _AlignmentModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AlignmentModel> $mapper =
      AlignmentModelMapper.ensureInitialized();
  @override
  $R call({double? x, double? y}) =>
      $apply(FieldCopyWithData({if (x != null) #x: x, if (y != null) #y: y}));
  @override
  AlignmentModel $make(CopyWithData data) =>
      AlignmentModel(data.get(#x, or: $value.x), data.get(#y, or: $value.y));

  @override
  AlignmentModelCopyWith<$R2, AlignmentModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AlignmentModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
