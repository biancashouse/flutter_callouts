import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

class RepositionableOverlayContent extends StatefulWidget {
  final Widget child;
  final VoidCallback reshowF;

  const RepositionableOverlayContent({
    required this.reshowF,
    super.key,
    required this.child,
  });

  @override
  State<RepositionableOverlayContent> createState() =>
      _RepositionableOverlayContentState();
}

class _RepositionableOverlayContentState
    extends State<RepositionableOverlayContent>
    with WidgetsBindingObserver {
  late Debouncer _debounceTimer;
  late double savedW;
 late  double savedH;

  @override
  void initState() {
    super.initState();
    savedW = fca.scrW;
    savedH = fca.scrH;
    _debounceTimer = Debouncer(delayMs: 500);
    WidgetsBinding.instance.addObserver(this);
    // Calculate initial position after the first frame
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (mounted) {
    //     _refresh();
    //   }
    // });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // This can also be a good place to update if dependencies change
    // that might affect position (though didChangeMetrics is primary for MediaQuery)
    _refresh();
  }

  @override
  void didChangeMetrics() {
    // This is the key callback for MediaQuery changes!
    if (mounted) {
      // print("MediaQuery metrics changed. Updating overlay position.");
      // Metrics have changed, recalculate and update position
      _refresh();
    }
  }

  void _refresh() {
    if (!mounted || savedW == fca.scrW && savedH == fca.scrH) return;

    // MediaQuery.sizeOf(context);

    _debounceTimer.run(() {
      setState(() {});

      fca.afterNextBuildDo(() {
        widget.reshowF.call();
      });
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
