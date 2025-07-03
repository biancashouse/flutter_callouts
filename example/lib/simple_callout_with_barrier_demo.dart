import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

/// it's important to add the mixin, because callouts are animated
class CounterViewWithCallout extends StatefulWidget {
  const CounterViewWithCallout({super.key});

  @override
  State<CounterViewWithCallout> createState() => _CounterViewWithCalloutState();
}

class _CounterViewWithCalloutState extends State<CounterViewWithCallout> {
  final NamedScrollController _namedSC = NamedScrollController('main', Axis.vertical);
  final GlobalKey _countGK = GlobalKey();
  final GlobalKey _fabGK = GlobalKey();
  late CalloutConfigModel _counterCC;
  late CalloutConfigModel _fabCC;

  int _counter = 0;

  // user can change callout properties even when a callout is already shown
  bool followScroll = false;
  bool showCutout = true;
  bool didScroll = false;
  ArrowTypeEnum arrowType = ArrowTypeEnum.POINTY;
  AlignmentEnum calloutAlignment = AlignmentEnum.topRight;
  AlignmentEnum targetAlignment = AlignmentEnum.bottomLeft;

  @override
  void initState() {
    super.initState();

    // catch scrolling
    _namedSC.addListener(() {
      if (_namedSC.hasClients && _namedSC.offset > 0) didScroll = true;
    });

    /// CalloutConfig objects are where you configure callouts and the way they point at their target.
    /// All params are shown, and many are commented out for this example callout.
    /// NOTE - a callout can be updated after it is created by updating properties and rebuilding it.
    _createCounterCalloutConfig();

    /// auto show a callout pointing at the FAB
    fca.afterNextBuildDo(() {
      // namedSC.jumpTo(150.0);
      _createFabCalloutConfig();
      showFABCallout();
    });
  }

  @override
  void dispose() {
    _namedSC.dispose();
    super.dispose();
  }

  void _createCounterCalloutConfig() {
    _counterCC = CalloutConfigModel(
      cId: 'count',
      // -- initial pos and animation ---------------------------------
      initialTargetAlignment: AlignmentEnum.topLeft,
      initialCalloutAlignment: AlignmentEnum.bottomRight,
      // initialCalloutPos:
      finalSeparation: 100,
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
      // suppliedCalloutW: 280, // if not supplied, callout content widget gets measured
      // suppliedCalloutH: 200, // if not supplied, callout content widget gets measured
      // borderRadius: 12,
      borderThickness: 3,
      fillColor: ColorModel.fromColor(Colors.yellow[700]!),
      // elevation: 10,
      // frameTarget: true,
      // -- optional close button and got it button -------------------
      // showGotitButton: true,
      // showCloseButton: true,
      // closeButtonColor:
      // closeButtonPos:
      // gotitAxis:
      // -- pointer -------------------------------------------------
      arrowColor: ColorModel.green(),
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
      scaleTarget: 1.0,
      // -- resizing -------------------------------------------------
      resizeableH: true,
      resizeableV: true,
      // -- dragging -------------------------------------------------
      // draggable: false,
      // draggableColor: Colors.green,
      // dragHandleHeight: ,
      scrollControllerName: _namedSC.name,
      followScroll: false,
      barrier: showCutout
          ? CalloutBarrierConfig(
              cutoutPadding: fca.isWeb ? 20 : 10,
              excludeTargetFromBarrier: true,
              roundExclusion: true,
              closeOnTapped: false,
              color: Colors.grey,
              opacity: .9,
            )
          : null,
    );
  }

  void _createFabCalloutConfig() {
    _fabCC = CalloutConfigModel(
      cId: 'count',
      // -- initial pos and animation ---------------------------------
      initialTargetAlignment: AlignmentEnum.topLeft,
      initialCalloutAlignment: AlignmentEnum.bottomRight,
      // initialCalloutPos:
      finalSeparation: 100,
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
      // suppliedCalloutW: 280, // if not supplied, callout content widget gets measured
      // suppliedCalloutH: 200, // if not supplied, callout content widget gets measured
      // borderRadius: 12,
      borderThickness: 3,
      fillColor: ColorModel.fromColor(Colors.yellow[700]!),
      // elevation: 10,
      // frameTarget: true,
      // -- optional close button and got it button -------------------
      // showGotitButton: true,
      // showCloseButton: true,
      // closeButtonColor:
      // closeButtonPos:
      // gotitAxis:
      // -- pointer -------------------------------------------------
      arrowColor: ColorModel.green(),
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
      scaleTarget: 1.0,
      // -- resizing -------------------------------------------------
      resizeableH: true,
      resizeableV: true,
      // -- dragging -------------------------------------------------
      // draggable: false,
      // draggableColor: Colors.green,
      // dragHandleHeight: ,
      scrollControllerName: _namedSC.name,
      followScroll: false,
      barrier: showCutout
          ? CalloutBarrierConfig(
              cutoutPadding: fca.isWeb ? 20 : 10,
              excludeTargetFromBarrier: true,
              roundExclusion: true,
              closeOnTapped: false,
              color: Colors.grey,
              opacity: .9,
            )
          : null,
    );
  }

  void showFABCallout() {
    fca.showOverlay(
      calloutConfig: _fabCC,
      calloutContent: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              showCutout
                  ? 'Pointing out this (currently disabled) floating action button.'
                  : 'Pointing out the Increment Counter floating action button.',
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Text(
                showCutout
                    ? 'This callout makes a cutout in the barrier (around the FAB).\n'
                          'Also, any callout can be draggable and resizeable. Try it...'
                    : 'When scrolling, you can have the callout stay in place\n'
                          'of follow the scroll. Try it...',
                style: TextStyle(color: Colors.green[900], fontStyle: FontStyle.italic),
              ),
            ),
            if (!showCutout)
              SizedBox(
                width: 200,
                child: Row(
                  children: [
                    const Text('followScroll?'),
                    StatefulBuilder(
                      builder: (context, setState) => Checkbox(
                        value: _fabCC.followScroll,
                        onChanged: (_) {
                          setState(() => toggleFollowScroll());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: Row(
                children: [
                  SegmentedButton<ArrowTypeEnum?>(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                      foregroundColor: WidgetStatePropertyAll(Colors.purple),
                      side: WidgetStatePropertyAll(BorderSide(color: Colors.purple)),
                      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    ),
                    segments: const <ButtonSegment<ArrowTypeEnum?>>[
                      ButtonSegment<ArrowTypeEnum?>(value: ArrowTypeEnum.THIN, label: Text('arrow')),
                      ButtonSegment<ArrowTypeEnum?>(value: ArrowTypeEnum.POINTY, label: Text('bubble')),
                    ],
                    selected: <ArrowTypeEnum?>{_fabCC.arrowType},
                    onSelectionChanged: (Set<ArrowTypeEnum?> newSelection) {
                      // By default there is only a single segment that can be
                      // selected at one time, so its value is always the first
                      // item in the selected set.
                      fca.dismissAll();
                      ArrowTypeEnum value = newSelection.first!;
                      ArrowTypeEnum newType = value;
                      updateArrowType(newType);
                    },
                  ),
                  Spacer(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      targetGkF: () => _fabGK,
    );
  }

  void toggleFollowScroll() {
    setState(() {
      followScroll = !followScroll;
      _counterCC.rebuild(() {});
    });
  }

  void toggleShowCutout() {
    setState(() {
      showCutout = !showCutout;
      _counterCC.rebuild(() {});
    });
  }

  void updateArrowType(ArrowTypeEnum newType) {
    setState(() {
      arrowType = newType;
      //fabCC.rebuild(() {});
      fca.refreshAll();
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      fca.dismissAll(exceptToasts: true);
      int newIndex = _counter % AlignmentEnum.values.length;
      AlignmentEnum ca = AlignmentEnum.of(newIndex)!;
      AlignmentEnum ta = ca.oppositeEnum;
      fca.showOverlay(
        calloutConfig: _counterCC
          ..calloutAlignment = ca.flutterValue
          ..targetAlignment = ta.flutterValue
          ..calloutW = 200
          ..calloutH = 80
          ..fillColor = ColorModel.orangeAccent(),
        calloutContent: Padding(padding: const EdgeInsets.all(8.0), child: Text('You have pushed the +\nbutton $_counter times:')),
        targetGkF: () => _countGK,
      );
      // removeAfterMs : 3000,
    });
  }

  @override
  void didChangeDependencies() {
    fca.initWithContext(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('flutter_callouts demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text('$_counter', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(key:_fabGK, onPressed: _incrementCounter, tooltip: 'Increment', child: const Icon(Icons.add)),
    );
  }
}
