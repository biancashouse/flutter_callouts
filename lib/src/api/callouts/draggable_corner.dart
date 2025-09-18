import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_callouts/src/api/callouts/callout_config.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

Timer? _debounce;

class DraggableCorner_OP extends StatelessWidget {
  final Alignment alignment;
  final double thickness;
  final CalloutConfig parent;
  final Color color;
  final bool wrapInPointerInterceptor;

  const DraggableCorner_OP({required this.alignment,
    required this.thickness,
    required this.parent,
    required this.color, required this.wrapInPointerInterceptor,
    super.key});

  BorderRadius getBorderRadius(Alignment alignment) {
    if (alignment == Alignment.topLeft) {
      return BorderRadius.only(
        topLeft: Radius.circular(thickness / 2),
      );
    } else if (alignment == Alignment.topRight) {
      return BorderRadius.only(
        topRight: Radius.circular(thickness / 2),
      );
    } else if (alignment == Alignment.bottomLeft) {
      return BorderRadius.only(
        bottomLeft: Radius.circular(thickness / 2),
      );
    } else if (alignment == Alignment.bottomRight) {
      return BorderRadius.only(
        bottomRight: Radius.circular(thickness / 2),
      );
    }

    return const BorderRadius.only(
      topLeft: Radius.zero,
    );
  }

  @override
  Widget build(BuildContext context) {
    final soY = parent.followScroll ? parent.scrollOffsetY() : 0.0;
    final soX = parent.followScroll ? parent.scrollOffsetX() : 0.0;
    Offset pos = _pos(-soX,-soY);
    return Positioned(
      top: pos.dy,
      left: pos.dx,
      child: Listener(
        onPointerMove: (PointerMoveEvent event) {
          double newTop = event.position.dy;
          double newLeft = event.position.dx;
          var deltaX = event.delta.dx;
          var deltaY = event.delta.dy;
          if (alignment == Alignment.topLeft) {
            if (deltaX < 0 ||
                parent.calloutW! + deltaX >= (parent.minWidth ?? 30)) {
              parent.setLeft(newLeft+soX);
              parent.calloutW = parent.calloutW! - deltaX;
            }
            if (deltaY < 0 ||
                parent.calloutH! + deltaY >= (parent.minHeight ?? 30)) {
              parent.setTop(newTop+soY);
              parent.calloutH = parent.calloutH! - deltaY;
            }
          } else if (alignment == Alignment.topRight) {
            if (parent.calloutW! + deltaX < (parent.minWidth ?? 30)) {
              parent.calloutW = parent.minWidth ?? 30;
            } else {
              parent.calloutW = parent.calloutW! + deltaX;
            }
            if (deltaY < 0 ||
                parent.calloutH! + deltaY >= (parent.minHeight ?? 30)) {
              parent.setTop(newTop+soY);
              parent.calloutH = parent.calloutH! - deltaY;
            }
          } else if (alignment == Alignment.bottomLeft) {
            if (deltaX < 0 ||
                parent.calloutW! + deltaX >= (parent.minWidth ?? 30)) {
              parent.setLeft(newLeft);
              parent.calloutW = parent.calloutW! - deltaX;
            }
            if (parent.calloutH! + deltaY < (parent.minHeight ?? 30)) {
              parent.calloutH = parent.minHeight ?? 30;
            } else {
              parent.calloutH = parent.calloutH! + deltaY;
            }
          } else if (alignment == Alignment.bottomRight) {
            if (parent.calloutW! + deltaX < (parent.minWidth ?? 30)) {
              parent.calloutW = parent.minWidth ?? 30;
            } else {
              parent.calloutW = parent.calloutW! + deltaX;
            }
            if (parent.calloutH! + deltaY < (parent.minHeight ?? 30)) {
              parent.calloutH = parent.minHeight ?? 30;
            } else {
              parent.calloutH = parent.calloutH! + deltaY;
            }
          }
          // parent.calloutSize = Size(parent.calloutW!, parent.calloutH!);
          // fca.logger.i('new height: ${parent.calloutH!}');
          parent.movedOrResizedNotifier?.value++;
          parent.rebuild(() {
            if (_debounce?.isActive ?? false) _debounce?.cancel();
            // Set up a new debounce timer
            _debounce = Timer(const Duration(milliseconds: 200), () async {
              parent.onResizeF?.call(Size(parent.calloutW!, parent.calloutH!));
            });
          });
        },
        child: PointerInterceptor(
          intercepting: wrapInPointerInterceptor,
          child: Container(
            width: thickness,
            height: thickness,
            decoration: BoxDecoration(
              color: color,
              borderRadius: getBorderRadius(alignment),
            ),
          ),
        ),
      ),
    );
  }

  void moved(Offset newPos, Offset delta) {
    double newTop = newPos.dy;
    double newLeft = newPos.dx;
    var deltaX = delta.dx;
    var deltaY = delta.dy;
    if (alignment == Alignment.topLeft) {
      if (deltaX < 0 || parent.calloutW! + deltaX >= (parent.minWidth ?? 30)) {
        parent.setLeft(newLeft);
        parent.calloutW = parent.calloutW! - deltaX;
      }
      if (deltaY < 0 || parent.calloutH! + deltaY >= (parent.minHeight ?? 30)) {
        parent.setTop(newTop);
        parent.calloutH = parent.calloutH! - deltaY;
      }
    } else if (alignment == Alignment.topRight) {
      if (parent.calloutW! + deltaX < (parent.minWidth ?? 30)) {
        parent.calloutW = parent.minWidth ?? 30;
      } else {
        parent.calloutW = parent.calloutW! + deltaX;
      }
      if (deltaY < 0 || parent.calloutH! + deltaY >= (parent.minHeight ?? 30)) {
        parent.setTop(newTop);
        parent.calloutH = parent.calloutH! - deltaY;
      }
    } else if (alignment == Alignment.bottomLeft) {
      if (deltaX < 0 || parent.calloutW! + deltaX >= (parent.minWidth ?? 30)) {
        parent.setLeft(newLeft);
        parent.calloutW = parent.calloutW! - deltaX;
      }
      if (parent.calloutH! + deltaY < (parent.minHeight ?? 30)) {
        parent.calloutH = parent.minHeight ?? 30;
      } else {
        parent.calloutH = parent.calloutH! + deltaY;
      }
    } else if (alignment == Alignment.bottomRight) {
      if (parent.calloutW! + deltaX < (parent.minWidth ?? 30)) {
        parent.calloutW = parent.minWidth ?? 30;
      } else {
        parent.calloutW = parent.calloutW! + deltaX;
      }
      if (parent.calloutH! + deltaY < (parent.minHeight ?? 30)) {
        parent.calloutH = parent.minHeight ?? 30;
      } else {
        parent.calloutH = parent.calloutH! + deltaY;
      }
    }
    // parent.calloutSize = Size(parent.calloutW!, parent.calloutH!);
    // fca.logger.i('new height: ${parent.calloutH!}');
    parent.movedOrResizedNotifier?.value++;
    parent.rebuild(() {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      // Set up a new debounce timer
      _debounce = Timer(const Duration(milliseconds: 200), () async {
        parent.onResizeF?.call(Size(parent.calloutW!, parent.calloutH!));
      });
    });
  }

  Offset _pos(soX,soY) {
    Rect calloutRect = Rect.fromLTWH(
        parent.left!, parent.top!, parent.calloutW!, parent.calloutH!)
        .translate(soX, soY);
    if (alignment == Alignment.topLeft) {
      return calloutRect.topLeft.translate(-thickness, -thickness);
    } else if (alignment == Alignment.topRight) {
      return calloutRect.topRight.translate(0, -thickness);
    } else if (alignment == Alignment.bottomLeft) {
      return calloutRect.bottomLeft.translate(-thickness, 0);
    } else if (alignment == Alignment.bottomRight) {
      return calloutRect.bottomRight.translate(0, 0);
    } else {
      throw ('Corner _pos() unexpected alignment!');
    }
  }
}
