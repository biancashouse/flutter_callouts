import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';


/*
 * https://github.com/matthew-carroll/fluttery/pull/2/files
 */

class DiscoveryOverlay extends StatelessWidget {
  final bool? showOverlay;
  final Widget Function(BuildContext, Offset, {Size? size})? buildOverlayF;
  final FeaturedWidget parent;

  const DiscoveryOverlay({
    this.showOverlay,
    this.buildOverlayF,
    required this.parent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return DiscoveryOverlayBuilder(
        parent: parent,
        showOverlay: showOverlay,
        overlayBuilderF: (BuildContext overlayContext) {
          RenderBox box = context.findRenderObject() as RenderBox;

          Offset offset = parent.notAnIconFeature ? box.localToGlobal(Offset.zero) : box.size.center(box.localToGlobal(Offset.zero));

          return buildOverlayF!(overlayContext, offset, size: box.size);
        },
        child: GestureDetector(
          child: parent.childBuilder(context),
          onTap: () {
            developer.log('overlay tap');
            if (parent.childTapActionF != null) {
              /// arrive here when you simply tap the featured widget (not showing discovery overlay)
              fca.gotit(parent.featureEnum);
              //developer.log('alreadyGotit(${parent!.featureEnum}) = ${parent!.discoveryController.gotitHelper.alreadyGotit(parent!.featureEnum)}');
              parent.discoveryController.triggerPlayButtonRebuild(parent.featureEnum);
              parent.childTapActionF!(context, parent.discoveryController);
            }
          },
          onDoubleTap: () => parent.childDoubleTapActionF != null ? parent.childDoubleTapActionF!(context, parent.discoveryController) : null,
        ),
      );
    });
  }
}
