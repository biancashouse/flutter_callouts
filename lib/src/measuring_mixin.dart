import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

mixin MeasuringMixin {

  Rect? findGlobalRect(GlobalKey key) {
    final RenderObject? renderObject = key.currentContext?.findRenderObject();

    if (renderObject == null) {
      return null;
    }

    if (renderObject is RenderBox) {
      final Offset globalOffset = renderObject.localToGlobal(Offset.zero);

      Rect bounds = renderObject.paintBounds;
      bounds = bounds.translate(globalOffset.dx, globalOffset.dy);
      return bounds;
    } else {
      Rect bounds = renderObject.paintBounds;
      final translation = renderObject.getTransformTo(null).getTranslation();
      bounds = bounds.translate(translation.x, translation.y);
      return bounds;
    }
  }

  Future<Rect> measureWidgetRect({
    // required BuildContext context,
    required Widget widget,
  }) {
    final Completer<Rect> completer = Completer<Rect>();
    OverlayEntry? entry;
    entry = OverlayEntry(builder: (BuildContext ctx) {
      // fca.logger.i(Theme.of(context).platform.toString());
      return Material(
        child: _OffstageWidgetWrapper(
          onMeasuredRect: (Rect? rect) {
            entry?.remove();
            completer.complete(rect);
          },
          child: widget,
        ),
      );
    });

    fca.overlayState?.insert(entry);
    return completer.future;
  }

  Size calculateTextSize({
    required String text,
    required TextStyle style,
    required int numLines,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text.replaceAll("`10`", "\n"), style: style),
      textDirection: TextDirection.ltr,
      maxLines: 6,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return numLines > 1 ? Size(textPainter.size.width, textPainter.size.height) : textPainter.size;
  }

  void afterNextBuildMeasureThenDo(
      final WidgetBuilder widgetBuilder,
      final ValueChanged<Size> fn, {
        final bool skipWidthConstraintWarning =
        false, // should be true if a width was supplied
        final bool skipHeightConstraintWarning =
        false, // should be true if a height was supplied
        // final List<ScrollController>? scrollControllers,
      }) {
    // Map<int, double> savedOffsets = {};
    // if (scrollControllers != null && scrollControllers.isNotEmpty) {
    //   for (int i = 0; i < scrollControllers.length; i++) {
    //     ScrollController sc = scrollControllers[i];
    //     if (sc.positions.isNotEmpty) {
    //       savedOffsets[i] = sc.offset;
    //     }
    //   }
    // }

    fca.afterNextBuildDo((){
      // if (savedOffsets.isNotEmpty) {
      //   for (int i in savedOffsets.keys) {
      //     scrollControllers![i].jumpTo(savedOffsets[i]!);
      //     // scrollControllers![i].animateTo(savedOffsets[i]!, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
      //   }
      // }
      Size size = _measureOffstageWidget(
          GlobalKey(debugLabel: 'offstage-gk'),
          skipWidthConstraintWarning, skipHeightConstraintWarning);
      if (size != Size.zero) fn.call(size);
    });
  }

  Size _measureOffstageWidget(
      GlobalKey gk,
      bool skipWidthConstraintWarning,
      bool skipHeightConstraintWarning,
      ) {
      Rect? rect = gk.globalPaintBounds(
        skipWidthConstraintWarning: skipWidthConstraintWarning,
        skipHeightConstraintWarning: skipHeightConstraintWarning,
      );
      if (rect != null) {
        fca.logger.i(
            '_measureThenRenderCallout: width:${rect.width}, height:${rect.height}');
        return rect.size;
      }
    return Size.zero;
  }

}

class _OffstageWidgetWrapper extends StatefulWidget {
  final Widget child;
  final ValueSetter<Rect?> onMeasuredRect;

  const _OffstageWidgetWrapper({
    required this.child,
    required this.onMeasuredRect,
  });

  @override
  _OffstageWidgetWrapperState createState() => _OffstageWidgetWrapperState();
}

class _OffstageWidgetWrapperState extends State<_OffstageWidgetWrapper> {
  GlobalKey key = GlobalKey();

  @override
  void initState() {
    print('inity state ****************');
    super.initState();
    fca.afterNextBuildDo(() {
      final Rect? rect = fca.findGlobalRect(key);
      if (rect != null) {
        widget.onMeasuredRect.call(rect);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      child: Center(
        child: Container(
          key: key,
          // constraints: widget.boxConstraints,
          child: widget.child,
        ),
      ),
    );
  }

}

