import 'package:flutter_callouts/flutter_callouts.dart';

mixin DiscoveryMixin {
  DiscoveryController createDiscoverController(Function? onFinishedPlayingF) =>
      DiscoveryController(onFinishedPlayingF);
}
