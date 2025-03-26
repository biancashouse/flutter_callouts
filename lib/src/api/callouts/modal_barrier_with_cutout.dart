// flutter's ModalBarrier cloned and ColoredBox replaced with cutout painter

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

/// A widget that modifies the size of the [SemanticsNode.rect] created by its
/// child widget.
///
/// It clips the focus in potentially four directions based on the
/// specified [EdgeInsets].
///
/// The size of the accessibility focus is adjusted based on value changes
/// inside the given [ValueNotifier].
///
/// See also:
///
///  * [ModalBarrierWithCutout], which utilizes this widget to adjust the barrier focus
/// size based on the size of the content layer rendered on top of it.
class _SemanticsClipper extends SingleChildRenderObjectWidget {
  /// creates a [_SemanticsClipper] that updates the size of the
  /// [SemanticsNode.rect] of its child based on the value inside the provided
  /// [ValueNotifier], or a default value of [EdgeInsets.zero].
  const _SemanticsClipper({
    super.child,
    required this.clipDetailsNotifier,
  });

  /// The [ValueNotifier] whose value determines how the child's
  /// [SemanticsNode.rect] should be clipped in four directions.
  final ValueNotifier<EdgeInsets> clipDetailsNotifier;

  @override
  _RenderSemanticsClipper createRenderObject(BuildContext context) {
    return _RenderSemanticsClipper(
      clipDetailsNotifier: clipDetailsNotifier,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderSemanticsClipper renderObject) {
    renderObject.clipDetailsNotifier = clipDetailsNotifier;
  }
}

/// Updates the [SemanticsNode.rect] of its child based on the value inside
/// provided [ValueNotifier].
class _RenderSemanticsClipper extends RenderProxyBox {
  /// Creates a [RenderProxyBox] that Updates the [SemanticsNode.rect] of its child
  /// based on the value inside provided [ValueNotifier].
  _RenderSemanticsClipper({
    required ValueNotifier<EdgeInsets> clipDetailsNotifier,
    RenderBox? child,
  })  : _clipDetailsNotifier = clipDetailsNotifier,
        super(child);

  ValueNotifier<EdgeInsets> _clipDetailsNotifier;

  /// The getter and setter retrieves / updates the [ValueNotifier] associated
  /// with this clipper.
  ValueNotifier<EdgeInsets> get clipDetailsNotifier => _clipDetailsNotifier;

  set clipDetailsNotifier(ValueNotifier<EdgeInsets> newNotifier) {
    if (_clipDetailsNotifier == newNotifier) {
      return;
    }
    if (attached) {
      _clipDetailsNotifier.removeListener(markNeedsSemanticsUpdate);
    }
    _clipDetailsNotifier = newNotifier;
    _clipDetailsNotifier.addListener(markNeedsSemanticsUpdate);
    markNeedsSemanticsUpdate();
  }

  @override
  Rect get semanticBounds {
    final EdgeInsets clipDetails = _clipDetailsNotifier.value;
    final Rect originalRect = super.semanticBounds;
    final Rect clippedRect = Rect.fromLTRB(
      originalRect.left + clipDetails.left,
      originalRect.top + clipDetails.top,
      originalRect.right - clipDetails.right,
      originalRect.bottom - clipDetails.bottom,
    );
    return clippedRect;
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    clipDetailsNotifier.addListener(markNeedsSemanticsUpdate);
  }

  @override
  void detach() {
    clipDetailsNotifier.removeListener(markNeedsSemanticsUpdate);
    super.detach();
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config.isSemanticBoundary = true;
  }
}

/// A widget that prevents the user from interacting with widgets behind itself.
///
/// The modal barrier is the scrim that is rendered behind each route, which
/// generally prevents the user from interacting with the route below the
/// current route, and normally partially obscures such routes.
///
/// For example, when a dialog is on the screen, the page below the dialog is
/// usually darkened by the modal barrier.
///
/// See also:
///
///  * [ModalRoute], which indirectly uses this widget.
///  * [AnimatedModalBarrier], which is similar but takes an animated [color]
///    instead of a single color value.
class ModalBarrierWithCutout extends StatelessWidget {
  /// Creates a widget that blocks user interaction.
  const ModalBarrierWithCutout({
    super.key,
    required this.color,
    required this.opacity,
    required this.cutoutRect,
    this.cutoutPadding,
    this.dismissible = true,
    this.onDismiss,
    this.semanticsLabel,
    this.barrierSemanticsDismissible = true,
    this.clipDetailsNotifier,
    this.semanticsOnTapHint,
  });

  /// If non-null, fill the barrier with this color.
  ///
  /// See also:
  ///
  ///  * [ModalRoute.barrierColor], which controls this property for the
  ///    [ModalBarrierWithCutout] built by [ModalRoute] pages.
  final Color color;
  final double opacity;
  final Rect cutoutRect;
  final double? cutoutPadding;

  /// Specifies if the barrier will be dismissed when the user taps on it.
  ///
  /// If true, and [onDismiss] is non-null, [onDismiss] will be called,
  /// otherwise the current route will be popped from the ambient [Navigator].
  ///
  /// If false, tapping on the barrier will do nothing.
  ///
  /// See also:
  ///
  ///  * [ModalRoute.barrierDismissible], which controls this property for the
  ///    [ModalBarrierWithCutout] built by [ModalRoute] pages.
  final bool dismissible;

  /// {@template flutter.widgets.ModalBarrier.onDismiss}
  /// Called when the barrier is being dismissed.
  ///
  /// If non-null [onDismiss] will be called in place of popping the current
  /// route. It is up to the callback to handle dismissing the barrier.
  ///
  /// If null, the ambient [Navigator]'s current route will be popped.
  ///
  /// This field is ignored if [dismissible] is false.
  /// {@endtemplate}
  final VoidCallback? onDismiss;

  /// Whether the modal barrier semantics are included in the semantics tree.
  ///
  /// See also:
  ///
  ///  * [ModalRoute.semanticsDismissible], which controls this property for
  ///    the [ModalBarrierWithCutout] built by [ModalRoute] pages.
  final bool? barrierSemanticsDismissible;

  /// Semantics label used for the barrier if it is [dismissible].
  ///
  /// The semantics label is read out by accessibility tools (e.g. TalkBack
  /// on Android and VoiceOver on iOS) when the barrier is focused.
  ///
  /// See also:
  ///
  ///  * [ModalRoute.barrierLabel], which controls this property for the
  ///    [ModalBarrierWithCutout] built by [ModalRoute] pages.
  final String? semanticsLabel;

  /// {@template flutter.widgets.ModalBarrier.clipDetailsNotifier}
  /// Contains a value of type [EdgeInsets] that specifies how the
  /// [SemanticsNode.rect] of the widget should be clipped.
  ///
  /// See also:
  ///
  ///  * [_SemanticsClipper], which utilizes the value inside to update the
  /// [SemanticsNode.rect] for its child.
  /// {@endtemplate}
  final ValueNotifier<EdgeInsets>? clipDetailsNotifier;

  /// {@macro flutter.material.ModalBottomSheetRoute.barrierOnTapHint}
  final String? semanticsOnTapHint;

  @override
  Widget build(BuildContext context) {
    assert(!dismissible ||
        semanticsLabel == null ||
        debugCheckHasDirectionality(context));
    final bool platformSupportsDismissingBarrier;
    switch (defaultTargetPlatform) {
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        platformSupportsDismissingBarrier = false;
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        platformSupportsDismissingBarrier = true;
    }
    final bool semanticsDismissible =
        dismissible && platformSupportsDismissingBarrier;
    final bool modalBarrierSemanticsDismissible =
        barrierSemanticsDismissible ?? semanticsDismissible;

    void handleDismiss() {
      if (dismissible) {
        if (onDismiss != null) {
          onDismiss!();
        } else {
          Navigator.maybePop(context);
        }
      } else {
        SystemSound.play(SystemSoundType.alert);
      }
    }

    Widget barrier = Semantics(
      onTapHint: semanticsOnTapHint,
      onTap:
          semanticsDismissible && semanticsLabel != null ? handleDismiss : null,
      onDismiss:
          semanticsDismissible && semanticsLabel != null ? handleDismiss : null,
      label: semanticsDismissible ? semanticsLabel : null,
      textDirection: semanticsDismissible && semanticsLabel != null
          ? Directionality.of(context)
          : null,
      child: MouseRegion(
        cursor: SystemMouseCursors.basic,
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Opacity(
            opacity: opacity,
            child: CustomPaint(
              painter: BarrierCutoutPainter(
                barrierColor: color,
                target: cutoutPadding != null
                    ? cutoutRect.inflate(cutoutPadding!)
                    : cutoutRect,
              ),
            ),
          ),
        ),
      ),
    );

    // Developers can set [dismissible: true] and [barrierSemanticsDismissible: true]
    // to allow assistive technology users to dismiss a modal BottomSheet by
    // tapping on the Scrim focus.
    // On iOS, some modal barriers are not dismissible in accessibility mode.
    final bool excluding =
        !semanticsDismissible || !modalBarrierSemanticsDismissible;

    if (!excluding && clipDetailsNotifier != null) {
      barrier = _SemanticsClipper(
        clipDetailsNotifier: clipDetailsNotifier!,
        child: barrier,
      );
    }

    return BlockSemantics(
      child: ExcludeSemantics(
        excluding: excluding,
        child: _ModalBarrierGestureDetector(
          onDismiss: handleDismiss,
          child: barrier,
        ),
      ),
    );
  }
}

/// A widget that prevents the user from interacting with widgets behind itself,
/// and can be configured with an animated color value.
///
/// The modal barrier is the scrim that is rendered behind each route, which
/// generally prevents the user from interacting with the route below the
/// current route, and normally partially obscures such routes.
///
/// For example, when a dialog is on the screen, the page below the dialog is
/// usually darkened by the modal barrier.
///
/// This widget is similar to [ModalBarrierWithCutout] except that it takes an animated
/// [color] instead of a single color.
///
/// See also:
///
///  * [ModalRoute], which uses this widget.

// Recognizes tap down by any pointer button.
//
// It is similar to [TapGestureRecognizer.onTapDown], but accepts any single
// button, which means the gesture also takes parts in gesture arenas.
class _AnyTapGestureRecognizer extends BaseTapGestureRecognizer {
  _AnyTapGestureRecognizer();

  VoidCallback? onAnyTapUp;

  @protected
  @override
  bool isPointerAllowed(PointerDownEvent event) {
    if (onAnyTapUp == null) {
      return false;
    }
    return super.isPointerAllowed(event);
  }

  @protected
  @override
  void handleTapDown({PointerDownEvent? down}) {
    // Do nothing.
  }

  @protected
  @override
  void handleTapUp({PointerDownEvent? down, PointerUpEvent? up}) {
    if (onAnyTapUp != null) {
      invokeCallback('onAnyTapUp', onAnyTapUp!);
    }
  }

  @protected
  @override
  void handleTapCancel(
      {PointerDownEvent? down, PointerCancelEvent? cancel, String? reason}) {
    // Do nothing.
  }

  @override
  String get debugDescription => 'any tap';
}

class _AnyTapGestureRecognizerFactory
    extends GestureRecognizerFactory<_AnyTapGestureRecognizer> {
  const _AnyTapGestureRecognizerFactory({this.onAnyTapUp});

  final VoidCallback? onAnyTapUp;

  @override
  _AnyTapGestureRecognizer constructor() => _AnyTapGestureRecognizer();

  @override
  void initializer(_AnyTapGestureRecognizer instance) {
    instance.onAnyTapUp = onAnyTapUp;
  }
}

// A GestureDetector used by ModalBarrier. It only has one callback,
// [onAnyTapDown], which recognizes tap down unconditionally.
class _ModalBarrierGestureDetector extends StatelessWidget {
  const _ModalBarrierGestureDetector({
    required this.child,
    required this.onDismiss,
  });

  /// The widget below this widget in the tree.
  /// See [RawGestureDetector.child].
  final Widget child;

  /// Immediately called when an event that should dismiss the modal barrier
  /// has happened.
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final Map<Type, GestureRecognizerFactory> gestures =
        <Type, GestureRecognizerFactory>{
      _AnyTapGestureRecognizer:
          _AnyTapGestureRecognizerFactory(onAnyTapUp: onDismiss),
    };

    return RawGestureDetector(
      gestures: gestures,
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}


class BarrierCutoutPainter extends CustomPainter {
  Color barrierColor;
  Rect target;

  BarrierCutoutPainter({
    required this.target,
    required this.barrierColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint();
    backgroundPaint.blendMode = BlendMode.multiply;
    backgroundPaint.color = barrierColor;
    // // Step 1: Draw the background:
    // canvas.drawRect(Rect.fromLTWH(0, 0, size.width, target.top), backgroundPaint);
    // canvas.drawRect(Rect.fromLTWH(0, 0, target.left, size.height), backgroundPaint);
    // canvas.drawRect(Rect.fromLTWH(target.left + target.width, 0, target.left, size.height), backgroundPaint);
    // canvas.drawRect(Rect.fromLTWH(0, target.top + target.height, size.width, target.top), backgroundPaint);

    if (target.width == 0.0 || target.height == 0.0) return;

    // 1
    if (target.left > 0 && target.top > 0)
      canvas.drawRect(
        Rect.fromLTWH(
          0,
          0,
          target.left,
          target.top,
        ),
        backgroundPaint,
      );
    // 2
    if (target.top > 0)
      canvas.drawRect(
          Rect.fromLTWH(
            target.left,
            0,
            target.width,
            target.top,
          ),
          backgroundPaint);
    // 3
    if (size.width > target.left + target.width && target.top > 0)
      canvas.drawRect(
          Rect.fromLTWH(
            target.left + target.width,
            0,
            size.width - target.left - target.width,
            target.top,
          ),
          backgroundPaint);
    // 4
    if (target.left > 0)
      canvas.drawRect(
          Rect.fromLTWH(
            0,
            target.top,
            target.left,
            target.height,
          ),
          backgroundPaint);
    // 5 is the cutout
    // 6
    if (size.width > target.left + target.width)
      canvas.drawRect(
          Rect.fromLTWH(
              target.left + target.width,
              target.top,
              size.width - target.left - target.width,
              target.height
          ),
          backgroundPaint);
    // 7
    if (target.left > 0 && size.height > target.top + target.height)
      canvas.drawRect(
          Rect.fromLTWH(
            0,
            target.top + target.height,
            target.left,
            size.width - target.top - target.height,
          ),
          backgroundPaint);
    // 8
    if (size.height > target.top + target.height)
      canvas.drawRect(
          Rect.fromLTWH(
            target.left,
            target.top + target.height,
            target.width,
            size.height - target.top - target.height,
          ),
          backgroundPaint);
    // 9
    if (size.width > target.left + target.width &&
        size.height > target.top + target.height)
      canvas.drawRect(
          Rect.fromLTWH(
            target.left + target.width,
            target.top + target.height,
            size.width - target.left - target.width,
            size.height - target.top - target.height,
          ),
          backgroundPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
