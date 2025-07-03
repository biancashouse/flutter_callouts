import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

class ToastDemoPage extends StatefulWidget {
  const ToastDemoPage({super.key});

  @override
  State<ToastDemoPage> createState() => ToastDemoPageState();
}

/// it's important to add the mixin, because callouts are animated
class ToastDemoPageState extends State<ToastDemoPage> with TickerProviderStateMixin {
  final TextEditingController gravityController = TextEditingController();
  AlignmentEnum? selectedGravity;
  late List<Alignment> alignments;
  bool justShowNextDemoButton = false;

  @override
  void initState() {
    super.initState();

    fca.afterNextBuildDo(() => _showToast(AlignmentEnum.topCenter));
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  void didChangeDependencies() {
    fca.initWithContext(context);
    super.didChangeDependencies();
  }

  void _showToast(AlignmentEnum gravity, {int showForMs = 0}) {
    // keep away from the edge of screen by 50
    double? contentTranslateX;
    double? contentTranslateY;
    switch (gravity) {
      case AlignmentEnum.topLeft:
        contentTranslateX = 50;
        contentTranslateY = 50;
        break;
      case AlignmentEnum.topRight:
        contentTranslateX = -50;
        contentTranslateY = 50;
        break;
      case AlignmentEnum.topCenter:
        contentTranslateY = 50;
        break;
      case AlignmentEnum.centerLeft:
        contentTranslateX = 50;
        break;
      case AlignmentEnum.centerRight:
        contentTranslateX = -50;
        break;
      case AlignmentEnum.center:
        break;
      case AlignmentEnum.bottomLeft:
        contentTranslateX = 50;
        contentTranslateY = -50;
        break;
      case AlignmentEnum.bottomCenter:
        contentTranslateY = -50;
        break;
      case AlignmentEnum.bottomRight:
        contentTranslateX = -50;
        contentTranslateY = -50;
        break;
    }

    fca.showToastOverlay(
      removeAfterMs: showForMs,
      calloutConfig: CalloutConfigModel(
        cId: 'main-toast',
        gravity: gravity,
        initialCalloutW: 500,
        initialCalloutH: 200,
        fillColor: ColorModel.black26(),
        showCloseButton: true,
        borderThickness: 5,
        borderRadius: 16,
        borderColor: ColorModel.yellow(),
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
              child: Text('this is a Toast callout, positioned according to the gravity:', style: TextStyle(color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: DropdownMenu<AlignmentEnum>(
                initialSelection: gravity,
                controller: gravityController,
                requestFocusOnTap: true,
                inputDecorationTheme: const InputDecorationTheme(filled: true, contentPadding: EdgeInsets.all(20.0)),
                label: const Text('Gravity', style: TextStyle(color: Colors.blueGrey)),
                onSelected: (AlignmentEnum? newGravity) {
                  fca.dismiss('main-toast');
                  _showToast(selectedGravity = newGravity ?? AlignmentEnum.topCenter);
                },
                dropdownMenuEntries: AlignmentEnum.entries,
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
    onPopInvokedWithResult: (_, _) {
      fca.dismissAll();
    },
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
      child: Text('demonstrating callouts as Toasts', style: TextStyle(color: Colors.white)),
    ),
    ),
  );
}
