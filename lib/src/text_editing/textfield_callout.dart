import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

mixin TextEditorMixin {
  /// returning false means user tapped the x
  void editText2({
    required final String prompt,
    required final Feature feature,
    required final double minHeight,
    required final String originalS,
    required final ValueChanged<String> onTextChangedF,
    required final ValueChanged<String> onEscapedF,
    final ValueChanged<Size>? onSizeChangeF,
    final ValueChanged<Offset>? onMovedF,
    required final BuildContext context,
    required final TargetKeyFunc targetGK,
    final Widget? dragHandle,
    final Alignment? initialCalloutAlignment = Alignment.topCenter,
    final Alignment? initialTargetAlignment = Alignment.bottomCenter,
    final Offset? initialCalloutOffset,
    final Widget? prefixIcon,
    required final VoidCallback? onDiscardedF,
    required final VoidCallback? onAcceptedF,
    final double? separation,
    final double? width = 400,
    final double? height,
    final bool notUsingHydratedStorage = false,
    final bool noBarrier = false,
    final bool ignoreCalloutResult = false,
    final double targetTranslateX = 0.0,
    final double targetTranslateY = 0.0,
    final bool dontAutoFocus = false,
    final Color? bgColor,
    final TextStyleF? textStyleF,
    final TextAlignF? textAlignF,
    final ScrollControllerName? scName,
  }) {
    GlobalKey<FC_TextEditorState> calloutChildGK =
        GlobalKey<FC_TextEditorState>();

    final FocusNode focusNode = FocusNode();

    // if (Useful.isIOS) {
    //   Useful.afterMsDelayDo(1000, () => CalloutHelper.showCallout(callout: toggleKeyboardSizeCallout2()));
    // }

    // Callout.removeAllOverlays();
    fca.showOverlay(
        targetGkF: targetGK,
        calloutContent: StringEditor_T(
          inputType: String,
          key: calloutChildGK,
          prompt: () => prompt,
          originalS: originalS,
          onTextChangedF: onTextChangedF,
          onEditingCompleteF: onTextChangedF,
          onEscapedF: onEscapedF,
          prefixIcon: prefixIcon,
          // minHeight: minHeight,
          dontAutoFocus: dontAutoFocus,
          bgColor: bgColor,
          textStyleF: textStyleF,
          textAlignF: textAlignF,
        ),
        calloutConfig: CalloutConfig(
          cId: feature,
          scrollControllerName: scName,
          containsTextField: true,
          // focusNode: focusNode,
          barrier: CalloutBarrier(
            opacity: noBarrier ? 0.0 : .25,
            onTappedF: noBarrier
                ? null
                : () async {
                    fca.removeParentCallout(context);
                    // Callout? parentCallout = feature:Callout.findCallout(feature);
                    // if (parentCallout != null) Callout.removeOverlay(parentCallout.feature, true);
                  },
          ),
          // arrowThickness: ArrowThickness.THIN,
          fillColor: Colors.white,
          arrowColor: Colors.red,
          finalSeparation: separation ?? 0.0,
          //developer.log('barrier tapped'),
          // dragHandle: dragHandle,
          initialCalloutAlignment:
              initialCalloutOffset != null ? null : initialCalloutAlignment,
          initialTargetAlignment:
              initialCalloutOffset != null ? null : initialTargetAlignment,
          initialCalloutPos: initialCalloutOffset,
          // barrierHasCircularHole: true,
          modal: false,
          initialCalloutW: width!,
          initialCalloutH: height ?? minHeight + 4,
          minHeight: minHeight + 4,
          resizeableH: true,
          resizeableV: true,
          onDismissedF: () {
            onTextChangedF.call(originalS);
            focusNode.dispose();
          },
          onAcceptedF: () {
            focusNode.dispose();
            onAcceptedF?.call();
          },
          // containsTextField: true,
          onResizeF: (Size newSize) {
            // calloutChildGK.currentState?.setState(() {});
            onSizeChangeF?.call(newSize);
          },
          onDragF: (Offset newOffset) {
            onMovedF?.call(newOffset);
          },
          targetTranslateX: targetTranslateX,
          targetTranslateY: targetTranslateY,
          draggable: true,
          // color: bgColor,
          notUsingHydratedStorage: notUsingHydratedStorage,
        ));

    // if callout completed with false, revert to original string
    if (!ignoreCalloutResult) {
      if (!dontAutoFocus) {
        fca.afterMsDelayDo(500, focusNode.requestFocus);
      }
      fca.showToast(
        removeAfterMs: 8 * 1000,
        calloutConfig: CalloutConfig(
          cId: "tap-outside-editor-name-toaccept",
          gravity: Alignment.topCenter,
          initialCalloutW: 450,
          initialCalloutH: 140,
          onlyOnce: true,
          scrollControllerName: scName,
        ),
        calloutContent: Padding(
          padding: const EdgeInsets.all(10),
          child: fca.coloredText(
            "tap outside the editor to close it ${fca.isWeb ? '\nor press <Shift-Return>' : ''}",
            color: Colors.white,
          ),
        ),
      );
    }
  }
}
