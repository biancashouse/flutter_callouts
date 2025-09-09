import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

/// it's important to add the mixin, because callouts are animated
class ScrollingDemo extends StatefulWidget {
  const ScrollingDemo({super.key});

  @override
  State<ScrollingDemo> createState() => _ScrollingDemoState();
}

class _ScrollingDemoState extends State<ScrollingDemo> {
  final NamedScrollController _namedSC = NamedScrollController(
    'some-name',
    Axis.vertical,
  );
  final GlobalKey _gk = GlobalKey();
  late CalloutConfigModel _cc;

  // user can change callout properties even when a callout is already shown
  bool followScroll = false;
  bool didScroll = false;

  @override
  void initState() {
    super.initState();

    // catch scrolling so we can detect whether user has actually tried scrolling
    _namedSC.addListener(() {
      if (_namedSC.hasClients && _namedSC.offset > 0) didScroll = true;
    });

    /// auto show a callout pointing at the FAB
    fca.afterNextBuildDo(() {
      // namedSC.jumpTo(150.0);
      // showOverlay requires a callout config + callout content + optionally, a target widget globalKey
      fca.showOverlay(
        calloutConfig: _cc = _createFabCalloutConfig(),
        calloutContent: _createCalloutContent(),
        targetGkF: () => _gk,
      );
      fca.showToastColor1OnColor2(
        gravity: AlignmentEnum.bottomCenter,
        msg: 'demonstrating dragging, resizing,\nand scrolling with callouts',
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
  CalloutConfigModel _createFabCalloutConfig() => CalloutConfigModel(
    cId: 'some-callout-id',
    // -- initial pos and animation ---------------------------------
    initialCalloutAlignment: fca.isAndroid? AlignmentEnum.topCenter : AlignmentEnum.centerLeft,
    initialTargetAlignment: fca.isAndroid? AlignmentEnum.bottomCenter : AlignmentEnum.centerRight,
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
    initialCalloutH: 120,
    // if not supplied, callout content widget gets measured
    // borderRadius: 12,
    borderThickness: 3,
    fillColor: ColorModel.fromColor(Colors.yellow[700]!),
    elevation: 10,
    // frameTarget: true,
    // -- optional close button and got it button -------------------
    // showGotitButton: true,
    // showCloseButton: true,
    // closeButtonColor:
    // closeButtonPos:
    // gotitAxis:
    // -- pointer -------------------------------------------------
    // arrowColor: ColorModel.yellow(),
    arrowType: ArrowTypeEnum.THIN,
    animate: true,
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

  Widget _createCalloutContent() => IntrinsicHeight(
    child: Padding(
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
                const Text('followScroll?'),
                StatefulBuilder(
                  builder: (context, setState) => Checkbox(
                    value: _cc.followScroll,
                    onChanged: (_) {
                      setState(() => toggleFollowScroll());
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  void toggleFollowScroll() {
    setState(() {
      followScroll = !followScroll;
      _cc.followScroll = followScroll;
      fca.rebuild('some-callout-id');
    });
  }

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
              'flutter_callouts scrolling demo',
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaler: TextScaler.linear(1.4),
            ),
          ),
          // give it extra height to show how scrolling can work with callouts
          // also notice we pass in the named scroll controller
          body: SingleChildScrollView(
            controller: _namedSC,
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Text(
                      'The yellow callout points to the blue icon widget.\n\n'
                      'The callout has been configured to be draggable, resizeable,\n'
                      'with the pointer animated.\n\n'
                      'When scrolling your UI, you can have the callout stay in place\n'
                      'of follow the scroll.\n\n'
                      'The configuration can be updated in real time. E.g. when you change the\n'
                      '"followScroll?" checkbox, the scroll behaviour changes.\n\n'
                      'Try dragging the yellow callout and scrolling the screen...',
                      style: TextStyle(
                        color: Colors.green[900],
                        fontStyle: FontStyle.italic,
                        fontSize: fontSize,
                      ),
                    ),
                  ),
                  SizedBox(height: 200.0),
                  Center(
                    child: Icon(
                      key: _gk,
                      Icons.adb_rounded,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: fca.scrH),
                ],
              ),
            ),
          ),
          // bottomSheet: Container(
          //   width: double.infinity,
          //   height: 70.0,
          //   color: Colors.black,
          //   padding: EdgeInsets.all(8),
          //   child: Text(
          //     'demonstrating dragging, resizing,\nand scrolling with callouts',
          //     style: TextStyle(color: Colors.white),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
        ),
      ),
    );
  }
}
