import 'package:flutter/material.dart';

class CircularCutoutBarrier extends StatelessWidget {
  final Widget child; // Your main content behind the barrier
  final Color barrierColor;
  final Offset circleCenter; // Center of the circular cutout
  final double circleRadius; // Radius of the circular cutout

  const CircularCutoutBarrier({
    Key? key,
    required this.child,
    this.barrierColor = Colors.black54, // Default semi-transparent black
    required this.circleCenter,
    required this.circleRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child, // Your main content
        ClipPath(
          clipper: _CircularCutoutClipper(
            center: circleCenter,
            radius: circleRadius,
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: barrierColor,
          ),
        ),
      ],
    );
  }
}

class _CircularCutoutClipper extends CustomClipper<Path> {
  final Offset center;
  final double radius;

  _CircularCutoutClipper({required this.center, required this.radius});

  @override
  Path getClip(Size size) {
    // Create a path that covers the entire screen
    Path path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Create a circular path for the cutout
    Path circlePath = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));

    // Subtract the circle path from the rectangle path
    // PathFillType.evenOdd is important for this to work as a cutout
    return Path.combine(PathOperation.difference, path, circlePath);
  }

  @override
  bool shouldReclip(_CircularCutoutClipper oldClipper) {
    return oldClipper.center != center || oldClipper.radius != radius;
  }
}
