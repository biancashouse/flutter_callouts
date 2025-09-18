import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

class ToastDemoPage extends StatefulWidget {
  const ToastDemoPage({super.key});

  @override
  State<ToastDemoPage> createState() => ToastDemoPageState();
}

class ToastDemoPageState extends State<ToastDemoPage> {
  final TextEditingController gravityController = TextEditingController();
  Alignment? selectedGravity;
  late List<Alignment> alignments;
  bool justShowNextDemoButton = false;

  @override
  void initState() {
    super.initState();

    fca.afterNextBuildDo(() => _showToast(Alignment.topCenter));
  }

  void _showToast(Alignment gravity, {int showForMs = 0}) {
    // keep away from the edge of screen by 50
    double? contentTranslateX;
    double? contentTranslateY;
    switch (gravity) {
      case Alignment.topLeft:
        contentTranslateX = 50;
        contentTranslateY = 50;
        break;
      case Alignment.topRight:
        contentTranslateX = -50;
        contentTranslateY = 50;
        break;
      case Alignment.topCenter:
        contentTranslateY = 50;
        break;
      case Alignment.centerLeft:
        contentTranslateX = 50;
        break;
      case Alignment.centerRight:
        contentTranslateX = -50;
        break;
      case Alignment.center:
        break;
      case Alignment.bottomLeft:
        contentTranslateX = 50;
        contentTranslateY = -50;
        break;
      case Alignment.bottomCenter:
        contentTranslateY = -50;
        break;
      case Alignment.bottomRight:
        contentTranslateX = -50;
        contentTranslateY = -50;
        break;
    }

    fca.showToastOverlay(
      removeAfterMs: showForMs,
      calloutConfig: CalloutConfig(
        cId: 'toast-${gravity.runtimeType.toString()}',
        gravity: gravity,
        initialCalloutW: fca.isAndroid ? 200 : 500,
        initialCalloutH: 240,
        decorationUpTo6FillColors: UpTo6Colors(color1: Colors.black),
        showCloseButton: true,
        decorationBorderThickness: 5,
        decorationBorderRadius: 16,
        decorationUpTo6BorderColors: UpTo6Colors(color1: Colors.yellow),
        elevation: 10,
        scrollControllerName: null,
        contentTranslateX: contentTranslateX,
        contentTranslateY: contentTranslateY,
        onDismissedF: () => setState(() => justShowNextDemoButton = true),
      ),
      calloutContent: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                'this is a Toast callout, positioned according to the gravity:',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: DropdownMenu<Alignment>(
                initialSelection: gravity,
                controller: gravityController,
                requestFocusOnTap: true,
                inputDecorationTheme: const InputDecorationTheme(
                  filled: true,
                  contentPadding: EdgeInsets.all(20.0),
                ),
                label: const Text(
                  'Gravity',
                  style: TextStyle(color: Colors.blueGrey),
                ),
                onSelected: (Alignment? newGravity) {
                  fca.dismissToast(gravity);
                  _showToast(
                    selectedGravity = newGravity ?? Alignment.topCenter,
                  );
                },
                dropdownMenuEntries: [
                  DropdownMenuEntry<Alignment>(
                    value: Alignment.topLeft,
                    label: "Alignment.topLeft",
                  ),
                  DropdownMenuEntry<Alignment>(
                    value: Alignment.topCenter,
                    label: "Alignment.topCenter",
                  ),
                  DropdownMenuEntry<Alignment>(
                    value: Alignment.topRight,
                    label: "Alignment.topRight",
                  ),
                  DropdownMenuEntry<Alignment>(
                    value: Alignment.centerLeft,
                    label: "Alignment.centerLeft",
                  ),
                  DropdownMenuEntry<Alignment>(
                    value: Alignment.center,
                    label: "Alignment.center",
                  ),
                  DropdownMenuEntry<Alignment>(
                    value: Alignment.centerRight,
                    label: "Alignment.centerRight",
                  ),
                  DropdownMenuEntry<Alignment>(
                    value: Alignment.bottomLeft,
                    label: "Alignment.bottomLeft",
                  ),
                  DropdownMenuEntry<Alignment>(
                    value: Alignment.bottomCenter,
                    label: "Alignment.bottomCenter",
                  ),
                  DropdownMenuEntry<Alignment>(
                    value: Alignment.bottomRight,
                    label: "Alignment.bottomRight",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: true,
    onPopInvokedWithResult: (_, __) {
      fca.dismissAll();
    },
    child: SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Flutter_Callouts demo')),
        body: Center(
          child: SizedBox(
            height: 200,
            child: Column(
              children: [
                if (!justShowNextDemoButton)
                  Text(
                    'This page of the demo shows how you can overlay messages\n(popping on the screen like toast) over your app.\n\n'
                    'Try changing the "Gravity" pulldown...',
                  ),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          color: Colors.black,
          padding: EdgeInsets.all(8),
          child: Text(
            'demonstrating callouts as Toasts',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );
}
