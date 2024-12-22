import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Error extends StatelessWidget {
  final String flutterType;
  final Color color;
  final double? size;
  final String? errorMsg;

  const Error(this.flutterType,
      {this.color = Colors.red, this.size, this.errorMsg, required super.key});

  @override
  Widget build(BuildContext context) {
    double luminance = color.computeLuminance();
    bool needsDarkBg = luminance > 0.5;
    return Material(
      textStyle: const TextStyle(fontFamily: 'monospace', fontSize: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Container(
            width: 300,
            height: 200,
            color: Colors.red,
            padding: EdgeInsets.all(30),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Container(
                color: needsDarkBg ? Colors.black : Colors.white,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(flutterType),
                        Gap(10),
                        Icon(Icons.error, color: color, size: size),
                      ],
                    ),
                    if (errorMsg != null)
                      Text(
                        errorMsg!,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red, fontSize: size),
                      )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
