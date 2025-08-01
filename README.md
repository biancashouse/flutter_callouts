<!-- This file uses generated code. Visit https://pub.dev/packages/readme_helper for usage information. -->
# flutter_callouts

<!-- #toc -->
## Table of Contents

[**Motivation**](#motivation)

[**Features**](#features)

[**Quickstart**](#quickstart)

[**Usage**](#usage)
<!-- // end of #toc -->

<!-- #include readme-simple-example-gif.md -->
<hr>
<figure>
    <img src='https://github.com/biancashouse/flutter_callouts/blob/main/example/screen-capture.gif' width="60%" height="60%" title="screen capture" alt='simple example'>
    <figcaption>animated gif of a *simple* demo, illustrating:

- a yellow, draggable, callout pointing to a button (target)
- a black, draggable, toast, positioned topCenter, but can have any of 8 positions
- the appearance of a callout or toast is animated
- the callout arrow is animated
- even when scrolling occur, or window resized, the pointer refreshes
- the toast has been configured to have a red close button
- [visit the web demo](http://google.com)
</figcaption>
</figure>
<hr>
<!-- // end of #include -->

<!-- #include readme-motivation.md -->
## Motivation

We wanted to create a single package that would allow communication with the user in a multitude of scenarios.

- pop up a callout that points to a target widget
- pop up a callout that has no target, but can be positioned on the screen
- pop up a callout as a Toast in a variety of positions (using an Alignment property)
<!-- // end of #include -->

<!-- #include readme-features.md -->
## Features

The Callout API makes it easy for you to point out **target** widgets by showing **callout** widgets.

How a **callout** appears, and interacts with the user is highly configurable.

#### Simple API
- the **target** must have a *GlobalKey*.
- the **callout** must be given a string cId.
- the **callout** requires you to supply the content widget.

- decoupled from your UI
A callout, or toast, is shown in a Flutter Overlay, so does not interfere with your UI.

#### Extremely Configurable

- Every aspect of showing a callout is configurable, in terms of styling, pointing style, draggability, resizability, animation, duration on screen, and more...

  - #### Callout and pointer styling
    Color, shape, decoration, border of callouts is configurable.
    You can configure how your callout points to its Target, such as line with arrow, or bubble shape, and the distance it should be separated from the Target.

  - #### animated
    Appearance is animated, and the pointer to the target can be animated
  
  - #### user draggable
    Callouts can optionally be dragged. You can assign just part of the callout as a drag handle.

  - #### user resizable
    A callout can optionally be surrounded by 4 corner and 4 side resize widgets, i.e. the user can resize a callout by dragging a corner or a side.
  
  - #### tappable barrier
    A callout can have an optional tappable barrier behind. (tap off the callout to close it, otherwise you can configure a close button)

  - #### close button 
    A close button is optional. Its callback, and appearance are configurable.
  
    A callout can also be dismissed, hidden/unhidden using the API.

  - #### got it button
    A callout can be configured to show a "got it" button.

    The tap will get recorded in the Browser or App's local storage (using the callout's id).

  - #### scroll-aware
    If you pass your ScrollController to the API, a callout can continue to point to its Target even when scrolling occurs, the window is resized.

  - #### decoupled, non-intrusive API
    Any widget can be a Target: simply give it a GlobalKey.
  
    No need to insert wrapper widgets in your UI.

    Each callout gets shown in its own Overlay.

  - #### useful callbacks
  
    Every possible callback is provided to allow your app to react to a callout's activity:
  
```dart
        ValueNotifier<int>? movedOrResizedNotifier; // bumps every time callout overlay moved or resized
        Function? onGotitPressedF;
        VoidCallback? onTappedCalloutBarrier;
        VoidCallback? onCloseButtonPressF;
        ValueChanged<Offset>? onDragF;
        VoidCallback? onDragStartedF;
        ValueChanged<Offset>? onDragEndedF;
        ValueChanged<Size>? onResizeF;
        VoidCallback? onDismissedF;
        VoidCallback? onHiddenF;
        VoidCallback? onAcceptedF;
```
<!-- // end of #include -->

<!-- #include readme-quickstart.md -->
## Quickstart

**1.** Install or update **flutter_callouts**:
```bash
flutter pub add flutter_callouts
```
<!-- // end of #include -->

<!-- #include readme-usage.md -->
## Usage

In the simple example demo, a callout and toast are created inside the initState() method.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const FC_MaterialApp(
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
        // arrowType: ArrowType.THIN,
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
        vScrollController: controller,
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

    fca.afterNextBuildDo(() {
      Callout.showOverlay(
        calloutConfig: basicCalloutConfig(controller),
        calloutContentF: (context) => const Padding(
          padding: EdgeInsets.all(8.0),
          child:
              Text('Tap this floating action button to increment the counter.'),
        ),
        targetGkF: () => fabGK,
      );
      fca.afterMsDelayDo(
        800,
        () => _showToast(Alignment.topCenter),
      );
    });
  }

  void _showToast(Alignment gravity,
          {int showForMs = 0, VoidCallback? onDismissedF}) =>
      Callout.showToast(
        removeAfterMs: showForMs,
        calloutConfig: CalloutConfig(
          cId: 'initState-toast',
          gravity: gravity,
          initialCalloutW: 500,
          initialCalloutH: 90,
          fillColor: Colors.black26,
          showCloseButton: true,
          borderThickness: 5,
          borderRadius: 16,
          borderColor: Colors.yellow,
          elevation: 10,
          vScrollController: controller,
          vsync: this,
          onDismissedF: () => onDismissedF?.call(),
        ),
        calloutContentF: (_) => Center(
          child: Text(
            'gravity: ${gravity.toString()}',
            textScaler: const TextScaler.linear(2),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (SizeChangedLayoutNotification notification) {
        // Callout.dismissAll(exceptFeatures: []);
        FlutterCallouts.instance.afterMsDelayDo(300, () {
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
                    height: screenSize.height - 200,
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
                      child: Text('Scroll to see that the yellow callout is Scroll-aware.\n'
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
}
```
<!-- // end of #include -->

<!-- #toc -->
## Table of Contents

[**Motivation**](#motivation)

[**Features**](#features)

[**Quickstart**](#quickstart)

[**Usage**](#usage)
<!-- // end of #toc -->

# Issues & Feedback
Please file an [issue](https://github.com/biancashouse/flutter_callouts/issues) to send feedback or report a bug. Thank you!