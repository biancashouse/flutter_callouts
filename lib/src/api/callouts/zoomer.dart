// ignore_for_file: camel_case_types

import 'package:bh_shared/bh_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

class Zoomer extends StatefulWidget {
  final Widget child;
  final ScrollController? ancestorHScrollController;
  final ScrollController? ancestorVScrollController;

  static const Duration ZOOM_TRANSITION_DURATION_MS = ms500;
  static const Duration ZOOM_IMMEDIATELY = immediate;

  const Zoomer({
    required this.child,
    this.ancestorHScrollController,
    this.ancestorVScrollController,
    super.key,
  }); // : super(key: GlobalKey(debugLabel: "Zoomer"));

  static ZoomerState? of(BuildContext context) {
    if (!context.mounted) {
      debugPrint('context not mounted!');
    }
    var result = context.findAncestorStateOfType<ZoomerState>();
    if (result == null) {
      debugPrint('Zoomer not found!');
    }
    return result;
  }

  @override
  State<Zoomer> createState() => ZoomerState();
}

class ZoomerState extends State<Zoomer>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  BuildContext? updatedContext;

  // late MaterialSPAState? parentAppState;
  late Animation<Matrix4> _matrix4Animation;
  late AnimationController _aController;
  late Alignment _transformAlignment;

  // Rect? _rect;
  // double _scaleX = 1;
  // double _scaleY = 1;

  // called when refreshing from slider change (zero duration etc)
  zoomImmediately(final double scaleX, final double scaleY) {
    _matrix4Animation = Matrix4Tween(
        begin: Matrix4.identity(),
        end: Matrix4.identity().scaled(scaleX, scaleY))
        .animate(_aController);
    _aController
      ..duration = const Duration()
      ..reset()
      ..forward();
    // // ..reset
    // ..forward().then((value) {
    //   _aController.duration = DEFAULT_TRANSITION_DURATION_MS;
    // });
  }

  void applyTransform(
      final double scaleX,
      final double scaleY,
      final Alignment alignment, {
        required VoidCallback afterTransformF,
      }) {
    if (scaleX == 1.0){
      afterTransformF.call();
    }
    else {
      _matrix4Animation = Matrix4Tween(
          begin: Matrix4.identity(),
          end: (Matrix4.identity().scaled(scaleX, scaleY)))
          .animate(_aController);
      _transformAlignment = alignment;
      _aController
        ..duration = scaleX > 1 ? Zoomer.ZOOM_TRANSITION_DURATION_MS : Zoomer
            .ZOOM_IMMEDIATELY
        ..reset()
        ..forward().then((value) => afterTransformF.call());
    }
  }

  void resetTransform({required VoidCallback afterTransformF}) {
    Duration? savedDuration = _aController.duration;
    _aController
      ..duration = const Duration(milliseconds: 200)
      ..reverse().then((value) {
        _aController.duration = savedDuration;
        afterTransformF.call();
      });
  }

  @override
  void initState() {
    super.initState();

    // debugPrint('*** Zoomer() ***');

    // parentAppState =
    //     MaterialSPA.of(context.mounted ? context : updatedContext!);

    if (widget.ancestorHScrollController != null) {
      fca.registerScrollController(widget.ancestorHScrollController!);
    }
    if (widget.ancestorVScrollController != null) {
      fca.registerScrollController(widget.ancestorVScrollController!);
    }

    // make available globally
    // CAPIState.gkMap[widget.twName] = widget.key as GlobalKey;

    _aController = AnimationController(vsync: this);

    // initially no transform
    _matrix4Animation = Matrix4Tween(
      begin: Matrix4.identity(),
      end: Matrix4.identity(),
    ).animate(_aController);

    _transformAlignment = Alignment.center;

    // _aController.addListener(() {
    //   debugPrint("_aController: ${_aController.toStringDetails()}");
    // });
    //
    // _aController.addStatusListener((status) {
    //   debugPrint("_aController status: $status");
    // });

    // _aController.forward();

    // zoomImmediately(2.0, 2.0);


    // Future.delayed(const Duration(seconds: 2), (){
    //   resetTransform();
    // });
  }

  void _initializeFields() {
    _aController.duration = Zoomer.ZOOM_TRANSITION_DURATION_MS;
  }

  @override
  void reassemble() {
    _initializeFields();
    super.reassemble();
  }

  @override
  dispose() {
    _aController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // Useful.instance.initWithContext(context);
    updatedContext = context;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _aController,
        builder: (BuildContext context, _) {
          return Transform(
            transform: _matrix4Animation.value,
            alignment: _transformAlignment,
            child: widget.child,
            // child: BlocBuilder<CAPIBloC, CAPIState>(
            //     builder: (context, state) => widget.child),
          );
        });
  }
}
