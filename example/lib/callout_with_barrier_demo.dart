import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

/// it's important to add the mixin, because callouts are animated
class BarrierDemo extends StatefulWidget {
  const BarrierDemo({super.key});

  @override
  State<BarrierDemo> createState() => _BarrierDemoState();
}

class _BarrierDemoState extends State<BarrierDemo> {
  final GlobalKey _gk = GlobalKey();
  late CalloutConfig _cc;
  late CalloutBarrierConfig _bc;

  // user can change callout properties even when a callout is already shown
  bool showBarrier = false;

  @override
  void initState() {
    super.initState();

    /// auto show a callout pointing at the FAB
    fca.afterNextBuildDo(() {
      // namedSC.jumpTo(150.0);
      // showOverlay requires a callout config + callout content + optionally, a target widget globalKey
      fca.showOverlay(
        calloutConfig: _cc = _createFabCalloutConfig(),
        calloutContent: _createFabCalloutContent(),
        targetGkF: () => _gk,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// CalloutConfig objects are where you configure callouts and the way they point at their target.
  /// All params are shown, and many are commented out for this example callout.
  /// NOTE - a callout can be updated after it is created by updating properties and rebuilding it.
  CalloutConfig _createFabCalloutConfig() {
    _bc = CalloutBarrierConfig(
      cutoutPadding: fca.isWeb ? 20 : 10,
      excludeTargetFromBarrier: false,
      roundExclusion: false,
      closeOnTapped: true,
      color: Colors.grey,
      opacity: .9,
    );

    return CalloutConfig(
      cId: 'some-callout-id',
      // -- initial pos and animation ---------------------------------
      initialCalloutAlignment: Alignment.centerLeft,
      initialTargetAlignment: Alignment.centerRight,
      // initialCalloutPos:
      finalSeparation: 60,
      // fromDelta: 0.0,
      // toDelta : 0.0,
      // initialAnimatedPositionDurationMs:
      // -- optional barrier (when opacity > 0) ----------------------
      // barrier: CalloutBarrier(
      //   opacity: .5,
      //   onTappedF: () {
      //     Callout.dismiss("basic");
      //   },
      // ),
      // -- callout appearance ----------------------------------------
      initialCalloutW: 240,
      // if not supplied, callout content widget gets measured
      initialCalloutH: 200,
      // if not supplied, callout content widget gets measured
      // borderRadius: 12,
      decorationBorderThickness: 3,
      decorationUpTo6FillColors: UpTo6Colors(color1: Colors.yellow[700]!),
      elevation: 10,
      // frameTarget: true,
      // -- optional close button and got it button -------------------
      // showGotitButton: true,
      // showCloseButton: true,
      // closeButtonColor:
      // closeButtonPos:
      // gotitAxis:
      // -- pointer -------------------------------------------------
      // arrowColor: Color.yellow(),
      targetPointerType: TargetPointerType.thin_line(),
      animatePointer: true,
      // lineLabel: Text('line label'),
      // fromDelta: -20,
      // toDelta: -20,
      // lengthDeltaPc: ,
      // contentTranslateX: ,
      // contentTranslateY:
      // targetTranslateX:
      // targetTranslateY:
      scaleTarget: 1.0,
      // -- resizing -------------------------------------------------
      // resizeableH: true,
      // resizeableV: true,
      // -- dragging -------------------------------------------------
      // draggable: false,
      // draggableColor: Colors.green,
      // dragHandleHeight: ,
      scrollControllerName: null,
      // followScroll: false,
      barrier: showBarrier ? _bc : null,
    );
  }

  Widget _createFabCalloutContent() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Pointing out the icon widget.\n'),
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('show a barrier ?'),
              StatefulBuilder(
                builder: (context, setState) => Checkbox(
                  value: _cc.barrier != null,
                  onChanged: (_) {
                    setState(() => toggleShowBarrier());
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('show cutout ?'),
              StatefulBuilder(
                builder: (context, setState) => Checkbox(
                  value: _cc.barrier?.excludeTargetFromBarrier ?? false,
                  onChanged: (_) {
                    setState(() => toggleCutout());
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('round cutout ?'),
              StatefulBuilder(
                builder: (context, setState) => Checkbox(
                  value:
                      (_cc.barrier?.excludeTargetFromBarrier ?? false) &&
                      (_cc.barrier?.roundExclusion ?? false),
                  onChanged: (_) {
                    setState(() => toggleCutoutShape());
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  void toggleShowBarrier() {
    setState(() {
      showBarrier = !showBarrier;
      _cc.barrier = showBarrier ? _bc : null;
      fca.rebuild('some-callout-id');
    });
  }

  void toggleCutout() {
    setState(() {
      if (_cc.barrier != null) {
        _cc.barrier!.excludeTargetFromBarrier =
            !_cc.barrier!.excludeTargetFromBarrier;
        fca.rebuild('some-callout-id');
      }
    });
  }

  void toggleCutoutShape() {
    setState(() {
      if (_cc.barrier != null) {
        _cc.barrier!.roundExclusion = !_cc.barrier!.roundExclusion;
        fca.rebuild('some-callout-id');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = fca.scrW < 600 ? 12.0 : 18.0;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (_, _) {
        fca.dismissAll();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'flutter_callouts barrier demo',
            style: TextStyle(fontWeight: FontWeight.bold),
            textScaler: TextScaler.linear(1.4),
          ),
        ),
        // give it extra height to show how scrolling can work with callouts
        // also notice we pass in the named scroll controller
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                'A callout can have a barrier underneath.\n\n'
                'Taps on the barrier can be configured to trigger closing the callout.\n\n'
                'The barrier will cover the entire screen below the callout unless\n'
                ' you specify a cutout section over the target.\n\n'
                'Your cutout can be circular or a rectangle.\n\n'
                    'Try the checkboxes...',
                style: TextStyle(
                  color: Colors.green[900],
                  fontStyle: FontStyle.italic,
                  fontSize: fontSize,
                ),
              ),
              SizedBox(height: 200),
              Center(child: Icon(key: _gk, Icons.adb_rounded)),
            ],
          ),
        ),
        bottomSheet: Container(
          color: Colors.black,
          padding: EdgeInsets.all(8),
          child: Text(
            'demonstrating barrier under callout',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
