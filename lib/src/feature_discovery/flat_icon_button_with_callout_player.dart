// import 'package:flutter/material.dart';
// import 'package:flutter_callouts/flutter_callouts.dart';
//
// import 'play_callout_button.dart';
//
// class FlatIconButtonWithHelpCalloutButton extends StatefulWidget {
//   final VoidCallback onPressed;
//   final VoidCallback? onLongPress;
//   final ValueChanged<bool>? onHighlightChanged;
//   final ButtonTextTheme? textTheme;
//   final Color? textColor;
//   final Color? disabledTextColor;
//   final Color? color;
//   final Color? disabledColor;
//   final Color? focusColor;
//   final Color? hoverColor;
//   final Color? highlightColor;
//   final Color? splashColor;
//   final Brightness? colorBrightness;
//   final EdgeInsetsGeometry? padding;
//   final ShapeBorder? shape;
//   final Clip? clipBehavior;
//   final FocusNode? focusNode;
//   final bool? autofocus;
//   final MaterialTapTargetSize? materialTapTargetSize;
//   final Widget? optionalIcon;
//   final Widget? label;
//   final Feature feature;
//   final Widget? calloutContentsWidget;
//   final double contentsWidth;
//   final double contentsHeight;
//   final bool shouldAutoSetGotit;
//   final Alignment calloutAlignment;
//   final Alignment targetAlignment;
//   final Axis axis;
//   final double? separation;
//   final Function? onGotitF;
//
//   const FlatIconButtonWithHelpCalloutButton({
//     super.key,
//     required this.onPressed,
//     this.onLongPress,
//     this.onHighlightChanged,
//     this.textTheme,
//     this.textColor,
//     this.disabledTextColor,
//     this.color,
//     this.disabledColor,
//     this.focusColor,
//     this.hoverColor,
//     this.highlightColor,
//     this.splashColor,
//     this.colorBrightness,
//     this.padding,
//     this.shape,
//     this.clipBehavior,
//     this.focusNode,
//     this.autofocus,
//     this.materialTapTargetSize,
//     this.optionalIcon,
//     this.label,
//     this.feature = 'feature-not-supplied',
//     this.calloutContentsWidget,
//     this.contentsWidth = 300,
//     this.contentsHeight = 300,
//     this.calloutAlignment = Alignment.topRight,
//     this.targetAlignment = Alignment.bottomRight,
//     this.axis = Axis.vertical,
//     this.separation,
//     this.shouldAutoSetGotit = false,
//     this.onGotitF
//   });
//
//   @override
//   _FlatIconButtonWithHelpCalloutButtonState createState() => _FlatIconButtonWithHelpCalloutButtonState();
// }
//
// class _FlatIconButtonWithHelpCalloutButtonState extends State<FlatIconButtonWithHelpCalloutButton> {
//   @override
//   Widget build(BuildContext context) {
//     bool gotit = GotitsHelper.alreadyGotit(widget.feature);
//
//     // GlobalKey gk = GlobalKey();
//     var playBtn = PlayCalloutButton(
//       feature: widget.feature,
//       calloutContents: widget.calloutContentsWidget,
//       contentsWidth: widget.contentsWidth,
//       contentsHeight: widget.contentsHeight,
//       axis: widget.axis,
//       separation: widget.separation,
//       calloutAlignment: widget.calloutAlignment,
//       targetAlignment: widget.targetAlignment,
//       shouldAutoSetGotit: widget.shouldAutoSetGotit,
//       onGotitF: () {
//         setState(() {
//           widget.onGotitF?.call();
//         });
//       },
//     );
//
//     return widget.optionalIcon != null
//         ? TextButton.icon(
//             onPressed: widget.onPressed,
//             icon: widget.optionalIcon!,
//             label: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [widget.label!, if (!gotit) playBtn],
//             ))
//         : MaterialButton(
//             onPressed: widget.onPressed,
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [widget.label!, if (!gotit) playBtn],
//             ));
//   }
// }
