import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

mixin WidgetMeasuring {
  Future<Size> measureWidgetSize({
    required BuildContext context,
    required Widget widget,
  }) async {
    Completer<Size> completer = Completer();
    OverlayEntry? entry;
    entry = OverlayEntry(builder: (BuildContext ctx) {
      return _OffstageMeasuringWidget(
        onSized: (size) {
          entry?.remove();
          completer.complete(size);
        },
        child: widget,
      );
    });
    Overlay.of(context).insert(entry);
    return completer.future;
  }
}

class _OffstageMeasuringWidget extends StatefulWidget {
  final Widget child;
  final ValueSetter<Size>? onSized;
  // final BoxConstraints? boxConstraints;

  const _OffstageMeasuringWidget({
    required this.child,
    this.onSized,
    // this.boxConstraints,
  });

  @override
  _OffstageMeasuringWidgetState createState() =>
      _OffstageMeasuringWidgetState();
}

class _OffstageMeasuringWidgetState extends State<_OffstageMeasuringWidget> {
  GlobalKey gk = GlobalKey();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.endOfFrame.then((_) {
      // Rect? rect = Measuring.findGlobalRect(gk);
      Rect? rect = gk.globalPaintBounds();
      fca.logger.i('OffstageMeasuringWidget size: ${rect.toString()}');
      // only the size is useful, because widget is rendered offstage
      if (rect != null) {
        widget.onSized?.call(Size(rect.width, rect.height));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                key: gk,
                child: widget.child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
