import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

class MeasuringWrapper extends SingleChildRenderObjectWidget {
  final ValueChanged<Size> onSizeChangedF;
  final ValueChanged<Offset>? onPosChangedF; // may just want size
  final VoidCallback onMeasuredF;

  const MeasuringWrapper({super.key, required this.onSizeChangedF, required this.onPosChangedF, super.child, required this.onMeasuredF});

  @override
  RenderObject createRenderObject(BuildContext context) => _MeasureWidgetRenderObject(onSizeChangedF, onPosChangedF, onMeasuredF);
}

class _MeasureWidgetRenderObject extends RenderProxyBox {
  Size? oldSize;
  Offset? oldPos;

  final ValueChanged<Size> onSizeChange;
  final ValueChanged<Offset>? onPosChange;
  final VoidCallback onMeasured;

  _MeasureWidgetRenderObject(this.onSizeChange, this.onPosChange, this.onMeasured);

  @override
  void performLayout() {
    debugPrint("performLayout");
    super.performLayout();

    FCallouts().afterNextBuildDo(() {
      Size newSize = child!.size;
      if (onPosChange != null) {
        Offset newPos = child!.localToGlobal(Offset.zero);
        if (oldSize == newSize && oldPos == newPos) return;
        if (oldSize != newSize) {
          oldSize = newSize;
          onSizeChange(newSize);
        }
        if (oldPos != newPos) {
          oldPos = newPos;
          onPosChange!.call(newPos);
        }
      }
      onMeasured.call();
    });
  }
}
