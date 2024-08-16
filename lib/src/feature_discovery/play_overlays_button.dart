import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';


class PlayOverlaysButton extends StatefulWidget {
  final DiscoveryController discoveryController;
  final List<Feature> features;

  PlayOverlaysButton(this.discoveryController, this.features)
      : super(key: GlobalKey<PlayOverlaysButtonState>()) {
    discoveryController.registerPlayFeaturesButton(key as GlobalKey<PlayOverlaysButtonState>?);
  }

  @override
  PlayOverlaysButtonState createState() => PlayOverlaysButtonState();

  bool alreadyGotAllFeatures(BuildContext context) {
    bool result = true;
    for (var fe in features) {
      if (!fca.alreadyGotit(fe)) result = false;
    }
    return result;
  }

}

class PlayOverlaysButtonState extends State<PlayOverlaysButton> {

  refresh(f) => setState(f);

  @override
  Widget build(BuildContext context) {
    //debugPrint('alreadyGotIt ${widget.features} is ${alreadyGotAllFeatures(context)}');
    Feature? activeFeature = widget.discoveryController.activeFeature();
    Color? featureColor = activeFeature != null ? DiscoveryController.featureFgColors[activeFeature] :Colors.white;
    //FeaturedWidget activeFw = widget.discoveryController.widgetOf(activeFeature);
    return alreadyGotAllFeatures(context)
        ? Container()
        : SizedBox(
            width: 50,
            child: IconButton(
              icon: fca.blink(Icon(
                Icons.info,
                size: fca.narrowWidth ? 24.0 : 32.0,
                color: featureColor,
              )),
              onPressed: () {
                widget.discoveryController.startPlay(widget.features);
              },
            ));
  }

  bool alreadyGotAllFeatures(BuildContext context) {
    return widget.alreadyGotAllFeatures(context);
  }
}
