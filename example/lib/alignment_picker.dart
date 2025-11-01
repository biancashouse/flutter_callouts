import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

class AlignmentPicker extends StatefulWidget {
  final ValueChanged<Alignment> onChanged;
  final Alignment initialAlignment;
  final GlobalKey gk;

  const AlignmentPicker({
    super.key,
    required this.onChanged,
    this.initialAlignment = Alignment.center,
    required this.gk,
  });

  @override
  State<AlignmentPicker> createState() => _AlignmentPickerState();
}

class _AlignmentPickerState extends State<AlignmentPicker> {
  Alignment? _currentAlignment;
  Offset? _localPosition;
  final double targetW = 300.0;
  final double targetH = 200.0;

  @override
  void initState() {
    super.initState();
    _currentAlignment = widget.initialAlignment;
    // Calculate initial local position from initial Alignment
    _localPosition = _alignmentToLocalPosition(_currentAlignment!, targetW, targetH);

    // fca.afterNextBuildDo((){
    //   fca.showOverlay(
    //     calloutConfig: CalloutConfig(
    //       cId: 'callout-needing-measuring',
    //       initialCalloutW: 50,
    //       initialCalloutH: 60,
    //       initialTargetAlignment: Alignment(1.5, 0.0),
    //       // targetPointerType: TargetPointerType.thin_line(),
    //       //-widget.initialAlignment,
    //       scrollControllerName: null,
    //       // finalSeparation: 90,
    //     ),
    //     calloutContent: Container(
    //       width: 40,
    //       height: 40,
    //       color: Colors.blue,
    //       child: const Center(child: Text('Child')),
    //     ),
    //     targetGkF: () => widget.gk,
    //   );
    // });
  }

  void showCallout() {
    fca.dismiss('callout');
    fca.showOverlay(
      calloutConfig: CalloutConfig(
        cId: 'callout',
        // initialCalloutW: 200,
        // initialCalloutH: 200,
        initialTargetAlignment: _currentAlignment!,
        //widget.initialAlignment,
        targetPointerType: TargetPointerType.thin_line(),
        //-widget.initialAlignment,
        scrollControllerName: null,
        finalSeparation: 0,
      ),
      calloutContent: Container(
        width: 40,
        height: 40,
        color: Colors.pink.shade300,
        child: const Center(child: Text('Child')),
      ),
      targetGkF: () => widget.gk,
    );
}

  // Converts a local position (Offset) inside the square to an Alignment.
  Alignment _localPositionToAlignment(Offset localPosition, double size) {
    // Local position (0, 0) is top-left.
    // Alignment (-1, -1) is top-left, (1, 1) is bottom-right, (0, 0) is center.
    // x value: maps [0, size] to [-1.0, 1.0]
    // y value: maps [0, size] to [-1.0, 1.0]

    final double x = (localPosition.dx / size) * 2.0 - 1.0;
    final double y = (localPosition.dy / size) * 2.0 - 1.0;

    // Clamp the values to the [-1.0, 1.0] range
    return Alignment(x.clamp(-1.0, 1.0), y.clamp(-1.0, 1.0));
  }

  // Converts an Alignment to a local position (Offset) inside the square.
  Offset _alignmentToLocalPosition(Alignment alignment, double width, double height) {
    // x value: maps [-1.0, 1.0] to [0, size]
    // y value: maps [-1.0, 1.0] to [0, size]
    final double dx = (alignment.x + 1.0) * width/2;
    final double dy = (alignment.y + 1.0) * height/2;
    return Offset(dx, dy);
  }

  void _handleHover(Offset localPos, double size) {
    // Get the local position of the pointer within the widget
    final Offset localPosition = localPos;

    // Check if the pointer is inside the square boundaries
    if (localPosition.dx >= 0 &&
        localPosition.dx <= size &&
        localPosition.dy >= 0 &&
        localPosition.dy <= size) {
      final newAlignment = _localPositionToAlignment(localPosition, size);

      if (newAlignment != _currentAlignment) {
        setState(() {
          _currentAlignment = newAlignment;
          _localPosition = localPosition;
        });
        widget.onChanged(newAlignment);
      }
    }
  }

  void _onMoved(GlobalKey gk, Offset globalPos) {
    // Get the local position of the pointer within the widget
    var r = widget.gk.currentContext?.findRenderObject() as RenderBox?;
    if (r == null) return;
    final Offset localPosition = r.globalToLocal(globalPos);

    final newAlignment = r.paintBounds.pointToAlignment(localPosition);

    if (newAlignment != _currentAlignment) {
      setState(() {
        _currentAlignment = newAlignment;
        _localPosition = localPosition;
        showCallout();
      });
      widget.onChanged(newAlignment);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          MouseRegion(
            onHover: (event) {
              // _handleHoverndleHover(event.localPosition, widget.size);
              print('event.position: ${event.position}, event.localPosition: ${event.localPosition}');
              _onMoved(widget.gk, event.position);
            },
            child: Container(width: 700, height: 500, color: Colors.lime),
          ),
          IgnorePointer(child: targetWidget()),
        ],
      ),
    );
  }

  Widget targetWidget() => Container(
    key: widget.gk,
    width: targetW,
    height: targetH,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey, width: 2.0),
    ),
    child: CustomPaint(
      painter: _AlignmentIndicatorPainter(
        currentAlignment: _currentAlignment!,
        localPosition: _localPosition!,
      ),
    ),
  );
}

// ------------------------------------------------------------------
class _AlignmentIndicatorPainter extends CustomPainter {
  final Alignment currentAlignment;
  final Offset localPosition;

  _AlignmentIndicatorPainter({
    required this.currentAlignment,
    required this.localPosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueGrey.shade200
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);

    // Draw grid lines
    canvas.drawLine(
      Offset(0, center.dy),
      Offset(size.width, center.dy),
      paint,
    ); // Horizontal center
    canvas.drawLine(
      Offset(center.dx, 0),
      Offset(center.dx, size.height),
      paint,
    ); // Vertical center

    // Draw current Alignment marker
    final indicatorPaint = Paint()
      ..color = Colors.blue.shade700
      ..style = PaintingStyle.fill;

    // Draw the circle at the local position
    canvas.drawCircle(localPosition, 8.0, indicatorPaint);

    // Draw crosshair on the indicator
    final crosshairPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.5;

    // Horizontal line segment
    canvas.drawLine(
      localPosition.translate(-5, 0),
      localPosition.translate(5, 0),
      crosshairPaint,
    );
    // Vertical line segment
    canvas.drawLine(
      localPosition.translate(0, -5),
      localPosition.translate(0, 5),
      crosshairPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _AlignmentIndicatorPainter oldDelegate) {
    return oldDelegate.currentAlignment != currentAlignment;
  }
}
