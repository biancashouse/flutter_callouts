// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_callouts/flutter_callouts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

// lazy ;-)
bool followScroll = false;
bool showCutout = true;
bool didScroll = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  fca.logger.d('Running example app');
  fca.loggerNs.i('Info message');
  fca.loggerNs.w('Just a warning!');
  fca.logger.e('Error! Something bad happened', error: 'Test Error');
  fca.loggerNs.t({'key': 5, 'value': 'something'});

  await fca.initLocalStorage();

  runApp(const MaterialApp(
    title: 'flutter_callouts demo',
    home: CounterDemoPage(),
  ));
}

class CounterDemoPage extends StatefulWidget {
  const CounterDemoPage({super.key});

  @override
  State<CounterDemoPage> createState() => CounterDemoPageState();
}

/// it's important to add the mixin, because callouts are animated
class CounterDemoPageState extends State<CounterDemoPage>
    with TickerProviderStateMixin {
  late GlobalKey fabGK;
  late GlobalKey countGK;
  late CalloutConfigModel fabCC;

  final TextEditingController gravityController = TextEditingController();
  AlignmentEnum? selectedGravity;

  NamedScrollController namedSC = NamedScrollController(
    'main',
    Axis.vertical,
  );

  late List<Alignment> alignments;

  @override
  void initState() {
    super.initState();

    namedSC.addListener(() {
      if (namedSC.hasClients && namedSC.offset > 0) didScroll = true;
    });

    /// target's key
    fabGK = GlobalKey();
    countGK = GlobalKey();

    fabCC = basicCalloutConfig(namedSC)
      ..arrowType = ArrowTypeEnum.POINTY
      ..barrier = showCutout
          ? CalloutBarrierConfig(
              cutoutPadding: 20,
              excludeTargetFromBarrier: true,
              roundExclusion: true,
              closeOnTapped: false,
              color: Colors.grey,
              opacity: .7,
            )
          : null;

    fca.afterNextBuildDo(() {
      // namedSC.jumpTo(150.0);

      showMainCallout();

      fca.afterMsDelayDo(
        800,
        () => _showToast(AlignmentEnum.topCenter),
      );
    });
  }

  @override
  void dispose() {
    namedSC.dispose();
    super.dispose();
  }

  void showMainCallout() {
    fca.showOverlay(
      calloutConfig: fabCC,
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
                  style: TextStyle(
                      color: Colors.green[900], fontStyle: FontStyle.italic)),
            ),
            if (!showCutout)
              SizedBox(
                width: 200,
                child: Row(
                  children: [
                    const Text('followScroll?'),
                    StatefulBuilder(
                        builder: (context, setState) => Checkbox(
                            value: fabCC.followScroll,
                            onChanged: (_) {
                              setState(() => toggleFollowScroll());
                            })),
                  ],
                ),
              )
            else
              SizedBox(
                width: 360,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 6),
                  onPressed: () {
                    showCutout = false;
                    // fca.dismiss('basic');
                    fca.dismissAll();
                    fabCC = basicCalloutConfig(namedSC)
                      ..arrowType = ArrowTypeEnum.VERY_THIN;
                    showMainCallout();
                  },
                  child:
                      const Text('tap this button to remove the barrier and\n'
                          'and proceed to the scroll part of this demo'),
                ),
              ),
            SizedBox(height: 20)
          ],
        ),
      ),
      targetGkF: () => fabGK,
    );
  }

  void toggleFollowScroll() {
    setState(() {
      fabCC.followScroll = !fabCC.followScroll;
      fabCC.rebuild(() {});
    });
  }

  void toggleShowCutout() {
    setState(() {
      showCutout = !showCutout;
      fabCC.rebuild(() {});
    });
  }

  void updateArrowType(ArrowTypeEnum newType) {
    setState(() {
      fabCC.arrowType = newType;
      fabCC.rebuild(() {});
    });
  }

  @override
  void didChangeDependencies() {
    fca.initWithContext(context);
    super.didChangeDependencies();
  }

  void _showToast(AlignmentEnum gravity,
      {int showForMs = 0, VoidCallback? onDismissedF}) {
    if (!showCutout) return;

    // keep away from the edge of screen by 50
    double? contentTranslateX;
    double? contentTranslateY;
    switch (gravity) {
      case AlignmentEnum.topLeft:
        contentTranslateX = 50;
        contentTranslateY = 50;
        break;
      case AlignmentEnum.topRight:
        contentTranslateX = -50;
        contentTranslateY = 50;
        break;
      case AlignmentEnum.topCenter:
        contentTranslateY = 50;
        break;
      case AlignmentEnum.centerLeft:
        contentTranslateX = 50;
        break;
      case AlignmentEnum.centerRight:
        contentTranslateX = -50;
        break;
      case AlignmentEnum.center:
        break;
      case AlignmentEnum.bottomLeft:
        contentTranslateX = 50;
        contentTranslateY = -50;
        break;
      case AlignmentEnum.bottomCenter:
        contentTranslateY = -50;
        break;
      case AlignmentEnum.bottomRight:
        contentTranslateX = -50;
        contentTranslateY = -50;
        break;
    }

    fca.showToast(
      removeAfterMs: showForMs,
      calloutConfig: CalloutConfigModel(
        cId: 'main-toast',
        gravity: gravity,
        initialCalloutW: 500,
        initialCalloutH: 200,
        fillColor: ColorModel.black26(),
        showCloseButton: true,
        borderThickness: 5,
        borderRadius: 16,
        borderColor: ColorModel.yellow(),
        elevation: 10,
        scrollControllerName: namedSC.name,
        onDismissedF: () => onDismissedF?.call(),
        contentTranslateX: contentTranslateX,
        contentTranslateY: contentTranslateY,
      ),
      calloutContent: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                  'this is a Toast callout, positioned according to the gravity:',
                  style: TextStyle(color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: DropdownMenu<AlignmentEnum>(
                initialSelection: gravity,
                controller: gravityController,
                requestFocusOnTap: true,
                inputDecorationTheme: const InputDecorationTheme(
                  filled: true,
                  contentPadding: EdgeInsets.all(20.0),
                ),
                label: const Text(
                  'Gravity',
                  style: TextStyle(color: Colors.blueGrey),
                ),
                onSelected: (AlignmentEnum? newGravity) {
                  fca.dismiss('main-toast');
                  _showToast(
                      selectedGravity = newGravity ?? AlignmentEnum.topCenter);
                },
                dropdownMenuEntries: AlignmentEnum.entries,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (_) => CounterBloc(),
      child: CounterView(this, namedSC, fabGK, countGK),
    );
  }
}

class CounterView extends StatelessWidget {
  final CounterDemoPageState parentState;
  final NamedScrollController namedSC;
  final GlobalKey fabGK;
  final GlobalKey countGK;

  const CounterView(this.parentState, this.namedSC, this.fabGK, this.countGK,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter_Callouts demo'),
        actions: [
          SizedBox(
            width: 300,
            child: Row(
              children: [
                if (!showCutout)
                  SegmentedButton<CalloutPointerTypeEnum?>(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                      foregroundColor: WidgetStatePropertyAll(Colors.purple),
                      side: WidgetStatePropertyAll(
                          BorderSide(color: Colors.purple)),
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                    ),
                    segments: const <ButtonSegment<CalloutPointerTypeEnum?>>[
                      ButtonSegment<CalloutPointerTypeEnum?>(
                        value: CalloutPointerTypeEnum.ARROW,
                        label: Text('arrow'),
                      ),
                      ButtonSegment<CalloutPointerTypeEnum?>(
                        value: CalloutPointerTypeEnum.BUBBLE,
                        label: Text('bubble'),
                      ),
                    ],
                    selected: <CalloutPointerTypeEnum?>{
                      parentState.fabCC.arrowType == ArrowTypeEnum.POINTY
                          ? CalloutPointerTypeEnum.BUBBLE
                          : CalloutPointerTypeEnum.ARROW
                    },
                    onSelectionChanged:
                        (Set<CalloutPointerTypeEnum?> newSelection) {
                      // By default there is only a single segment that can be
                      // selected at one time, so its value is always the first
                      // item in the selected set.
                      CalloutPointerTypeEnum value = newSelection.first!;
                      ArrowTypeEnum newType =
                          value == CalloutPointerTypeEnum.ARROW
                              ? ArrowTypeEnum.THIN
                              : ArrowTypeEnum.POINTY;
                      parentState.updateArrowType(newType);
                    },
                  ),
                Spacer(),
              ],
            ),
          )
        ],
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, int>(
          builder: (context, state) {
            return NotificationListener<SizeChangedLayoutNotification>(
              onNotification: (SizeChangedLayoutNotification notification) {
                fca.afterMsDelayDo(800, () {
                  fca.refreshAll();
                });
                return true;
              },
              child: SizeChangedLayoutNotifier(
                child: Scaffold(
                  body: Center(
                    child: SingleChildScrollView(
                      controller: namedSC,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  key: countGK,
                                  '$state',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: FloatingActionButton(
                                  key: fabGK,
                                  onPressed: () async {
                                    if (!didScroll) {
                                      await showDialog<void>(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (ctx) => AlertDialog(
                                          alignment: Alignment.bottomCenter,
                                          title: const Text(
                                              'Try the scrolling first'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('ok, I will.'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                    if (!didScroll) return;

                                    context
                                        .read<CounterBloc>()
                                        .add(CounterIncrementPressed());
                                    // point out the number using a callout
                                    fca.dismissAll(exceptToasts: true);
                                    int index =
                                        state % AlignmentEnum.values.length;
                                    AlignmentEnum ca = AlignmentEnum.of(index)!;
                                    AlignmentEnum ta = ca.oppositeEnum;
                                    fca.showOverlay(
                                      calloutConfig: basicCalloutConfig(namedSC)
                                        ..calloutAlignment = ca.flutterValue
                                        ..targetAlignment = ta.flutterValue
                                        ..calloutW = 200
                                        ..calloutH = 80
                                        ..fillColor = ColorModel.orangeAccent(),
                                      calloutContent: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Text(
                                          'You have pushed the +\nbutton this many times:',
                                        ),
                                      ),
                                      targetGkF: () => countGK,
                                      removeAfterMs: 3000,
                                    );
                                  },
                                  tooltip: 'Increment',
                                  child: const Icon(Icons.add),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 1000,
                            width: double.infinity,
                            color: Colors.blue[50],
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                  'Scroll to see that the yellow callout is Scroll-aware  --  '
                                  'Resize the window to see the pointer refreshing --  '
                                  'The yellow callout is draggable'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

sealed class CounterEvent {}

final class CounterIncrementPressed extends CounterEvent {}

final class CounterDecrementPressed extends CounterEvent {}

class CounterBloc extends HydratedBloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementPressed>((event, emit) => emit(state + 1));
    on<CounterDecrementPressed>((event, emit) => emit(state - 1));
  }

  @override
  int fromJson(Map<String, dynamic> json) => json['value'] as int;

  @override
  Map<String, int> toJson(int state) => {'value': state};
}

/// the CalloutConfig object is where you configure the callout and its pointer
/// All params are shown, and many are commented out for this example callout
CalloutConfigModel basicCalloutConfig(NamedScrollController nsc) {
  final fillColor = showCutout
      ? ColorModel.fromColor(Colors.cyan)
      : ColorModel.fromColor(Colors.yellow[700]!);
  return CalloutConfigModel(
    cId: 'basic',
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
    fillColor: fillColor,
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
    scrollControllerName: nsc.name,
    followScroll: false,
  );
}

enum CalloutPointerTypeEnum { ARROW, BUBBLE }
