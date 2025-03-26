import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';


class PlayOverlaysButton extends StatefulWidget {
  final DiscoveryController discoveryController;
  final List<CalloutId> features;

  PlayOverlaysButton(this.discoveryController, this.features)
      : super(key: GlobalKey<PlayOverlaysButtonState>()) {
    discoveryController.registerPlayFeaturesButton(key as GlobalKey<PlayOverlaysButtonState>?);
  }

  @override
  PlayOverlaysButtonState createState() => PlayOverlaysButtonState();

  Future<bool> alreadyGotAllFeatures() async {
    bool result = true;
    for (var fe in features) {
      if (! await fca.alreadyGotit(fe)) result = false;
    }
    return result;
  }

}

class PlayOverlaysButtonState extends State<PlayOverlaysButton> {

  refresh(f) => setState(f);

  @override
  Widget build(BuildContext context) {
    //fca.logger.i('alreadyGotIt ${widget.features} is ${alreadyGotAllFeatures(context)}');
    CalloutId? activeFeature = widget.discoveryController.activeFeature();
    Color? featureColor = activeFeature != null ? DiscoveryController.featureFgColors[activeFeature] :Colors.white;
    //FeaturedWidget activeFw = widget.discoveryController.widgetOf(activeFeature);

    return FutureBuilder<bool>(
      future: widget.alreadyGotAllFeatures(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          // If the Future completed successfully and has data
          bool alreadyGotAllFeatures = snapshot.data!; // The bool value
          return alreadyGotAllFeatures
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
        } else {
          return const CircularProgressIndicator();
        }
      },
    );

  }

}
