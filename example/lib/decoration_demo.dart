import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

class DecorationDemoPage extends StatefulWidget {
  const DecorationDemoPage({super.key});

  @override
  State<DecorationDemoPage> createState() => DecorationDemoPageState();
}

/// it's important to add the mixin, because callouts are animated
class DecorationDemoPageState extends State<DecorationDemoPage> {
  DecorationShape? selectedDecorationShape;
  bool justShowNextDemoButton = false;

  @override
  void initState() {
    super.initState();

    fca.afterNextBuildDo(() => _show(DecorationShape.rectangle()));
  }

  void _show(DecorationShape shape) {
    late UpTo6Colors fillColors;
    bool? linearGradient;
    if (shape.name == "rectangle") {
      fillColors = UpTo6Colors(color1: Colors.pink[50]);
    } else if (shape.name == "rectangle_dotted") {
      fillColors = UpTo6Colors(color1: Colors.pink[50]);
    } else if (shape.name == "rounded_rectangle") {
      fillColors = UpTo6Colors(color1: Colors.white, color2: Colors.red, color3: Colors.blue);
      linearGradient = true;
    } else if (shape.name == "rounded_rectangle_dotted") {
      fillColors = UpTo6Colors(color1: Colors.white, color2: Colors.red, color3: Colors.blue);
      linearGradient = false;
    } else if (shape.name == "circle") {
      fillColors = UpTo6Colors(color1: Colors.white, color2: Colors.black, color3: Colors.white, color4: Colors.black,color5: Colors.white, color6: Colors.black);
      linearGradient = false;
    } else if (shape.name == "bevelled") {
      fillColors = UpTo6Colors(color1: Colors.lightBlue);
    } else if (shape.name == "stadium") {
      fillColors = UpTo6Colors(color1: Colors.yellowAccent, color2: Colors.lightBlue, color3: Colors.lime);
      linearGradient = false;
    } else if (shape.name == "star") {
      fillColors = UpTo6Colors(color1: Colors.white, color2: Colors.blue, color3: Colors.yellow, color4: Colors.green,color5: Colors.black, color6: Colors.cyan);
      linearGradient = false;
    }
    fca.showOverlay(
      calloutConfig: CalloutConfig(
        cId: 'some-callout-id',
        decorationShape: shape, // ?? DecorationShape.rectangle(),
        initialCalloutW: 900,
        initialCalloutH: 600,
        decorationBorderThickness: 5,
        decorationBorderRadius:
            shape.name == "rectangle" ||
            shape.name == "rectangle_dotted" ? 0.0 : 16,
        decorationUpTo6FillColors: fillColors,
        decorationGradientIsLinear: linearGradient,
        decorationUpTo6BorderColors: UpTo6Colors(color1: Colors.blue),
        // elevation: 10,
        onDismissedF: () => setState(() => justShowNextDemoButton = true),
        scrollControllerName: null,
      ),
      calloutContent: Center(
        child: DropdownMenu<DecorationShape>(
          initialSelection: shape,
          requestFocusOnTap: true,
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            contentPadding: EdgeInsets.all(20.0),
          ),
          label: Text(
            selectedDecorationShape == null
                ? "no decoration"
                : 'DecorationShape: ${selectedDecorationShape!.name}',
            style: TextStyle(color: Colors.blueGrey, fontSize: 12),
          ),
          onSelected: (DecorationShape? newShape) {
            fca.dismiss("some-callout-id");
            _show(
              selectedDecorationShape =
                  newShape ?? DecorationShape.rectangle(),
            );
          },
          dropdownMenuEntries: [
            DropdownMenuEntry<DecorationShape>(
              value: DecorationShape.rectangle(),
              label: "DecorationShape.rectangle",
            ),
            DropdownMenuEntry<DecorationShape>(
              value: DecorationShape.rectangle_dotted(),
              label: "DecorationShape.rectangle_dotted",
            ),
            DropdownMenuEntry<DecorationShape>(
              value: DecorationShape.rounded_rectangle(),
              label: "DecorationShape.rounded_rectangle",
            ),
            DropdownMenuEntry<DecorationShape>(
              value: DecorationShape.rounded_rectangle_dotted(),
              label: "DecorationShape.rounded_rectangle_dotted",
            ),
            DropdownMenuEntry<DecorationShape>(
              value: DecorationShape.circle(),
              label: "DecorationShape.circle",
            ),
            DropdownMenuEntry<DecorationShape>(
              value: DecorationShape.bevelled(),
              label: "DecorationShape.bevelled",
            ),
            DropdownMenuEntry<DecorationShape>(
              value: DecorationShape.stadium(),
              label: "DecorationShape.stadium",
            ),
            DropdownMenuEntry<DecorationShape>(
              value: DecorationShape.star(),
              label: "DecorationShape.star",
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
        backgroundColor: Colors.black12,
        appBar: AppBar(
          title: const Text('Flutter_Callouts DecorationShape demo'),
        ),
        body: Center(
          child: SizedBox(
            height: 400,
            child: Column(
              children: [
                if (!justShowNextDemoButton)
                  Text('Try changing the "DecorationShape" pulldown...'),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          color: Colors.black,
          padding: EdgeInsets.all(8),
          child: Text(
            'This is a callout, centred on screen, i.e. no initialTargetAlignment, \n'
                'initialCalloutAlignment, nor initialCalloutPos). It\'s still draggable.\n\n'
                'Try setting its decoration...',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );
}
