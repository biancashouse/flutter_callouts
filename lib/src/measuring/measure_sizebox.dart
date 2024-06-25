import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// to understand covariant see https://dart.dev/guides/language/sound-problems#the-covariant-keyword

class MeasureSizeBox extends SingleChildRenderObjectWidget {
  final ValueChanged<Size> onSizedCallback;

  const MeasureSizeBox({
    required super.child,
    required this.onSizedCallback,
    super.key,
  });

  @override
  RenderProxyBox createRenderObject(BuildContext context) {
    return _RenderMeasureSizeBox(onSizedCallback: onSizedCallback);
  }
}

class _RenderMeasureSizeBox extends RenderProxyBox {
  final ValueChanged<Size> onSizedCallback;

  _RenderMeasureSizeBox({required this.onSizedCallback});

  @override
  void layout(Constraints constraints, {bool parentUsesSize = false}) {
    super.layout(constraints, parentUsesSize: true);
    if (size.isEmpty) return;
    onSizedCallback(Size.copy(size));
  }

  @override
  void setupParentData(covariant RenderObject child) {
    child.parentData = parentData;
  }

  @override
  void dropChild(covariant RenderObject child) {
    if (child.parentData is FlexParentData) {
      (child.parentData as FlexParentData).flex = null;
      child.parentData = ParentData();
    }

    super.dropChild(child);
  }
}
