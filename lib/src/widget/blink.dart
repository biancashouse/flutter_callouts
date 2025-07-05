import 'package:flutter/material.dart';

class Blink extends StatefulWidget {
  final Widget child;
  final bool dontAnimate;
  final Color bgColor;
  final bool animateColor;

  @override
  // ignore: library_private_types_in_public_api
  _BlinkState createState() => _BlinkState();

  const Blink(
      {required this.child, this.dontAnimate = false, this.bgColor = Colors
          .yellowAccent, this.animateColor = false, super.key});
}

class _BlinkState extends State<Blink> with TickerProviderStateMixin {
  late Animation<double> opacityAnimation;
  late Animation colorAnimation;
  late AnimationController controller;

  @override
  initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    final CurvedAnimation curve = CurvedAnimation(
        parent: controller, curve: Curves.linear);
    if (widget.animateColor) {
      colorAnimation =
          ColorTween(begin: Colors.transparent, end: widget.bgColor).animate(
              curve);
      colorAnimation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(const Duration(milliseconds: 0), () {
            controller.reverse();
          });
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
        setState(() {});
      });
    } else {
      opacityAnimation = Tween<double>(begin: .7, end: 1).animate(curve);
      opacityAnimation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(const Duration(milliseconds: 0), () {
            try {
              controller.reverse();
            } catch (e) {}
          });
        } else if (status == AnimationStatus.dismissed) {
          try {
            controller.forward();
          } catch (e) {}
        }
        setState(() {});
      });
    }
    if (mounted) controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    late Color color;
    late double opacity;
    if (widget.animateColor) {
      color = colorAnimation.value;
      opacity = 1;
    } else {
      color = Colors.yellow;
      opacity = opacityAnimation.value;
    }
    return widget.dontAnimate
        ? widget.child
        : widget.animateColor
        ? AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) =>
          Container(
            color: color.withValues(alpha:opacity),
            child: widget.child,
          ),
    )
        : AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) =>
          Opacity(
            opacity: opacity,
            child: widget.child,
          ),
    );
  }

  @override
  dispose() {
    if (mounted)
      controller.dispose();
    super.dispose();
  }
}