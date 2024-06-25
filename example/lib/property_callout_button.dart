import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

class PropertyCalloutButton extends StatelessWidget {
  final Feature feature;
  final Alignment alignment;
  final String? label;
  // final String? tooltip;
  final Widget? labelWidget;
  final WidgetBuilder calloutContents;
  final Color menuBgColor;
  final Alignment? initialTargetAlignment;
  final Alignment? initialCalloutAlignment;
  final bool? draggable;
  final Size calloutButtonSize;
  final Size calloutSize;
  final ValueNotifier<int> notifier;

  const PropertyCalloutButton({
    required this.feature,
    this.alignment = Alignment.centerLeft,
    this.label,
    // this.tooltip,
    this.labelWidget,
    required this.calloutContents,
    required this.calloutButtonSize,
    required this.calloutSize,
    this.initialTargetAlignment,
    this.initialCalloutAlignment,
    this.menuBgColor = Colors.purpleAccent,
    this.draggable,
    required this.notifier,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CalloutConfig config = CalloutConfig(
      feature: feature,
      suppliedCalloutW: calloutSize.width,
      suppliedCalloutH: calloutSize.height,
      arrowType: ArrowType.NO_CONNECTOR,
      // arrowColor: Colors.blueAccent,
      fillColor: menuBgColor,
      //alwaysReCalcSize: true,
      initialTargetAlignment: initialTargetAlignment ?? Alignment.center,
      initialCalloutAlignment: initialCalloutAlignment ?? Alignment.center,
      draggable: draggable ?? true,
      onDragStartedF: () {
        // FlutterContent().capiBloc.selectedNode?.hidePropertiesWhileDragging = true;
      },
      onDragEndedF: (_) {
        // FlutterContent().capiBloc.selectedNode?.hidePropertiesWhileDragging = false;
      },
      movedOrResizedNotifier: notifier,
      barrier: CalloutBarrier(
        opacity: .1,
        onTappedF: () async {
          // FlutterContent().capiBloc.selectedNode?.hidePropertiesWhileDragging = false;
          Callout.dismiss(feature);
        },
      ),
      containsTextField: true,
      resizeableH: false,
      resizeableV: false,
      borderRadius: 16,
    );
    return WrappedCallout(
      calloutConfig: config,
      calloutBoxContentBuilderF: (ctx) => calloutContents(ctx),
      targetChangedNotifier: notifier,
      targetBuilderF: (ctx) => GestureDetector(
        onTap: (){
          Callout.unhideParentCallout(ctx, animateSeparation: false);
        },
        child: Container(
          // key: propertyBtnGK,
          // margin: const EdgeInsets.only(top: 8),
          width: calloutButtonSize.width,
          height: calloutButtonSize.height,
          // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          color: labelWidget != null ? null : Colors.black,
          alignment: alignment,
          child: labelWidget ?? (label != null ? Text(label!) : const Offstage()),
        ),
      ),
    );
  }
}
