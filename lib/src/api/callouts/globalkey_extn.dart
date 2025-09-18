import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

bool _alreadyGaveGlobalPosAndSizeWarning = false;

Map<String, GlobalKey> namedGKs = {};

extension GlobalKeyExtension on GlobalKey {

  void register(String gkName) => namedGKs[gkName] = this;
  void dispose() => namedGKs.remove(this);

  (Offset?, Size?) globalPosAndSize() {
    Rect? r = globalPaintBounds();
    return (r?.topLeft, r?.size);
  }

  Rect? globalPaintBounds(
      {bool skipWidthConstraintWarning = true,
      bool skipHeightConstraintWarning = true}) {
    // if (_measuredKeys.containsKey(this)) return _measuredKeys[this];

    // var cw = currentWidget;
    var cc = currentContext;
    // Size? scrSize;
    if (cc == null) {
      fca.logger.i('GlobalKeyExtension: currentContext NULL!');
      return null;
    }
    //   scrSize = MediaQuery.sizeOf(cc);
    // }
    final renderObject = cc.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    Rect? paintBounds;
    try {
      paintBounds = renderObject?.paintBounds;
    } catch (e) {
      fca.logger.i('paintBounds = renderObject?.paintBounds - ${e.toString()}');
    }
    // possibly warn about the target having an infinite width
    if (!_alreadyGaveGlobalPosAndSizeWarning &&
        !skipWidthConstraintWarning &&
        !skipHeightConstraintWarning &&
        (paintBounds?.width == fca.scrSize.width ||
            paintBounds?.height == fca.scrH)) {
      _alreadyGaveGlobalPosAndSizeWarning = true;
      fca.showOverlay(
        calloutContent: Column(
          children: [
            const Text('Warning - Target Size Constraint'),
            Text(
              paintBounds?.width == fca.scrW
                  ? "\nThe width of your callout target is the same as the window width.\n"
                      "This might indicate that your target has an unbounded width constraint.\n"
                      "This occurs, for example, when your target is a child of a ListView.\n\n"
                      "If this is intentional, add 'skipContraintWarning:true' as an arg\n\n"
                      "  to constructor wrapTarget\n\n"
                      "  or to calls to showOverlay()\n\n"
                      "Context: ${cc.toString()}"
                  : "\nThe hwight of your callout target is the same as the window hwight.\n"
                      "This might indicate that your target has an unbounded hwight constraint.\n"
                      "If this height is intentional, add 'skipContraintWarning:true' as an arg\n\n"
                      "  to constructor wrapTarget\n\n"
                      "  or to calls to showOverlay()\n\n"
                      "Context: ${cc.toString()}",
            ),
            TextButton(
              onPressed: () {
                fca.dismissTopFeature();
              },
              child: const Text('Close'),
            ),
          ],
        ),
        calloutConfig: CalloutConfig(
          cId: 'globalPaintBounds error',
          draggable: false,
          initialCalloutW: fca.scrW * .7,
          initialCalloutH: 400,
          scrollControllerName: null,
        ),
      );
    }
    if (translation != null && paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return /* _measuredKeys[this] = */ paintBounds.shift(offset);
    } else {
      return null;
    }
  }
}
