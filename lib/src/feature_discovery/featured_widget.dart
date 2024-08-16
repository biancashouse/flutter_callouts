import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

import 'discovery_controller.dart';
import 'discovery_overlay.dart';

// content builder passed in to container needs a handle to that container so it can get call its dismiss when the gitit button is tapped, or in the event of a timeout
enum WhyDismissed { gotit, tappedOffDiscoveryShape, tappedAction }

class FeaturedWidget extends StatefulWidget {
  final DiscoveryController discoveryController;
  final Feature featureEnum;
  final WidgetBuilder childBuilder;
  final FeaturedWidgetActionF? childTapActionF;
  final FeaturedWidgetActionF? childDoubleTapActionF;
  final bool autoPlay;
  final FeaturedWidgetHelpContentBuilder helpContentBuilder;
  final bool notAnIconFeature;
  final bool notTappable;

  //final BuildContext parentContext; ??

//  final ContentWidgetBuilder rectContentBuilder;
  final OverlayContentOrientationEnum overlayContentOrientation;
  final bool dependsOnGotit; //false means definitely play
  final Color overlayBgColor;
  final Color overlayFgColor;
  final Color? overlayTargetBgColor;
  final double? overlayTargetOpacity;
  final double overlayOpacity;
  final Function(BuildContext?)? beforePlayF;
  final Function? overlayDismissedF;

  FeaturedWidget({
    required this.discoveryController,
    required this.childBuilder,
    required this.featureEnum,
    this.autoPlay = true,
    // played content will be either for an icon overlay, rect overlay, or bottom sheet dialog
    required this.helpContentBuilder,
    this.notAnIconFeature = false,
    this.notTappable = false,
//    this.rectContentBuilder,
    required this.overlayBgColor,
    required this.overlayFgColor,
    required this.overlayContentOrientation,
    this.dependsOnGotit = true,
    this.overlayTargetBgColor,
    this.overlayTargetOpacity,
    this.overlayOpacity = .9,
    this.childTapActionF,
    this.childDoubleTapActionF,
    this.beforePlayF,
    this.overlayDismissedF,
  }) : super(key: GlobalKey<FeaturedWidgetState>()) {
    discoveryController.registerFeaturedWidget(key as GlobalKey<FeaturedWidgetState>?);
  }

  @override
  FeaturedWidgetState createState() => FeaturedWidgetState();

  void play() {
    // play icon or rect overlay on animation completion
    FeaturedWidgetState? state = (key as GlobalKey<FeaturedWidgetState>).currentState;
    if (beforePlayF != null) beforePlayF!(state?.context);
    state?.start();
  }

  void stop() {
    FeaturedWidgetState? state = (key as GlobalKey<FeaturedWidgetState>).currentState;
    state?.stop();
  }

  void gotit() {
    FeaturedWidgetState? state = (key as GlobalKey<FeaturedWidgetState>).currentState;
    state?.dismiss(WhyDismissed.gotit);
  }

//  void setStoppedF() {
//    _DiscoverableContainerState state = (key as GlobalKey).currentState;
//    state?.dismiss();
//  }

//  DiscoveryController controller() {
//    _DiscoverableContainerState state = (key as GlobalKey).currentState;
//    return state.discoveryController;
//  }

  //DiscoveryController controller(BuildContext context) => FeatureDiscoveryScaffoldBody.controllerOf(context);

  Widget googleStyleOverlayContent(BuildContext context,
          {String? theTitle, required String theDescr, Color theColor = Colors.white, bool includeGotit = true, double textSize = 1.0}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (theTitle != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                theTitle,
                style: TextStyle(
                  fontSize: textSize * 20.0,
                  color: theColor,
                ),
              ),
            ),
          Text(
            theDescr,
            style: TextStyle(
              fontSize: textSize * 16.0,
              color: theColor.withOpacity(0.95),
            ),
          ),
          if (includeGotit)
            Align(alignment: getAlignment() ?? Alignment.bottomLeft, child: gotitButtonForDiscoverableContainer(context, theParent: this))
        ],
      );

  Widget richTextOverlayContent(BuildContext context, {RichText? theContent, bool includeGotit = true}) => Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          theContent as Widget,
          includeGotit ? Align(alignment: getAlignment()!, child: gotitButtonForDiscoverableContainer(context, theParent: this)) : const Offstage(),
        ],
      );

  Alignment? getAlignment() {
    switch (overlayContentOrientation) {
      case OverlayContentOrientationEnum.below:
        return Alignment.bottomRight;
      case OverlayContentOrientationEnum.onLeftBelow:
        return Alignment.bottomRight;
      case OverlayContentOrientationEnum.onLeftAbove:
        return Alignment.bottomRight;
      default:
        return null;
    }
  }

  Widget gotitButtonForDiscoverableContainer(BuildContext context,
      {required FeaturedWidget theParent, bool iconOnly = false, bool arrangeVertically = false}) {
    Alignment? alignment = getAlignment();
    Widget btn = ElevatedButton(
      onPressed: () {
        fca.gotit(theParent.featureEnum);
        // may also invoke a custom dismissF
        theParent.gotit();
      },
      child: Flex(
        direction: arrangeVertically ? Axis.vertical : Axis.horizontal,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.thumb_up,
              color: theParent.overlayFgColor,
              size: 36.0,
            ),
          ),
          iconOnly
              ? const Offstage()
              : Text(
                  'got it',
                  style: TextStyle(color: theParent.overlayFgColor, fontSize: 14.0),
                ),
        ],
      ),
    );

    return alignment != null ? Align(alignment: alignment, child: btn) : btn;
  }
}

class FeaturedWidgetState extends State<FeaturedWidget> with TickerProviderStateMixin {
  bool showOverlay = false;
  OverlayStatusEnum state = OverlayStatusEnum.closed;
  double transitionPercent = 1.0;
  WhyDismissed? whyDismissed;

  late AnimationController openController;
  late AnimationController pulseController;
  late AnimationController tapActivationController;
  late AnimationController doubleTapActivationController;
  late AnimationController dismissController;

  @override
  void initState() {
    super.initState();

    initAnimationControllers();
  }

  @override
  void dispose() {
    stopAnimationControllers();
    super.dispose();
  }

  void start() {
    showOverlay = true;
    didChangeDependencies();
  }

  void stop() {
    setState(() {
      dismiss(WhyDismissed.tappedAction);
    });
  }

  void initAnimationControllers() {
    openController = AnimationController(
      duration: openControllerDuration,
      vsync: this,
    )
      ..addListener(() {
        setState(() => transitionPercent = openController.value);
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.forward) {
          setState(() => state = OverlayStatusEnum.opening);
        } else if (status == AnimationStatus.completed) {
          pulseController.forward(from: 0.0);
        }
      });

    pulseController = AnimationController(
      duration: pulseControllerDuration,
      vsync: this,
    )
      ..addListener(() {
        setState(() => transitionPercent = pulseController.value);
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.forward) {
          setState(() => state = OverlayStatusEnum.pulsing);
        } else if (status == AnimationStatus.completed) {
          pulseController.forward(from: 0.0);
        }
      });

    tapActivationController = AnimationController(
      duration: tapActivationControllerDuration,
      vsync: this,
    )
      ..addListener(() {
        setState(() => transitionPercent = tapActivationController.value);
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.forward) {
          setState(() => state = OverlayStatusEnum.activating);
        } else if (status == AnimationStatus.completed) {
          stopAnimationControllers();
          //debugPrint('Actioned.');
          //discoveryController.stop();
          if (widget.childTapActionF != null) {
            /// arrive here when featured widget tapped while discovery overlay showing
            fca.gotit(widget.featureEnum);
            widget.discoveryController.triggerPlayButtonRebuild(widget.featureEnum);
            widget.childTapActionF!(context, widget.discoveryController);
            widget.discoveryController.stopPlay();
          }
        }
      });

    doubleTapActivationController = AnimationController(
      duration: doubleTapActivationControllerDuration,
      vsync: this,
    )
      ..addListener(() {
        setState(() => transitionPercent = doubleTapActivationController.value);
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.forward) {
          setState(() => state = OverlayStatusEnum.activating);
        } else if (status == AnimationStatus.completed) {
          stopAnimationControllers();
          //debugPrint('Actioned.');
          //discoveryController.stop();
          if (widget.childDoubleTapActionF != null) {
            widget.childDoubleTapActionF!(context, widget.discoveryController);
          }
        }
      });

    dismissController = AnimationController(
      duration: dismissControllerDuration,
      vsync: this,
    )
      ..addListener(() {
        setState(() => transitionPercent = dismissController.value);
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.forward) {
          setState(() => state = OverlayStatusEnum.dismissing);
        } else if (status == AnimationStatus.completed) {
          //FeatureDiscovery.dismiss(context);
          stopAnimationControllers();
          //debugPrint('Dismissed.');
          if (widget.overlayDismissedF != null) widget.overlayDismissedF!();
          /*
           * possibly move on to next feature
           */
          if (widget.autoPlay) {
            widget.discoveryController.playNext();
          }
        }
      });
  }

  void stopAnimationControllers() {
    openController.stop();
    pulseController.stop();
    tapActivationController.stop();
    doubleTapActivationController.stop();
    dismissController.stop();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    showOverlayIfActiveStep();
  }

  void showOverlayIfActiveStep() {
    Feature? activeEnum = widget.discoveryController.activeFeature();
    setState(() => showOverlay = (activeEnum != null && activeEnum == widget.featureEnum));

    if (activeEnum == widget.featureEnum) {
      openController.forward(from: 0.0);
    }
  }

  void tapActivate() {
    developer.log('activate');
    pulseController.stop();
    tapActivationController.forward(from: 0.0);
    stop();
  }

  void doubleTapActivate() {
    pulseController.stop();
    doubleTapActivationController.forward(from: 0.0);
    stop();
  }

  void dismiss(WhyDismissed theReason) {
    whyDismissed = theReason;
    developer.log('dismiss(${theReason.toString()})');
    setState(() => showOverlay = false);
    pulseController.stop();
    dismissController.forward(from: 0.0);
    //BLOC.triggerEditorFlowchartRefresh();
  }

  // build icon overlay, widget overlay, or show bottom sheet dlg
  @override
  Widget build(BuildContext context) {
    return buildOverlay(context);
  }

  Widget buildOverlay(BuildContext context) => widget.notAnIconFeature
      ? DiscoveryOverlay(
          showOverlay: showOverlay,
          buildOverlayF: (BuildContext context, Offset anchorPos, {Size? size}) => buildOverlayForWidget(anchorPos, size),
          parent: widget,
        )
      : DiscoveryOverlay(
          showOverlay: showOverlay,
          buildOverlayF: (BuildContext context, Offset anchorPos, {Size? size}) => buildOverlayForIcon(anchorPos, size),
          parent: widget,
        );

  Widget buildOverlayForIcon(Offset theAnchorPos, Size? size) {
    Offset anchorPos = theAnchorPos; //Offset(theAnchorPos.dx + size.width / 2, theAnchorPos.dy + size.height / 2);
    return Stack(
      children: <Widget>[
        Positioned(
          top: 10,
          width: fca.scrW,
          height: fca.scrH - 10,
          child: GestureDetector(
            onTap: () => dismiss(WhyDismissed.tappedOffDiscoveryShape),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(.5),
            ),
          ),
        ),
        PositionedCentred(
          pos: anchorPos,
          child: AnimatedOpacity(
            // If the Widget should be visible, animate to 1.0 (fully visible). If
            // the Widget should be hidden, animate to 0.0 (invisible).
            opacity: 1.0,
            duration: const Duration(milliseconds: 500),
            // The green box needs to be the child of the AnimatedOpacity
            child: Container(
              width: OVERLAY_RADIUS * 2,
              height: OVERLAY_RADIUS * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.overlayBgColor.withOpacity(widget.overlayOpacity),
              ),
            ),
          ),
        ),
//        PointOutBackground(
//          state: state,
//          transitionPercent: transitionPercent,
//          anchor: anchorPos,
//          color: widget.overlayBgColor,
//          bgOpacity: widget.overlayOpacity,
//          screenSize: screenSize,
//        ),
        PointOutContent(
          parent: widget,
          status: state,
          transitionPercent: transitionPercent,
          anchor: anchorPos,
          contentBuilder: widget.helpContentBuilder,
          contentSize: size,
          touchTargetRadius: 44.0,
          touchTargetToContentPadding: 20.0,
        ),
        _CircularPulse(
          state: state,
          transitionPercent: transitionPercent,
          anchor: anchorPos,
        ),
        _TouchTarget(
          state: state,
          transitionPercent: transitionPercent,
          anchor: anchorPos,
          bgColor: widget.overlayTargetBgColor,
          targetOpacity: widget.overlayTargetOpacity,
          onTap: tapActivate,
          onDoubleTap: doubleTapActivate,
        ),
        PositionedCentred(
          // icon clone
          pos: anchorPos,
          child: Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: tapActivate,
              onDoubleTap: doubleTapActivate,
              child: widget.childBuilder(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildOverlayForWidget(Offset anchorPos, Size? size) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () => dismiss(WhyDismissed.tappedOffDiscoveryShape),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.transparent,
          ),
        ),

        PositionedCentred(
          pos: anchorPos,
          child: Container(
            width: OVERLAY_RADIUS * 2,
            height: OVERLAY_RADIUS * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.overlayBgColor.withOpacity(widget.overlayOpacity),
            ),
          ),
        ),

//        PointOutBackground(
//          state: state,
//          transitionPercent: transitionPercent,
//          anchor: anchorPos,
//          color: widget.overlayBgColor,
//          bgOpacity: widget.overlayOpacity,
//          screenSize: screenSize,
//        ),
        PointOutContent(
          parent: widget,
          status: state,
          transitionPercent: transitionPercent,
          anchor: anchorPos,
          contentBuilder: widget.helpContentBuilder,
          contentSize: size,
          touchTargetRadius: 0.0,
          touchTargetToContentPadding: 20.0,
        ),
        if (!widget.notTappable)
          _RectangularPulse(
            state: state,
            transitionPercent: transitionPercent,
            targetOpacity: widget.overlayTargetOpacity,
            anchor: anchorPos,
            size: size,
            child: (context) => GestureDetector(
                child: widget.childBuilder(context),
                onTap: () {}, //tapActivate,
                onDoubleTap: () {} //doubleTapActivate,
                ),
          ),
        if (widget.notTappable)
          _RectangularBorder(
            borderColor: Colors.blue[900],
            borderThickness: 4,
            borderMargin: 10,
            state: state,
            anchor: anchorPos,
            size: size,
            child: (context) => widget.childBuilder(context),
          ),
      ],
    );
  }
}

class PointOutContent extends StatelessWidget {
  final FeaturedWidget? parent;
  final FeaturedWidgetHelpContentBuilder? contentBuilder;
  final OverlayStatusEnum? status;
  final double? transitionPercent;
  final Offset? anchor;
  final Size? contentSize;
  final double? touchTargetRadius;
  final double? touchTargetToContentPadding;

  const PointOutContent({
    this.parent,
    this.contentBuilder,
    this.status,
    this.transitionPercent,
    this.anchor,
    this.contentSize,
    this.touchTargetRadius,
    this.touchTargetToContentPadding,
    super.key,
  });

//  OverlayContentOrientationEnum getContentOrientation(Offset position) {
//    if (Responsive.isCloseToTopOrBottom(position, screenSize)) {
//      if (Responsive.isOnTopHalfOfScreen(position, screenSize)) {
//        return OverlayContentOrientationEnum.below;
//      } else {
//        return OverlayContentOrientationEnum.above;
//      }
//    } else {
//      if (Responsive.isOnTopHalfOfScreen(position, screenSize)) {
//        return OverlayContentOrientationEnum.above;
//      } else {
//        return OverlayContentOrientationEnum.below;
//      }
//    }
//  }

  double opacity() {
    switch (status) {
      case OverlayStatusEnum.closed:
        return 0.0;
      case OverlayStatusEnum.opening:
        final adjustedPercent = const Interval(0.6, 1.0, curve: Curves.easeOut).transform(transitionPercent!);
        return adjustedPercent;
      case OverlayStatusEnum.activating:
      case OverlayStatusEnum.dismissing:
        final adjustedPercent = const Interval(0.0, 0.4, curve: Curves.easeOut).transform(transitionPercent!);
        return 1.0 - adjustedPercent;
      default:
        return 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    late Offset contentPos;

    switch (parent!.overlayContentOrientation) {
      case OverlayContentOrientationEnum.above:
        contentPos = Offset(anchor!.dx - OVERLAY_RADIUS / 2, anchor!.dy - OVERLAY_RADIUS * 2 / 3);
        break;
      case OverlayContentOrientationEnum.belowCentre:
        contentPos = Offset(anchor!.dx - OVERLAY_RADIUS * 1 / 3, anchor!.dy + OVERLAY_RADIUS * 1 / 6);
        break;
      case OverlayContentOrientationEnum.belowRight:
        contentPos = Offset(anchor!.dx + OVERLAY_RADIUS * 1 / 6, anchor!.dy + OVERLAY_RADIUS * 1 / 6);
        break;
      case OverlayContentOrientationEnum.onLeftBelow:
        contentPos = Offset(anchor!.dx - OVERLAY_RADIUS * 5 / 6, anchor!.dy + OVERLAY_RADIUS / 6);
        break;
      case OverlayContentOrientationEnum.below:
        contentPos = Offset(anchor!.dx - OVERLAY_RADIUS * 2 / 3, anchor!.dy + OVERLAY_RADIUS * 1 / 6);
        break;
      case OverlayContentOrientationEnum.onRight:
        contentPos = Offset(anchor!.dx + OVERLAY_RADIUS / 6, anchor!.dy + OVERLAY_RADIUS * 1 / 3);
        break;
      case OverlayContentOrientationEnum.onRightAbove:
        contentPos = Offset(anchor!.dx + OVERLAY_RADIUS / 3, anchor!.dy - OVERLAY_RADIUS * 1 / 3);
        break;
      case OverlayContentOrientationEnum.onLeftAbove:
        contentPos = Offset(anchor!.dx - OVERLAY_RADIUS * 5 / 6, anchor!.dy - OVERLAY_RADIUS / 3);
        break;
    }

    return Positioned(
      left: contentPos.dx,
      top: contentPos.dy,
      child: Opacity(
        opacity: opacity(),
        child: Material(
          color: Colors.transparent, //bgColor,
          //child: Padding(
          //padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          child: contentBuilder!(context, parent),
          //),
        ),
      ),
    );
  }

//    @override
//  Widget build(BuildContext context) {
//    OverlayContentOrientationEnum relativeOrientation =
//        contentOrientation != null ? contentOrientation : getContentOrientation(anchor);
//    final contentOffsetMultiplier = relativeOrientation == OverlayContentOrientationEnum.below ? 1.0 : -1.0;
//    double contentY = anchor.dy + (contentOffsetMultiplier * (touchTargetRadius + 20.0));
//    double contentX = anchor.dx;
////    if (contentOrientation == OverlayContentOrientationEnum.onLeft)
////      contentX -= 300;
//    if (contentOrientation == OverlayContentOrientationEnum.onRight) {
//      contentX += contentSize.width + 30;
//      contentY = anchor.dy;
//    }
//    final contentFractionalOffset = contentOffsetMultiplier.clamp(-1.0, 0.0);
//
//    overlayContent.children.add(gotitButton);
//
//    return Positioned(
//      left: contentX,
//      top: discoverableTypeEnum == DiscoverableTypeEnum.iconOverlay
//          ? contentY
//          : Responsive.isOnTopHalfOfScreen(anchor, screenSize) ? anchor.dy + 50 : anchor.dy - 50,
//      child: discoverableTypeEnum == DiscoverableTypeEnum.iconOverlay
//          ? FractionalTranslation(
//              translation: Offset(0.0, contentFractionalOffset),
//              child: _positionedContent(),
//            )
//          : Container(child: _positionedContent()),
//    );
//  }

//  Widget _positionedContent() => Opacity(
//        opacity: opacity(),
//        child: Container(
//          width: screenSize.width,
//          child: Material(
//            color: Colors.transparent, //bgColor,
//            child: Padding(
//              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
//              child: overlayContent,
//            ),
//          ),
//        ),
//      );

}

class _CircularPulse extends StatelessWidget {
  final OverlayStatusEnum? state;
  final double? transitionPercent;
  final Offset? anchor;

  const _CircularPulse({
    this.state,
    this.transitionPercent,
    this.anchor,
  });

  double radius() {
    switch (state) {
      case OverlayStatusEnum.pulsing:
        double expandedPercent;
        if (transitionPercent! >= 0.3 && transitionPercent! <= 0.8) {
          expandedPercent = (transitionPercent! - 0.3) / 0.5;
        } else {
          expandedPercent = 0.0;
        }

        return 44.0 + (35.0 * expandedPercent);
      case OverlayStatusEnum.dismissing:
      case OverlayStatusEnum.activating:
        return 0.0;
      default:
        return 0.0;
    }
  }

  double opacity() {
    switch (state) {
      case OverlayStatusEnum.pulsing:
        final percentOpaque = 1.0 - ((transitionPercent!.clamp(0.3, 0.8) - 0.3) / 0.5);
        return (percentOpaque * 0.75).clamp(0.0, 1.0);
      case OverlayStatusEnum.activating:
      case OverlayStatusEnum.dismissing:
        return 0.0;
      default:
        return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (state == OverlayStatusEnum.closed) {
      return Container();
    }

    return PositionedCentred(
      pos: anchor,
      child: Container(
        width: radius() * 2,
        height: radius() * 2,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent, //Colors.white.withOpacity(opacity()),
        ),
      ),
    );
  }
}

class _RectangularPulse extends StatelessWidget {
  final OverlayStatusEnum? state;
  final double? transitionPercent;
  final double? targetOpacity;
  final Offset? anchor;
  final Size? size;
  final WidgetBuilder? child;

  const _RectangularPulse({
    this.state,
    this.transitionPercent,
    this.targetOpacity,
    this.anchor,
    this.size,
    this.child,
  });

  double inflation() {
    return 6.0;
  }

  double? opacity() {
    if (targetOpacity != null) return targetOpacity;
    switch (state) {
      case OverlayStatusEnum.pulsing:
        final percentOpaque = 1.0 - ((transitionPercent!.clamp(0.3, 0.8) - 0.3) / 0.5);
        return (percentOpaque * 0.75).clamp(0.5, 1.0);
      case OverlayStatusEnum.activating:
      case OverlayStatusEnum.dismissing:
        return 0.0;
      default:
        return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetBuilder? builder = child;

    if (state == OverlayStatusEnum.closed) {
      return builder!(context);
    }

    double inflateBy = inflation();

    return Positioned(
      top: anchor!.dy - inflateBy,
      left: anchor!.dx - inflateBy,
      width: size!.width + inflateBy * 2,
      height: size!.height + inflateBy * 2,
      child: Opacity(
        opacity: opacity()!,
        child: Container(
          width: size!.width + inflateBy * 2,
          height: size!.height + inflateBy * 2,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.white, width: 3.0, style: BorderStyle.solid),
            //color: Colors.orange, //Colors.white.withOpacity(opacity()),
          ),
          child: builder!(context),
        ),
      ),
    );
  }
}

class _RectangularBorder extends StatelessWidget {
  final OverlayStatusEnum? state;
  final Offset? anchor;
  final Size? size;
  final WidgetBuilder? child;
  final Color? borderColor;
  final double? borderThickness;
  final double? borderMargin;

  const _RectangularBorder({this.state, this.anchor, this.size, this.child, this.borderColor, this.borderThickness, this.borderMargin});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: anchor!.dy - borderMargin! - borderThickness!,
      left: anchor!.dx - borderMargin! - borderThickness!,
      width: size!.width + borderMargin! * 2 + borderThickness! * 2,
      height: size!.height + borderMargin! * 2 + borderThickness! * 2,
        child: Container(
          decoration: DottedDecoration(
            fillColor: Colors.transparent,
            strokeWidth: borderThickness!,
            borderColor: borderColor!,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          width: size!.width,
          height: size!.height,
          color: Colors.transparent,
      ),
    );
  }
}

class _TouchTarget extends StatelessWidget {
  final OverlayStatusEnum? state;
  final double? transitionPercent;
  final Offset? anchor;
  final Color? bgColor;
  final double? targetOpacity;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;

  const _TouchTarget({
    this.state,
    this.transitionPercent,
    this.anchor,
    this.bgColor,
    this.targetOpacity,
    this.onTap,
    this.onDoubleTap,
  });

  double radius() {
    switch (state) {
      case OverlayStatusEnum.closed:
        return 0.0;
      case OverlayStatusEnum.opening:
        return 20 + (24.0 * transitionPercent!);
      case OverlayStatusEnum.pulsing:
        double expandedPercent;
        if (transitionPercent! < 0.3) {
          expandedPercent = transitionPercent! / 0.3;
        } else if (transitionPercent! < 0.6) {
          expandedPercent = 1.0 - ((transitionPercent! - 0.3) / 0.3);
        } else {
          expandedPercent = 0.0;
        }

        return 44.0 + (20.0 * expandedPercent);
      case OverlayStatusEnum.activating:
      case OverlayStatusEnum.dismissing:
        return 20 + (24.0 * (1.0 - transitionPercent!));
      default:
        return 44.0;
    }
  }

  double? opacity() {
    if (targetOpacity != null) return targetOpacity;

    switch (state) {
      case OverlayStatusEnum.opening:
        return const Interval(0.0, 0.3, curve: Curves.easeOut).transform(transitionPercent!);
      case OverlayStatusEnum.activating:
      case OverlayStatusEnum.dismissing:
        return 1.0 - const Interval(0.7, 1.0, curve: Curves.easeOut).transform(transitionPercent!);
      default:
        return .7;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PositionedCentred(
      pos: anchor,
      child: SizedBox(
        width: 2 * radius(),
        height: 2 * radius(),
        child: Opacity(
          opacity: opacity()!,
          child: GestureDetector(
            onDoubleTap: onDoubleTap,
            child: RawMaterialButton(
                shape: const CircleBorder(),
                fillColor: bgColor,
                child: Opacity(
                  opacity: 1.0,
                  child: Container(),
                ),
                onPressed: () {
                  onTap!();
                }),
          ),
        ),
      ),
    );
  }
}

class PositionedCentred extends StatelessWidget {
  final Offset? pos;
  final Widget? child;

  const PositionedCentred({this.pos, this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: pos!.dy,
      left: pos!.dx,
      child: FractionalTranslation(
        translation: const Offset(-0.5, -0.5),
        child: child,
      ),
    );
  }
}

enum OverlayStatusEnum {
  closed,
  opening,
  pulsing,
  activating,
  dismissing,
}

enum OverlayContentOrientationEnum { below, belowCentre, belowRight, above, onLeftAbove, onLeftBelow, onRight, onRightAbove }

const double OVERLAY_RADIUS = 400;
const Duration openControllerDuration = Duration(milliseconds: 1000);
const Duration pulseControllerDuration = Duration(milliseconds: 1000);
const Duration tapActivationControllerDuration = Duration(milliseconds: 250);
const Duration doubleTapActivationControllerDuration = Duration(milliseconds: 250);
const Duration dismissControllerDuration = Duration(milliseconds: 250);
