// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_callouts/flutter_callouts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

// lazy ;-)
bool followScroll = false;

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

  NamedScrollController namedSC = NamedScrollController('main', Axis.vertical);

  late List<Alignment> alignments;

  @override
  void initState() {
    super.initState();

    /// target's key
    fabGK = GlobalKey();
    countGK = GlobalKey();

    fabCC = basicCalloutConfig(namedSC)..arrowType = ArrowTypeEnum.POINTY;

    fca.afterNextBuildDo(() {
      fca.showOverlay(
        calloutConfig: fabCC,
        calloutContent: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                  'Tap this floating action button to increment the counter.'),
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
              ),
            ],
          ),
        ),
        targetGkF: () => fabGK,
      );
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

  void toggleFollowScroll() {
    setState(() {
      fabCC.followScroll = !fabCC.followScroll;
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
          {int showForMs = 0, VoidCallback? onDismissedF}) =>
      fca.showToast(
        removeAfterMs: showForMs,
        calloutConfig: CalloutConfigModel(
          cId: 'main-toast',
          gravity: gravity,
          initialCalloutW: 500,
          initialCalloutH: 90,
          fillColor: ColorModel.black26(),
          showCloseButton: true,
          borderThickness: 5,
          borderRadius: 16,
          borderColor: ColorModel.yellow(),
          elevation: 10,
          scrollControllerName: namedSC.name,
          onDismissedF: () => onDismissedF?.call(),
          contentTranslateY: 50,
        ),
        calloutContent: Center(
          child: Text(
            'gravity: ${gravity.toString()}',
            textScaler: const TextScaler.linear(2),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );

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
        title: const Text('Counter'),
        actions: [
          SizedBox(
            width: 300,
            child: Row(
              children: [
                SegmentedButton<CalloutPointerTypeEnum?>(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                    foregroundColor: WidgetStatePropertyAll(Colors.purple),
                    side: WidgetStatePropertyAll(
                        BorderSide(color: Colors.purple)),
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
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
                                  onPressed: () {
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
                                      removeAfterMs: 2000,
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
  final fillColor = ColorModel.fromColor(Colors.yellow[700]!);
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
    frameTarget: true,
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
    // scaleTarget:
    // -- resizing -------------------------------------------------
    // resizeableH: true,
    // resizeableV: true,
    // -- dragging -------------------------------------------------
    // draggable: false,
    // draggableColor: Colors.green,
    // dragHandleHeight: ,
    scrollControllerName: nsc.name,
    followScroll: true,
    // barrier: CalloutBarrierConfig(
    //   cutoutPadding: 30,
    //   excludeTargetFromBarrier: true,
    //   roundExclusion: true,
    //   closeOnTapped: true,
    //   color: Colors.grey,
    //   opacity: .5,
    // ),
  );
}

enum CalloutPointerTypeEnum { ARROW, BUBBLE }
