import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

import 'sample_iframe.dart';

/// it's important to add the mixin, because callouts are animated
class IFramePage extends StatefulWidget {
  const IFramePage({super.key});

  @override
  State<IFramePage> createState() => _IFramePageState();
}

class _IFramePageState extends State<IFramePage> {
  late final NamedScrollController _namedSC;
  final GlobalKey _gk = GlobalKey();

  @override
  void initState() {
    super.initState();

    _namedSC = NamedScrollController('some-nsc', Axis.vertical);

    /// auto show a callout pointing at the FAB
    fca.afterNextBuildDo(() {
      // namedSC.jumpTo(150.0);
      // showOverlay requires a callout config + callout content + optionally, a target widget globalKey
      fca.showOverlay(
        calloutConfig: _createCalloutConfig1(),
        calloutContent: _createCalloutContent1(),
        targetGkF: () => _gk,
        namedSC: _namedSC,
        wrapInPointerInterceptor: true, // THIS IS THE MOST IMPORTANT LINE
      );
      fca.showToast(
        gravity: Alignment.bottomCenter,
        msg: 'demonstrating that a callout is still draggable even when over an Iframe',
        textColor: Colors.white,
        fontSize: 16,
        fontStyle: FontStyle.italic,
        bgColor: Colors.black,
      );
    });
  }

  @override
  void dispose() {
    _namedSC.dispose();
    super.dispose();
  }

  double get fontSize {
    double result = fca.scrW < 600 ? 12.0 : 24.0;
    return result;
  }

  /// CalloutConfig objects are where you configure callouts and the way they point at their target.
  /// All params are shown, and many are commented out for this example callout.
  /// NOTE - a callout can be updated after it is created by updating properties and rebuilding it.
  CalloutConfig _createCalloutConfig1() => CalloutConfig(
    cId: 'some-callout-id',
    // -- initial pos and animation ---------------------------------
    initialCalloutAlignment: Alignment.topRight,
    initialTargetAlignment: Alignment.bottomLeft,
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
    initialCalloutW: 300,
    // if not supplied, callout content widget gets measured
    initialCalloutH: 150,
    // if not supplied, callout content widget gets measured
    // borderRadius: 12,
    decorationBorderThickness: 3,
    decorationFillColors: ColorOrGradient.color(Colors.yellow[700]!),
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
    targetPointerType: TargetPointerType.bubble(),
    animatePointer: true,
    // lineLabel: Text('line label'),
    // fromDelta: -20,
    // toDelta: -20,
    // lengthDeltaPc: ,
    // contentTranslateX: ,
    // contentTranslateY:
    // targetTranslateX:
    // targetTranslateY:
    // scaleTarget: 1.0,
    // -- resizing -------------------------------------------------
    resizeableH: true,
    resizeableV: true,
    // -- dragging -------------------------------------------------
    // draggable: false,
    // draggableColor: Colors.green,
    // dragHandleHeight: ,
    scrollControllerName: _namedSC.name,
    followScroll: false,
  );

  Widget _createCalloutContent1() => IntrinsicHeight(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('Pointing out the blue icon.\n\n'
          'This callout works, because when\n'
          'showOverlay() is called, the parameter\n'
          'wrapInPointerInterceptor is set to true'),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (_, _) {
        fca.dismissAll();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'flutter_callouts iframe demo',
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaler: TextScaler.linear(1.4),
            ),
            actions: [
              Icon(
                key: _gk,
                Icons.adb_rounded,
                color: Colors.blue,
              ),
              SizedBox(width: 100),
            ],
          ),
          // give it extra height to show how scrolling can work with callouts
          // also notice we pass in the named scroll controller
          body: SingleChildScrollView(
                        controller: _namedSC,
                        child: SizedBox(
                            width: double.infinity,
                            height: fca.scrH - 100,
                            child: Center(child: SampleIFrame())),
                      ),
        ),
      ),
    );
  }
}
