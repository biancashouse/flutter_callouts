import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

import 'property_callout_button.dart';

class PropertyButton<T> extends StatelessWidget {
  final String label;
  final List<Widget> menuItems;
  final T? originalValue;

  final Function(int) onChangeF;
  final bool wrap;
  final Size calloutButtonSize;
  final Size calloutSize;

  const PropertyButton({
    required this.label,
    required this.menuItems,
    required this.originalValue,
    required this.onChangeF,
    this.wrap = false,
    required this.calloutButtonSize,
    required this.calloutSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PropertyCalloutButton(
        feature: 'property-button-enum-$label',
        notifier: ValueNotifier<int>(0),
        labelWidget: label.isNotEmpty
            ? Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            (FCallouts().coloredText(label.isNotEmpty ? '$label: ' : '', color: Colors.white)),
            originalValue == null
                ? FCallouts().coloredText('...', color: Colors.white)
                : FCallouts().coloredText(originalValue.toString(), color: Colors.white)
          ],
        )
            : originalValue == null
            ? FCallouts().coloredText('...', color: Colors.white)
            : FCallouts().coloredText(originalValue.toString(), color: Colors.white),
        calloutButtonSize: calloutButtonSize,
        initialCalloutAlignment: Alignment.bottomCenter,
        initialTargetAlignment: Alignment.topCenter,
        calloutContents: (ctx) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
                children: menuItems.asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        _changed(entry.key);
                        Callout.dismiss('property-button-enum-$label');
                      },
                      child: entry.value,
                    ),
                  );
                }).toList()),
          ),
        ),
        calloutSize: calloutSize,
      ),
    );
  }

  void _changed(int? option) {
    if (option != null) {
      onChangeF.call(option);
      // FC().afterMsDelayDo(500, () {
      //   Callout.dismiss(NODE_PROPERTY_CALLOUT_BUTTON);
      // });
    }
  }
}
