import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

/// it's important to add the mixin, because callouts are animated
class PointerDemo extends StatefulWidget {
  const PointerDemo({super.key});

  @override
  State<PointerDemo> createState() => _PointerDemoState();
}

class _PointerDemoState extends State<PointerDemo> {
  final GlobalKey _gk = GlobalKey();
  late CalloutConfigModel _cc;
  late CalloutBarrierConfig _bc;

  // user can change callout properties even when a callout is already shown
  bool _showBarrier = false;
  bool _animateArrow = false;
  ArrowTypeEnum _pointerType = ArrowTypeEnum.THIN;

  @override
  void initState() {
    super.initState();

    /// auto show a callout pointing at the FAB
    fca.afterNextBuildDo(() {
      // namedSC.jumpTo(150.0);
      // showOverlay requires a callout config + callout content + optionally, a target widget globalKey
      fca.showOverlay(calloutConfig: _cc = _createFabCalloutConfig(), calloutContent: _createFabCalloutContent(), targetGkF: () => _gk);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onTappedBarrier() {
    fca.showOverlay(
      calloutConfig: CalloutConfigModel(
        cId: 'tapped-barrier',
        fillColor: ColorModel.transparent(),
        scrollControllerName: null,
        elevation: 6,
      ),
      calloutContent: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.black)),
              onPressed: () {
                fca.dismiss('some-callout-id');
                fca.dismiss('tapped-barrier');
              },
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'You tapped the barrier.\n\n'
                  'The bool closeOnTap is false: gives you control over whether to allow user to close the callout.\n\n\n'
                  'Tap this button to remove this message callout and the yellow callout.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// CalloutConfig objects are where you configure callouts and the way they point at their target.
  /// All params are shown, and many are commented out for this example callout.
  /// NOTE - a callout can be updated after it is created by updating properties and rebuilding it.
  CalloutConfigModel _createFabCalloutConfig() {
    _bc = CalloutBarrierConfig(
      cutoutPadding: fca.isWeb ? 20 : 10,
      excludeTargetFromBarrier: false,
      roundExclusion: false,
      closeOnTapped: false,
      onTappedF: _onTappedBarrier,
      color: Colors.grey,
      opacity: .9,
    );

    return CalloutConfigModel(
      cId: 'some-callout-id',
      // -- initial pos and animation ---------------------------------
      initialCalloutAlignment: AlignmentEnum.centerLeft,
      initialTargetAlignment: AlignmentEnum.centerRight,
      // initialCalloutPos:
      finalSeparation: 40,
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
      initialCalloutW: 280,
      // if not supplied, callout content widget gets measured
      initialCalloutH: 320,
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
      arrowType: _pointerType,
      animate: _animateArrow,
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
      barrier: _showBarrier ? _bc : null,
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
                  value: (_cc.barrier?.excludeTargetFromBarrier ?? false) && (_cc.barrier?.roundExclusion ?? false),
                  onChanged: (_) {
                    setState(() => toggleCutoutShape());
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: DropdownMenu<ArrowTypeEnum>(
            initialSelection: _cc.arrowType,
            controller: TextEditingController(),
            requestFocusOnTap: true,
            inputDecorationTheme: const InputDecorationTheme(filled: true, contentPadding: EdgeInsets.all(20.0)),
            label: const Text('Pointer Type', style: TextStyle(color: Colors.blueGrey)),
            onSelected: (ArrowTypeEnum? newType) {
              if (newType == null) return;
              fca.dismiss('main-toast');
              _changePointerType(newType);
            },
            dropdownMenuEntries: ArrowTypeEnum.entries,
          ),
        ),
        if (_cc.arrowType != ArrowTypeEnum.NONE)
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('animate arrow ?'),
                StatefulBuilder(
                  builder: (context, setState) => Checkbox(
                    value: _cc.animate,
                    onChanged: (_) {
                      setState(() => toggleAnimatedArrow());
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
      _showBarrier = !_showBarrier;
      _cc.barrier = _showBarrier ? _bc : null;
      fca.rebuild('some-callout-id');
    });
  }

  void toggleCutout() {
    setState(() {
      if (_cc.barrier != null) {
        _cc.barrier!.excludeTargetFromBarrier = !_cc.barrier!.excludeTargetFromBarrier;
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

  void _changePointerType(ArrowTypeEnum newType) {
    setState(() {
      _cc.arrowType = newType;
      fca.rebuild('some-callout-id');
    });
  }

  void toggleAnimatedArrow() {
    setState(() {
      _cc.animate = !_cc.animate;
      // because animate requires a controller created in its intState, we simply recreate the callout rather just rebuild
      // TODO may refine later
      fca.dismiss('some-callout-id');
      fca.showOverlay(calloutConfig: _cc, calloutContent: _createFabCalloutContent(), targetGkF: () => _gk);
    });
  }

  @override
  void didChangeDependencies() {
    fca.initWithContext(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (_, _) {
        fca.dismissAll();
      },
      child: Scaffold(
        appBar: AppBar(title: Text('flutter_callouts target pointer demo')),
        // give it extra height to show how scrolling can work with callouts
        // also notice we pass in the named scroll controller
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                'A callout can optionally point to a target.\n\n'
                'Use the dropdown menu to try different ways.\n\n'
                'Drag the callout around to see how the callout keeps its pointer updated.',
                style: TextStyle(color: Colors.green[900], fontStyle: FontStyle.italic, fontSize: 24),
              ),
              SizedBox(height: 200),
              Center(child: Icon(key: _gk, Icons.adb_rounded)),
            ],
          ),
        ),
        bottomSheet: Container(
          color: Colors.black,
          padding: EdgeInsets.all(8),
          child: Text('demonstrating how callouts can point to their target', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
