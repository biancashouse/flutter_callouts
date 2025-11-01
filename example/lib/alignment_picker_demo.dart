import 'package:flutter/material.dart';

import 'alignment_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Alignment Picker Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      home: const AlignmentPickerDemo(),
    );
  }
}

class AlignmentPickerDemo extends StatefulWidget {
  const AlignmentPickerDemo({super.key});

  @override
  State<AlignmentPickerDemo> createState() => _AlignmentPickerDemoState();
}

class _AlignmentPickerDemoState extends State<AlignmentPickerDemo> {
  Alignment _selectedAlignment = Alignment.center;
  GlobalKey gk = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alignment Picker')),
      body: Stack(
        children: [
          // MouseRegion(
          //   onHover: (event) {
          //     // _handleHover2(event.position, widget.size);
          //   },
          //   child: SizedBox.expand(),
          // ),
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // The Picker Widget
                AlignmentPicker(
                  initialAlignment: _selectedAlignment,
                  onChanged: (newAlignment) {
                    setState(() {
                      _selectedAlignment = newAlignment;
                    });
                  },
                  gk: gk,
                ),

                const SizedBox(height: 30),

                // Display the Resulting Alignment Value
                Text(
                  'Alignment: ${_selectedAlignment.toString()}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'x: ${_selectedAlignment.x.toStringAsFixed(3)}, y: ${_selectedAlignment.y.toStringAsFixed(3)}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
