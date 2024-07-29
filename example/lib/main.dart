import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

void main() {
  runApp(const FlutterCalloutsSimpleDemo());
}

class FlutterCalloutsSimpleDemo extends StatelessWidget {
  const FlutterCalloutsSimpleDemo({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'flutter_callouts demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// it's important to add the mixin, because callouts are animated
class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _counter = 0;

  late GlobalKey fabGK;

  ScrollController controller = ScrollController();

  /// the CalloutConfig object is where you configure the callout and its pointer
  /// All params are shown, and many are commented out for this example callout
  CalloutConfig basicCalloutConfig(ScrollController controller) =>
      CalloutConfig(
        cId: 'basic',
        // -- initial pos and animation ---------------------------------
        initialTargetAlignment: Alignment.topLeft,
        initialCalloutAlignment: Alignment.bottomRight,
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
        fillColor: Colors.yellow[700],
        // elevation: 10,
        // frameTarget: true,
        // -- optional close button and got it button -------------------
        // showGotitButton: true,
        // showCloseButton: true,
        // closeButtonColor:
        // closeButtonPos:
        // gotitAxis:
        // -- pointer -------------------------------------------------
        // arrowColor: Colors.green,
        arrowType: ArrowType.THIN,
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
        scrollControllerName: 'main',
        vsync: this,
      );

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();

    /// target's key
    fabGK = GlobalKey();

    fca.registerScrollController('main', controller, Axis.vertical);

    fca.afterNextBuildDo(() {
      Callout.showOverlay(
        calloutConfig: basicCalloutConfig(controller),
        calloutContent: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Tap this floating action button to increment the counter.'),
            ],
          ),
        ),
        targetGkF: () => fabGK,
      );
      fca.afterMsDelayDo(
        800,
        () => _showToast(Alignment.topCenter),
      );
    });
  }

  @override
  void didChangeDependencies() {
    fca.initWithContext(context);
    super.didChangeDependencies();
  }

  void _showToast(Alignment gravity,
          {int showForMs = 0, VoidCallback? onDismissedF}) =>
      Callout.showToast(
        removeAfterMs: showForMs,
        calloutConfig: CalloutConfig(
          cId: 'main-toast',
          gravity: gravity,
          initialCalloutW: 500,
          initialCalloutH: 90,
          fillColor: Colors.black26,
          showCloseButton: true,
          borderThickness: 5,
          borderRadius: 16,
          borderColor: Colors.yellow,
          elevation: 10,
          scrollControllerName: 'main',
          vsync: this,
          onDismissedF: () => onDismissedF?.call(),
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
  Widget build(BuildContext context) =>
      NotificationListener<SizeChangedLayoutNotification>(
        onNotification: (SizeChangedLayoutNotification notification) {
          // Callout.dismissAll(exceptFeatures: []);
          fca.afterMsDelayDo(300, () {
            Callout.refreshAll();
          });
          return true;
        },
        child: SizeChangedLayoutNotifier(
          child: Scaffold(
            body: Center(
              child: SingleChildScrollView(
                controller: controller,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'You have pushed the + button this many times:',
                          ),
                          Text(
                            '$_counter',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 100,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: FloatingActionButton(
                            key: fabGK,
                            onPressed: _incrementCounter,
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
                            'Scroll to see that the yellow callout is Scroll-aware.\n'
                            'Resize the window to see the pointer refreshing.'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
