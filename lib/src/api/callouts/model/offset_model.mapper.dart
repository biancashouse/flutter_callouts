// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'offset_model.dart';

class OffsetModelMapper extends ClassMapperBase<OffsetModel> {
  OffsetModelMapper._();

  static OffsetModelMapper? _instance;
  static OffsetModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OffsetModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'OffsetModel';

  static double _$dx(OffsetModel v) => v.dx;
  static const Field<OffsetModel, double> _f$dx = Field('dx', _$dx);
  static double _$dy(OffsetModel v) => v.dy;
  static const Field<OffsetModel, double> _f$dy = Field('dy', _$dy);
  static Offset _$value(OffsetModel v) => v.value;
  static const Field<OffsetModel, Offset> _f$value = Field(
    'value',
    _$value,
    mode: FieldMode.member,
  );

  @override
  final MappableFields<OffsetModel> fields = const {
    #dx: _f$dx,
    #dy: _f$dy,
    #value: _f$value,
  };

  static OffsetModel _instantiate(DecodingData data) {
    return OffsetModel(data.dec(_f$dx), data.dec(_f$dy));
  }

  @override
  final Function instantiate = _instantiate;

  static OffsetModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<OffsetModel>(map);
  }

  static OffsetModel fromJson(String json) {
    return ensureInitialized().decodeJson<OffsetModel>(json);
  }
}

mixin OffsetModelMappable {
  String toJson() {
    return OffsetModelMapper.ensureInitialized().encodeJson<OffsetModel>(
      this as OffsetModel,
    );
  }

  Map<String, dynamic> toMap() {
    return OffsetModelMapper.ensureInitialized().encodeMap<OffsetModel>(
      this as OffsetModel,
    );
  }

  OffsetModelCopyWith<OffsetModel, OffsetModel, OffsetModel> get copyWith =>
      _OffsetModelCopyWithImpl<OffsetModel, OffsetModel>(
        this as OffsetModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return OffsetModelMapper.ensureInitialized().stringifyValue(
      this as OffsetModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return OffsetModelMapper.ensureInitialized().equalsValue(
      this as OffsetModel,
      other,
    );
  }

  @override
  int get hashCode {
    return OffsetModelMapper.ensureInitialized().hashValue(this as OffsetModel);
  }
}

extension OffsetModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, OffsetModel, $Out> {
  OffsetModelCopyWith<$R, OffsetModel, $Out> get $asOffsetModel =>
      $base.as((v, t, t2) => _OffsetModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class OffsetModelCopyWith<$R, $In extends OffsetModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({double? dx, double? dy});
  OffsetModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _OffsetModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, OffsetModel, $Out>
    implements OffsetModelCopyWith<$R, OffsetModel, $Out> {
  _OffsetModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<OffsetModel> $mapper =
      OffsetModelMapper.ensureInitialized();
  @override
  $R call({double? dx, double? dy}) => $apply(
    FieldCopyWithData({if (dx != null) #dx: dx, if (dy != null) #dy: dy}),
  );
  @override
  OffsetModel $make(CopyWithData data) =>
      OffsetModel(data.get(#dx, or: $value.dx), data.get(#dy, or: $value.dy));

  @override
  OffsetModelCopyWith<$R2, OffsetModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _OffsetModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

