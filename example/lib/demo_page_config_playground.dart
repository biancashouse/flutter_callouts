import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

import 'alignment_menu.dart';
import 'property_button_enum.dart';

class DemoPage_ConfigPlayground extends StatefulWidget {
  const DemoPage_ConfigPlayground({super.key});

  static Color buttonColor = Colors.pink;

  @override
  State<DemoPage_ConfigPlayground> createState() =>
      _DemoPage_ConfigPlaygroundState();

  static Widget demoLaunchBtn(context) => FilledButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const DemoPage_ConfigPlayground()),
          );
        }, // _button1,
        style: FilledButton.styleFrom(backgroundColor: buttonColor),
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'Callout Playground (alignments)',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

//   static Widget bottomSheetContents(scaffoldChildContext) => const Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           // Text('About this callout',
//           //     style: TextStyle(
//           //         fontWeight: FontWeight.bold, color: Colors.white70)),
//           Text(
//             '''
// Invoked via Callouts.showOverlay(...)
// Callout is an Overlay
// Has a 25% opacity barrier
// Tap barrier, or press Esc key, to close callout
// Callout 'points' to its Target widget (button)
// Pointer is animated
// Pointer type is ArrowType.THIN''',
//             textScaler: TextScaler.linear(.9),
//             style: TextStyle(color: Colors.white, fontFamily: 'monospace'),
//           ),
//         ],
//       );
}

class _DemoPage_ConfigPlaygroundState extends State<DemoPage_ConfigPlayground>
    with TickerProviderStateMixin {
  /// notifier used to trigger target and/or callout rebuilds on windows resize, or scrolling, or callout move/resize
  final notifier = ValueNotifier<int>(0);

  /// need a focus to handle Esc key
  final focusNodeForEscapeKey = FocusNode();

  /// giving the target widget a GlobalKey allows its pos and size to be measured
  final _target1GK = GlobalKey();
  final _target2GK = GlobalKey();

  List<bool> _isOpen = [false, false, false, false, false];

  /// editable CalloutConfig properies
  late CalloutConfig latestCC;

  // edits are done on the original state calloutConfig, but we always use a copy
  CalloutConfig newCC() => CalloutConfig(
        feature: 'playground',
        // -- initial pos and animation ---------------------------------
        initialTargetAlignment: Alignment.centerLeft,
        initialCalloutAlignment: Alignment.centerRight,
        // initialCalloutPos:
        finalSeparation: 100,
        // fromDelta: 0.0,
        // toDelta : 0.0,
        // initialAnimatedPositionDurationMs:
        // -- optional barrier (when opacity > 0) ----------------------
        barrier: CalloutBarrier(
          opacity: .5,
          onTappedF: () {
            Callout.dismiss("playground");
          },
        ),
        // -- callout appearance ----------------------------------------
        suppliedCalloutW: 280,
        suppliedCalloutH: 200,
        borderRadius: 12,
        borderThickness: 3,
        // fillColor: Colors.yellow,
        // elevation: 10,
        // frameTarget: true,
        // -- optional close button and got it button -------------------
        // showCloseButton: true,
        // showGotitButton: true,
        // closeButtonColor:
        // closeButtonPos:
        // gotitAxis:
        // -- pointer -------------------------------------------------
        // arrowColor: Colors.green,
        // arrowType: ArrowType.THIN,
        // animate: true,
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
        draggable: true,
        // draggableColor: Colors.green,
        // dragHandleHeight: ,
        vsync: this,
      );

  @override
  void initState() {
    super.initState();
    latestCC = newCC();
    FCallouts().afterNextBuildDo(() {
      _button1Tapped().then((_) {
        _button2Tapped();
      });
    });
  }

  @override
  void didChangeDependencies() {
    /// initialize the Callouts API with the root context
    FCallouts().initWithContext(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    /// detect window size changes
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (SizeChangedLayoutNotification notification) {
        debugPrint("SizeChangedLayoutNotification - onNotification()");
        // Callout.dismissAll();
        notifier.value++;
        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: KeyboardListener(
          autofocus: true,
          focusNode: focusNodeForEscapeKey, // <-- more magic
          onKeyEvent: (KeyEvent event) {
            if (event.logicalKey == LogicalKeyboardKey.escape) {
              Callout.dismissAll();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              leadingWidth: 100,
              leading: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  BackButton(onPressed: () => Navigator.pop(context, true)),
                  const DrawerButton(
                    color: Colors.purpleAccent,
                  ),
                ],
              ),
              title: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                      'Callout Playground (Target & Callout widget alignments)'),
                ],
              ),
              // actions: [
              //   // IconButton.filledTonal(onPressed: (){}, icon: Icon(Icons.play_arrow, color:Colors.red)),
              //   IconButton(onPressed: (){}, icon: Icon(Icons.play_arrow, color:Colors.red), iconSize: 36,),
              //   Container(width: 200)
              // ],
            ),
            body: Builder(builder: (scaffoldChildContext) {
              return Stack(
                children: [
                  Align(
                    alignment: Alignment(0, -0.75),
                    child: FilledButton(
                      key: _target1GK,
                      onPressed: () {
                        // show the callout
                        _button1Tapped();
                        // show info about this demo
                        // showBottomSheet(
                        //     backgroundColor: Colors.black,
                        //     context: scaffoldChildContext,
                        //     builder: (_) {
                        //       return Padding(
                        //         padding: const EdgeInsets.all(18.0),
                        //         child:
                        //             DemoPage_ConfigPlayground.bottomSheetContents(
                        //                 scaffoldChildContext),
                        //       );
                        //     });
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.all(10),
                        textStyle: const TextStyle(color: Colors.white),
                      ),
                      child: const Text("I'm a target widget. tap me"),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: FilledButton(
                      key: _target2GK,
                      onPressed: () {
                        // show the callout
                        _button2Tapped();
                        // show info about this demo
                        // showBottomSheet(
                        //     backgroundColor: Colors.black,
                        //     context: scaffoldChildContext,
                        //     builder: (_) {
                        //       return Padding(
                        //         padding: const EdgeInsets.all(18.0),
                        //         child:
                        //             DemoPage_ConfigPlayground.bottomSheetContents(
                        //                 scaffoldChildContext),
                        //       );
                        //     });
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.all(10),
                        textStyle: const TextStyle(color: Colors.white),
                      ),
                      child: const Text("I'm a target widget. tap me"),
                    ),
                  ),
                ],
              );
            }),
            drawer: Drawer(
              backgroundColor: Colors.purpleAccent,
              width: 400,
              child: ListView(
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.purpleAccent,
                    ),
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'The flutter_callouts package has an extensive API.\n'
                      'You configure a callout by providing a CalloutConfig object.\n'
                      'Edit the CalloutConfig properties below...',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: ExpansionPanelList(
                        expansionCallback: (i, isOpen) {
                          setState(() => _isOpen[i] = isOpen);
                        },
                        children: [
                          initialPositionPropertiesPanel(),
                          draggingPropertiesPanel(),
                          resizingPropertiesPanel(),
                          pointerPropertiesPanel(),
                          stylingPropertiesPanel(),
                          closeButtonProperties(),
                          callbacksPanel(),
                        ],
                      ),
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

  void _showCallout(final CalloutConfig cc, final GlobalKey targetGK) {
    Callout.showOverlay(
      targetGkF: () => targetGK,
      targetChangedNotifier: notifier,
      boxContentF: (ctx) => _calloutWidget(cc.fillColor!),
      calloutConfig: cc,
    );
  }

  Future<void> _button1Tapped() async {
    // _showCallout(latestCC = newCC());

    await _showAlignments1();

    // await _showSizeAnimations();

    // await _animateAroundArc(0, 180, 200);
  }

  Future<void> _button2Tapped() async {
    // _showCallout(latestCC = newCC());

    await _showAlignments2();

    // await _showSizeAnimations();

    // await _animateAroundArc(0, 180, 200);
  }

  ExpansionPanel initialPositionPropertiesPanel() => ExpansionPanel(
        isExpanded: _isOpen[0],
        canTapOnHeader: true,
        headerBuilder: (context, isExpanded) =>
            const Center(child: Text('Initial Positioning')),
        body: Card(
          color: Colors.purpleAccent,
          child: Column(
            children: [
              PropertyButton<AlignmentEnum>(
                label: 'initialTargetAlignment',
                menuItems:
                    AlignmentEnum.values.map((e) => e.toMenuItem()).toList(),
                originalValue: latestCC.initialTargetAlignment == null
                    ? null
                    : AlignmentEnum.fromFlutterValue(
                        latestCC.initialTargetAlignment!),
                onChangeF: (newIndex) {
                  setState(() {
                    latestCC.initialTargetAlignment =
                        AlignmentEnum.of(newIndex)?.flutterValue;
                  });
                },
                wrap: true,
                calloutButtonSize: const Size(300, 40),
                calloutSize: const Size(240, 200),
              ),
              PropertyButton<AlignmentEnum>(
                label: 'initialCalloutAlignment',
                menuItems:
                    AlignmentEnum.values.map((e) => e.toMenuItem()).toList(),
                originalValue: latestCC.initialCalloutAlignment == null
                    ? null
                    : AlignmentEnum.fromFlutterValue(
                        latestCC.initialCalloutAlignment!),
                onChangeF: (newIndex) {
                  setState(() {
                    latestCC.initialCalloutAlignment =
                        AlignmentEnum.of(newIndex)?.flutterValue;
                  });
                },
                wrap: true,
                calloutButtonSize: const Size(300, 40),
                calloutSize: const Size(240, 200),
              ),
            ],
          ),
        ),
      );

  ExpansionPanel draggingPropertiesPanel() => ExpansionPanel(
        isExpanded: _isOpen[1],
        headerBuilder: (context, isExpanded) =>
            const Center(child: Text('Draggability')),
        body: const Card(),
      );

  ExpansionPanel resizingPropertiesPanel() => ExpansionPanel(
        headerBuilder: (context, isExpanded) =>
            const Center(child: Text('Resizeable')),
        body: const Card(),
      );

  ExpansionPanel pointerPropertiesPanel() => ExpansionPanel(
        headerBuilder: (context, isExpanded) =>
            const Center(child: Text('Pointer')),
        body: const Card(),
      );

  ExpansionPanel stylingPropertiesPanel() => ExpansionPanel(
        headerBuilder: (context, isExpanded) =>
            const Center(child: Text('Styling')),
        body: const Card(),
      );

  ExpansionPanel closeButtonProperties() => ExpansionPanel(
        headerBuilder: (context, isExpanded) =>
            const Center(child: Text('Close Button')),
        body: const Card(),
      );

  ExpansionPanel callbacksPanel() => ExpansionPanel(
        headerBuilder: (context, isExpanded) =>
            const Center(child: Text('Callbacks')),
        body: const Card(),
      );

  Widget _calloutWidget(Color color) => Card.filled(
        child:
            FCallouts().assetPicWithFadeIn(path: 'assets/images/blue-jug.jpeg'),
      );

  Future<void> _showAlignments1() async {
    // animate alignment around the clock
    // await Future.delayed(1.seconds);
    Callout.dismiss('playground');
    latestCC = newCC()
      ..barrier = null
      ..fillColor = Colors.orange
      ..arrowColor = Colors.orange
      ..initialTargetAlignment = Alignment.centerRight
      ..initialCalloutAlignment = Alignment.centerLeft;
    _alignmentBottomToast();
    _showCallout(latestCC, _target1GK);

    await Future.delayed(1.seconds);
    Callout.dismiss('playground');
    latestCC = newCC()
      ..barrier = null
      ..fillColor = Colors.grey
      ..arrowColor = Colors.grey
      ..initialTargetAlignment = Alignment.bottomRight
      ..initialCalloutAlignment = Alignment.topLeft;
    _alignmentBottomToast();
    _showCallout(latestCC, _target1GK);

    await Future.delayed(1.seconds);
    Callout.dismiss('playground');
    latestCC = newCC()
      ..barrier = null
      ..fillColor = Colors.pink
      ..arrowColor = Colors.pink
      ..initialTargetAlignment = Alignment.bottomCenter
      ..initialCalloutAlignment = Alignment.topCenter;
    _alignmentBottomToast();
    _showCallout(latestCC, _target1GK);

    await Future.delayed(1.seconds);
    Callout.dismiss('playground');
    latestCC = newCC()
      ..barrier = null
      ..fillColor = Colors.brown
      ..arrowColor = Colors.brown
      ..initialTargetAlignment = Alignment.bottomLeft
      ..initialCalloutAlignment = Alignment.topRight;
    _alignmentBottomToast();
    _showCallout(latestCC, _target1GK);

    await Future.delayed(1.seconds);
    Callout.dismiss('playground');
    latestCC = newCC()
      ..barrier = null
      ..fillColor = Colors.teal
      ..arrowColor = Colors.teal
      ..initialTargetAlignment = Alignment.centerLeft
      ..initialCalloutAlignment = Alignment.centerRight;
    _showCallout(latestCC, _target1GK);
    _alignmentBottomToast();

    await Future.delayed(3.seconds);
    Callout.dismissAll();
  }

  Future<void> _showAlignments2() async {
    // animate alignment around the clock
    // await Future.delayed(1.seconds);
    Callout.dismiss('playground');
    latestCC = newCC()
      ..barrier = null
      ..fillColor = Colors.teal
      ..arrowColor = Colors.teal
      ..initialTargetAlignment = Alignment.centerLeft
      ..initialCalloutAlignment = Alignment.centerRight;
    _showCallout(latestCC, _target2GK);
    _alignmentBottomToast();

    await Future.delayed(1.seconds);
    Callout.dismiss('playground');
    latestCC = newCC()
      ..barrier = null
      ..fillColor = Colors.red
      ..arrowColor = Colors.red
      ..initialTargetAlignment = Alignment.topLeft
      ..initialCalloutAlignment = Alignment.bottomRight;
    _alignmentBottomToast();
    _showCallout(latestCC, _target2GK);

    await Future.delayed(1.seconds);
    Callout.dismiss('playground');
    latestCC = newCC()
      ..barrier = null
      ..fillColor = Colors.blue
      ..arrowColor = Colors.blue
      ..initialTargetAlignment = Alignment.topCenter
      ..initialCalloutAlignment = Alignment.bottomCenter;
    _alignmentBottomToast();
    _showCallout(latestCC, _target2GK);

    await Future.delayed(1.seconds);
    Callout.dismiss('playground');
    latestCC = newCC()
      ..barrier = null
      ..fillColor = Colors.lime
      ..arrowColor = Colors.lime
      ..initialTargetAlignment = Alignment.topRight
      ..initialCalloutAlignment = Alignment.bottomLeft;
    _alignmentBottomToast();
    _showCallout(latestCC, _target2GK);

    await Future.delayed(1.seconds);
    Callout.dismiss('playground');
    latestCC = newCC()
      ..barrier = null
      ..fillColor = Colors.orange
      ..arrowColor = Colors.orange
      ..initialTargetAlignment = Alignment.centerRight
      ..initialCalloutAlignment = Alignment.centerLeft;
    _alignmentBottomToast();
    _showCallout(latestCC, _target2GK);

    await Future.delayed(3.seconds);
    Callout.dismissAll();
  }

  Future<void> _showSizeAnimations() async {
    // animate to show resizing via corners
    Callout.dismiss('playground');
    latestCC = newCC()
      ..fillColor = Colors.red
      ..arrowType = ArrowType.POINTY
      ..initialTargetAlignment = Alignment.centerLeft
      ..initialCalloutAlignment = Alignment.centerRight
      ..finalSeparation = 150
      ..separation = 0;
    _showCallout(latestCC, _target2GK);
    await Future.delayed(2.seconds);

    await latestCC.animateResizeByCornerMove(Alignment.topLeft, -50, -50,
        duration: 1.seconds);
    await latestCC.animateResizeByCornerMove(Alignment.topLeft, 50, 50,
        duration: 1.seconds);

    latestCC.rebuild(() {
      latestCC.fillColor = Colors.grey;
    });
    // Callout.dismiss('playground');
    // latestCC.redraw();
    // _showCallout(latestCC);
    await Future.delayed(200.ms);
  }

  Future<void> _animateAroundArc(
      double fromAngle, double toAngle, double separation) async {
    await Future.delayed(500.ms);
    Callout.dismiss('playground');
    latestCC = newCC()
      ..fillColor = Colors.deepOrange
      ..arrowColor = Colors.deepOrange
      ..initialTargetAlignment = Alignment.topCenter
      ..initialCalloutAlignment = Alignment.bottomCenter
      ..finalSeparation = separation;
    _showCallout(latestCC, _target2GK);
    return;
    AnimationController controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    Animation<double> angleAnimation =
        Tween<double>(begin: 0.0, end: 2 * pi).animate(controller);

    angleAnimation.addListener(() {
      debugPrint('angle: ${angleAnimation.value}');
      latestCC.rebuild(() {
        var w = separation * cos(angleAnimation.value);
        var h = separation * cos(angleAnimation.value);
        latestCC.initialTargetAlignment = Alignment(w, h);
        latestCC.initialCalloutAlignment = Alignment(w, h).opposite;
        latestCC.calcContentTopLeft();
        debugPrint('${latestCC.left}, ${latestCC.top}');
      });
      Callout.refresh(latestCC.feature);
    });

    controller.forward(from: 0.0);
  }

  /// create a row of (icon, property name, property value) for use in a GridView
  Widget _iconFromType(final dynamic pValue) {
    if (pValue is Color) {
      return Icon(Icons.square, color: pValue as Color);
    } else if (pValue is Alignment) {
      AlignmentEnum? alEnum = AlignmentEnum.fromFlutterValue(pValue);
      return alEnum.toMenuItem();
    } else {
      return const Offstage();
    }
  }

  String _valueString(final dynamic pValue) {
    if (pValue is Color) {
      return switch (pValue) {
        Colors.red => 'red',
        Colors.pink => 'pink',
        Colors.blue => 'blue',
        Colors.green => 'green',
        Colors.lime => 'lime',
        Colors.deepOrange => 'deepOrange',
        Colors.grey => 'grey',
        Colors.brown => 'brown',
        Colors.black => 'black',
        Colors.orange => 'orange',
        Colors.yellow => 'yellow',
        Colors.teal => 'teal',
        Colors.red => 'red',
        Colors.teal => 'teal',
        Colors.transparent => 'transparent',
        _ => pValue.toString()
      };
    } else if (pValue is Alignment) {
      AlignmentEnum? alEnum = AlignmentEnum.fromFlutterValue(pValue);
      return alEnum.toString();
    } else {
      return pValue.toString();
    }
  }

  TableRow _propertyTableRow(final String propName, final dynamic propValue) =>
      TableRow(children: [
        TableCellPadded(child: _iconFromType(propValue)),
        TableCellPadded(
            child: FCallouts().coloredText(propName, color: Colors.lime)),
        TableCellPadded(
            child: FCallouts()
                .coloredText(_valueString(propValue), color: Colors.yellow)),
      ]);

  void _alignmentBottomToast() {
    List<TableRow> properties = [
      _propertyTableRow('arrowColor', latestCC.arrowColor),
      _propertyTableRow('fillColor', latestCC.fillColor),
      _propertyTableRow(
          'initialTargetAlignment', latestCC.initialTargetAlignment),
      _propertyTableRow(
          'initialCalloutAlignment', latestCC.initialCalloutAlignment),
    ];
    Callout.showWidgetToast(
      feature: 'bottom-toast',
      gravity: Alignment.bottomCenter,
      width: 700,
      height: 200,
      removeAfterMs: 0,
      contents: (_) => DefaultTextStyle(
        style: const TextStyle(color: Colors.yellow),
        child: Table(
          defaultColumnWidth: const FixedColumnWidth(300.0),
          columnWidths: {0: FixedColumnWidth(properties.length * 16)},
          border: TableBorder.all(
              color: Colors.grey, style: BorderStyle.solid, width: 2),
          children: [
            const TableRow(
                decoration: BoxDecoration(color: Colors.white),
                children: [
                  TableCellPadded(child: Offstage()),
                  TableCellPadded(
                      child: Text(
                    'Property Name',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  )),
                  TableCellPadded(
                      child: Text('Property Value',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold))),
                ]),
            ...properties,
          ],
        ),
      ),
    );
  }

// void _bottomSheet(final Widget contents) =>                     showBottomSheet(
//     backgroundColor: Colors.black,
//     context: scaffoldChildContext,
//     builder: (_) {
//       return Padding(
//         padding: const EdgeInsets.all(18.0),
//         child:
//         DemoPage_ConfigPlayground.bottomSheetContents(
//             scaffoldChildContext),
//       );
//     }
}

class TableCellPadded extends StatelessWidget {
  final EdgeInsets? padding;
  final Widget child;
  final TableCellVerticalAlignment verticalAlignment;

  const TableCellPadded(
      {super.key,
      this.padding,
      required this.child,
      this.verticalAlignment = TableCellVerticalAlignment.middle});

  @override
  TableCell build(BuildContext context) => TableCell(
      verticalAlignment: verticalAlignment,
      child:
          Padding(padding: padding ?? const EdgeInsets.all(6.0), child: child));
}
