import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';
import 'package:gap/gap.dart';
import 'package:image_network/image_network.dart';

mixin WidgetHelperMixin {
  bool SHOW_BOXED = false;
  bool DEBUGGING = false;

  Color get FUCHSIA_X => const Color.fromRGBO(255, 0, 255, 1);

  Widget boxedStep({
    Color? theColor,
    Color theBgColor = Colors.transparent,
    Widget? theChild,
    double? width,
    double? height,
    bool? force,
    double? thePadding,
    bool? notRounded,
    double theBorderWidth = 2.0,
  }) {
    if (!SHOW_BOXED) {
      return SizedBox(width: width, height: height, child: theChild);
    }

    if (width != null && height != null) {
      return !SHOW_BOXED && (force == null)
          ? Container(
              color: theBgColor,
              width: width,
              height: height,
              child: theChild,
            )
          : Container(
              padding: EdgeInsets.all(thePadding!),
              decoration: BoxDecoration(
                color: theBgColor,
                border: Border.all(width: theBorderWidth),
                borderRadius: BorderRadius.all(
                  Radius.circular(notRounded != null ? 0.0 : 16.0),
                ),
              ),
              width: width,
              height: height,
              child: theChild,
            );
    } else {
      return emptyZeroSizedContainer();
    }
  }

  // Container boxed(
  //     {Widget? child, required double width, required double height, Color? color, Color? bgColor, double padding = 0, bool shadow = false}) {
  //   if (!SHOW_BOXED) return Container(child: child, width: width + padding * 2, height: height + padding * 2, padding: EdgeInsets.all(padding));
  //
  //   if (shadow) {
  //     return Container(
  //         decoration: BoxDecoration(
  //           border: Border.all(width: 1.0, color: Colors.black87.withValues(alpha:.25)),
  //           boxShadow: [
  //             BoxShadow(
  //               blurRadius: 4.0,
  //               color: Colors.black.withValues(alpha:.5),
  //               offset: Offset(2.0, 2.0),
  //             ),
  //           ],
  //           //shape: BoxShape.rectangle,
  //           //border: Border.all(),
  //           color: color,
  //         ),
  //         child: child,
  //         width: width + padding * 2,
  //         height: height + padding * 2,
  //         padding: EdgeInsets.all(padding));
  //   } else if (color != null) {
  //     return Container(
  //         decoration: BoxDecoration(
  //           color: bgColor,
  //           border: Border.all(width: 1.0, color: color),
  //         ),
  //         child: child,
  //         width: width + padding * 2,
  //         height: height + padding * 2,
  //         padding: EdgeInsets.all(padding));
  //   } else {
  //     return Container(color: bgColor, child: child, width: width + padding * 2, height: height + padding * 2, padding: EdgeInsets.all(padding));
  //   }
  // }

  Widget boxChild({required Widget child, Color? bgColor}) => Material(
    elevation: 20,
    child: Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(),
        boxShadow: [
          if (bgColor != null)
            BoxShadow(
              color: Colors.white.withValues(alpha: .5),
              spreadRadius: 5,
              blurRadius: 10,
            ),
        ],
      ),
      child: child,
    ),
  );

  // visually guides user to type CR when the text overflows the max width.
  // achieved by preventing the auto wrap and showing the overflow slightly
  //obscured
  // Widget multilineTextField({
  //   required double theMaxTextWidth,
  //   required int theMaxLines,
  //   GlobalKey? theGlobalKey,
  //   required TextEditingController theTextController,
  //   String? theLabelText,
  //   Color theBgColor: Colors.transparent,
  //   Color theOverflowColor: Colors.red,
  //   double theFontSize: 14.0,
  // }) {
  //   return Container(
  //     color: Colors.transparent,
  //     width: theMaxTextWidth,
  //     child: Stack(
  //       children: <Widget>[
  //         Positioned(
  //           top: 24.0,
  //           child: Container(
  //             width: theMaxTextWidth,
  //             height: 76.0,
  //             decoration: BoxDecoration(
  //               color: theBgColor,
  //               border: Border.all(
  //                 color: Colors.grey,
  //                 width: 1.0,
  //                 style: BorderStyle.solid,
  //               ),
  //             ),
  //           ),
  //         ),
  //         Container(
  //           width: theMaxTextWidth + 90,
  //           child: TextField(
  //             key: theGlobalKey,
  //             //onChanged: (s) {},
  //             controller: theTextController,
  //             decoration: InputDecoration(
  //               filled: true,
  //               fillColor: Colors.white,
  //               labelText: theLabelText,
  //             ),
  //             autofocus: true,
  //             maxLines: theMaxLines,
  //             style: TextStyle(fontSize: theFontSize, fontFamily: 'monospace', color: Colors.blue),
  //           ),
  //         ),
  //         Positioned(
  //           left: theMaxTextWidth,
  //           top: 0,
  //           child: Opacity(
  //             opacity: .5,
  //             child: Container(
  //               color: theOverflowColor.withValues(alpha:.6),
  //               width: 90.0,
  //               height: 200.0,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  //void showColoredCommentDialog(BuildContext theEditorContext, String theTitle, String theMsg,
  //    {Color theBgColor: Colors.red,
  //      Color theFgColor: Colors.yellow,
  //      Alignment theAlignment: Alignment.center}) async {
  //// ask user if wants to create linked new clipboard
  //  await showDialog(
  //    barrierDismissible: true,
  //// flutter defined function
  //    context: theEditorContext,
  //    builder: (BuildContext context) {
  //// return object of type Dialog
  //      return AlignedAlertDialog(
  //        contentPadding: EdgeInsets.all(20),
  //        titlePadding: EdgeInsets.all(10),
  //        backgroundColor: theBgColor,
  //        alignment: theAlignment,
  //        title: theTitle.isEmpty ? Offstage() : Text(theTitle, style: TextStyle(color: theFgColor)),
  //        content: theAlignment == Alignment.center
  //            ? Text(
  //          theMsg,
  //          style: TextStyle(color: theFgColor),
  //        )
  //            : Container(
  //          width: Responsive.screenW(theEditorContext) / 2,
  //          child: Text(
  //            theMsg,
  //            style: TextStyle(color: theFgColor),
  //          ),
  //        ),
  //      );
  //    },
  //  );
  //}

  // class PossibleGlow extends StatefulWidget {
  //   final GotitHelper gotitHelper;
  //   final int feature;
  //   final Widget child;
  //   final double radius;
  //
  //   PossibleGlow({this.gotitHelper, @required this.feature, @required this.child, this.radius});
  //
  //   @override
  //   _PossibleGlowState createState() => _PossibleGlowState();
  // }
  //
  // class _PossibleGlowState extends State<PossibleGlow> {
  //   @override
  //   Widget build(BuildContext context) {
  //     if (widget.gotitHelper.alreadyGotit(widget.feature))
  //       return widget.child;
  //     else {
  //       setState(() {
  //         widget.gotitHelper.gotit(widget.feature);
  //       });
  //       return AvatarGlow(
  //         child: widget.child,
  //         glowColor: Colors.yellow,
  //         endRadius: widget.radius,
  //       );
  //     }
  //   }
  // }

  //class BackButton extends StatelessWidget {
  //  final Function(BuildContext) possiblyGoBack;
  //
  //  BackButton(this.possiblyGoBack);
  //
  //  @override
  //  Widget build(BuildContext context) {
  //    return IconButton(
  //        icon: Icon(
  //        Icons.chevron_left,
  //        color: Colors.orange,
  //        size: 48.0,
  //    ),
  //    onPressed: () {
  //    return possiblyGoBack(context);
  //    };
  //  }
  //}

  Text text16(
    String s, {
    Color theBgColor = Colors.white,
    Color color = Colors.black,
  }) => Text(
    s,
    style: TextStyle(
      fontSize: 16,
      color: color,
      background: bgPaint(theBgColor),
    ),
  );

  Text text18(String s, {Color theBgColor = Colors.white, key}) => Text(
    s,
    key: key,
    style: const TextStyle(fontSize: 18, color: Colors.black),
  );

  Text text24(String s, {Color theBgColor = Colors.white}) =>
      Text(s, style: TextStyle(fontSize: 24, background: bgPaint(theBgColor)));

  // newlines and tabs are problematic
  //String sanitizeJson(String s) =>
  //    s == null
  //        ? ''
  //        : s
  //        .replaceAll("'", '`')
  //        .replaceAll('"', '`')
  //        .replaceAll(String.fromCharCode(8220), '`')
  //        .replaceAll(String.fromCharCode(8221), '`')
  //        .replaceAll(String.fromCharCode(8217), '`')
  //        .replaceAll(String.fromCharCode(8216), '`')
  //        .replaceAll(String.fromCharCode(9), '`t`')
  //        .replaceAll(String.fromCharCode(10), '`r`')
  //        .replaceAll(String.fromCharCode(13), '`n`');

  //String stripNewlines(String s) =>
  //    s == null
  //        ? ''
  //        : s
  //        .replaceAll('\\n', '\n')
  //        .replaceAll('\\t', '\t');
  //
  //String cleanJsonBodyString(String s) =>
  //    s == null
  //        ? ''
  //        : s
  //        .replaceAll("'", '`')
  //        .replaceAll(String.fromCharCode(8220), '`')
  //        .replaceAll(String.fromCharCode(8221), '`')
  //        .replaceAll(String.fromCharCode(8217), '`')
  //        .replaceAll(String.fromCharCode(8216), '`')
  //        .replaceAll(String.fromCharCode(10), '\\n')
  //        .replaceAll(String.fromCharCode(13), '\\n');

  SizedBox emptyZeroSizedContainer() => const SizedBox(width: 0.0, height: 0.0);

  // ignore: non_constant_identifier_names
  double REM = 12.0;

  // ignore: non_constant_identifier_names
  double MIN_FONT_SIZE = 10.0;

  double rem(multiple) => REM * multiple;

  // Widget constrainedText({
  //   @required BuildContext context,
  //   @required String s,
  //   @required double w,
  //   @required double h,
  //   @required TextStyle style,
  //   int maxLines = 1,
  // }) {
  //   return SizedBox(
  //     width: w,
  //     height: h,
  //     child: AutoSizeText(
  //       s,
  //       style: style,
  //       minFontSize: MIN_FONT_SIZE, // dont scale down any smaller than this
  //       maxLines: maxLines,
  //       overflow: TextOverflow.ellipsis,
  //     ),
  //   );
  // }

  // Widget memoryPic(
  //         {GlobalKey? gk, required Uint8List bytes, Alignment alignment = Alignment.center, double? width, double? height, double padding = 20}) =>
  //     Container(
  //       key: gk,
  //       padding: EdgeInsets.all(padding),
  //       alignment: alignment,
  //       width: width,
  //       height: height,
  //       decoration: BoxDecoration(
  //         image: new DecorationImage(
  //           fit: width != null || height != null ? BoxFit.contain : BoxFit.cover,
  //           image: MemoryImage(bytes),
  //         ),
  //       ),
  //     );

  Widget memoryPicWithFadeIn({
    GlobalKey? gk,
    String? toolTip,
    required Uint8List bytes,
    Alignment alignment = Alignment.center,
    double? width,
    double? height,
    double padding = 20,
  }) => Container(
    key: gk,
    padding: EdgeInsets.all(padding),
    alignment: alignment,
    width: width,
    height: height,
    child: toolTip == null
        ? FadeInImage(
            fadeInDuration: const Duration(milliseconds: 200),
            alignment: alignment,
            placeholder: const AssetImage(
              'lib/assets/images/loading-icon-256x256.png',
              package: 'flutter_callouts',
            ),
            image: MemoryImage(bytes),
            width: width,
            height: height,
          )
        : Tooltip(
            message: toolTip,
            child: FadeInImage(
              fadeInDuration: const Duration(milliseconds: 200),
              alignment: alignment,
              placeholder: const AssetImage(
                'lib/assets/images/loading-icon-256x256.png',
                package: 'flutter_callouts',
              ),
              image: MemoryImage(bytes),
              width: width,
              height: height,
            ),
          ),
  );

  // Widget networkPic({required String url, Alignment alignment = Alignment.center, double width = 512, double height = 512, double padding = 20}) =>
  //     Container(
  //       padding: EdgeInsets.all(padding),
  //       alignment: alignment,
  //       width: width,
  //       height: height,
  //       decoration: BoxDecoration(
  //         image: new DecorationImage(
  //           fit: BoxFit.cover,
  //           image: NetworkImage(url),
  //         ),
  //       ),
  //     );

  Widget networkPicWithFadeIn({
    required String url,
    Alignment alignment = Alignment.center,
    double width = 512,
    double height = 512,
    double padding = 20,
    BorderRadius radius = BorderRadius.zero,
  }) => Container(
    padding: EdgeInsets.all(padding),
    alignment: alignment,
    width: width,
    height: height,
    child: kIsWeb
        ? ImageNetwork(
            image: url,
            //imageCache: CachedNetworkImageProvider(url),
            height: 512,
            width: 512,
            duration: 1500,
            curve: Curves.easeIn,
            onPointer: true,
            debugPrint: false,
            fitAndroidIos: BoxFit.cover,
            fitWeb: BoxFitWeb.contain,
            onLoading: const CircularProgressIndicator(
              color: Colors.indigoAccent,
            ),
            borderRadius: radius,
          )
        : FadeInImage.memoryNetwork(
            alignment: alignment,
            placeholder: base64Decode(
              'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAAAyVBMVEUAAAC9vsDCw8W9v8G9vsD29/fr7O29vsDm5+jx8fK/wML29vf///+9vsHR0tPm5+jt7u7w8PHr7Ozc3d7n6OnExcfGx8nJyszMzM7V1tjZ2tvf4OG9vsDHyMrp6uvIycu9v8HAwcTPz9HCw8W9vsC9vsDBwsTj5OXj5OXW19i9vsDm5+jw8PHy8vL09fW9vsDFxsjJyszAwsS9vsDU1dbLzM7Y2drb3N3c3d7e3+DHyMrBwsTh4uPR0tPDxcfa293R0tTV1ti9vsAll6RJAAAAQnRSTlMA7+t/MAZHQDYjHxABv6xSQjEgFgzi2M7Emop0cGVLD/ryt7Cfj3dmYWBgWjgsGd/Cv7SvopSSg4B6eHZrQjkyKx1dd0xhAAAA9klEQVR4AYWPeXOCMBBHFxIgCQKC3KCo1Wprtfd98/0/VBPb6TC0Wd+/783+ZqELrQkRoIMujFbiaLTwpESC029reB7919d7u6SgYaE8aUCivW84oEUY0lPQc408pxBqHxCIHGiw4Lxtl5h35ALFglouAAaZTj00OJ7NrvDANI/Q4PlQMDbNFA3ekiQRaHGRpmM0eMqyyxgLRlme4ydu8/n8Az3h+37xiRWv/k1RRlhxUtyVD8yCXwaDflHeP1Zr5sIey3WtfvFeVS+rTWAzFobhNhrFf4omWK03wcS2h8OzLd/1TyhiNvkJQu5amocjznm0i6HDF1RMG1aMA/PYAAAAAElFTkSuQmCC',
            ),
            image: url,
            width: width,
            height: height,
          ),
  );

  // Widget assetPic(
  //         {required String path,
  //         Alignment alignment = Alignment.center,
  //         double? width,
  //         double? height,
  //         EdgeInsets padding = const EdgeInsets.all(20.0),
  //         Key? key}) =>
  //     Container(
  //       key: key,
  //       padding: padding,
  //       alignment: alignment,
  //       width: width,
  //       height: height,
  //       decoration: BoxDecoration(
  //         image: new DecorationImage(
  //           fit: BoxFit.cover,
  //           image: AssetImage(path),
  //         ),
  //       ),
  //     );

  Widget assetPicWithFadeIn({
    required String path,
    Alignment alignment = Alignment.center,
    double? width,
    double? height,
    EdgeInsets padding = const EdgeInsets.all(20.0),
    BoxFit? fit,
    Key? key,
  }) => Container(
    padding: padding,
    alignment: alignment,
    width: width,
    height: height,
    child: FadeInImage(
      key: key,
      alignment: alignment,
      placeholder: const AssetImage(
        'lib/assets/images/loading-icon-256x256.png',
        package: 'flutter_callouts',
      ),
      image: AssetImage(path),
      width: width,
      height: height,
      fit: fit,
    ),
  );

  // Size calculateTextSize({
  //   required String text,
  //   required TextStyle style,
  //   required int numLines,
  //   required BuildContext context,
  // }) {
  //   final double textScaleFactor = MediaQuery.of(context).textScaleFactor;
  //
  //   final TextPainter textPainter = TextPainter(
  //     text: TextSpan(text: text.replaceAll("`10`", "\n"), style: style),
  //     textDirection: Directionality.of(context),
  //     textScaler: TextScaler.linear(textScaleFactor),
  //     maxLines: 6,
  //   )..layout(minWidth: 0, maxWidth: double.infinity);
  //
  //   return numLines > 1 ? Size(textPainter.size.width, textPainter.size.height) : textPainter.size;
  // }

  double calculateAutoscaleFontSize(
    String text,
    TextStyle style,
    double startFontSize,
    double maxWidth,
  ) {
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    var currentFontSize = startFontSize;

    for (var i = 0; i < 100; i++) {
      // limit max iterations to 100
      final nextFontSize = currentFontSize + 1;
      final nextTextStyle = style.copyWith(fontSize: nextFontSize);
      textPainter.text = TextSpan(text: text, style: nextTextStyle);
      textPainter.layout();
      if (textPainter.width >= maxWidth) {
        break;
      } else {
        currentFontSize = nextFontSize;
        // continue iteration
      }
    }

    return currentFontSize;
  }

  Paint linePaint(Color theColor, {double theThickness = 1.5}) => Paint()
    ..color = theColor
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke
    ..strokeWidth = theThickness;

  Paint thickLinePaint(Color theColor) => Paint()
    ..color = theColor
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.5;

  Paint veryThickLinePaint(Color theColor) => Paint()
    ..color = theColor
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5.0;

  Paint bgPaint(Color theColor) => Paint()
    ..color = theColor
    ..style = PaintingStyle.fill;

  Paint bgLinearGradientPaint(List<Color> theColors, Rect rect) {
      final LinearGradient linearGradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        // stops: [0.0,.5],
        colors: theColors,
      );

      return Paint()
        ..shader = linearGradient.createShader(rect);
   }

  Paint bgRadialGradientPaint(List<Color> theColors, Rect rect, double radius) {
      final RadialGradient radialGradient = RadialGradient(
        center: Alignment.center, // Relative to circleRect
        radius: radius, // Relative to the shorter side of circleRect
        colors: theColors,
      );

      return Paint()
        ..shader = radialGradient.createShader(rect)
        ..style = PaintingStyle.fill;

  }

  Paint get highlightPaint => bgPaint(Colors.deepOrange);

  Paint get whiteBgPaint => bgPaint(Colors.white);

  Paint get transparentBgPaint => bgPaint(Colors.transparent);

  Paint redBgPaint() => bgPaint(Colors.red);

  // ignore: non_constant_identifier_names
  TextStyle greyHeadingText() =>
      const TextStyle(color: Colors.grey, fontWeight: FontWeight.w900);

  // ignore: non_constant_identifier_names
  TextStyle blackText(double size) =>
      TextStyle(fontSize: size, color: Colors.black);

  // ignore: non_constant_identifier_names
  TextStyle pinkText(double size) =>
      TextStyle(fontSize: size, color: Colors.pink[500]);

  // ignore: non_constant_identifier_names
  TextStyle blueText(double size) =>
      TextStyle(fontSize: size, color: Colors.blue[500]);

  // ignore: non_constant_identifier_names
  TextStyle greyItemText() =>
      const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400);

  // ignore: non_constant_identifier_names
  TextStyle whiteItemText() =>
      const TextStyle(color: Colors.white, fontWeight: FontWeight.w400);

  // ignore: non_constant_identifier_names
  TextStyle whiteHeadingText() =>
      const TextStyle(color: Colors.white, fontWeight: FontWeight.w900);

  ButtonStyle syncStyle() => ElevatedButton.styleFrom(
    backgroundColor: Colors.grey[200], // background
    foregroundColor: Colors.black, // foreground
  );

  ButtonStyle blackOnGrey() => ElevatedButton.styleFrom(
    backgroundColor: Colors.grey[200], // background
    foregroundColor: Colors.black, // foreground
  );

  ButtonStyle redOnGrey() => ElevatedButton.styleFrom(
    backgroundColor: Colors.grey[200], // background
    foregroundColor: Colors.red, // foreground
  );

  // https://flutter.dev/docs/release/breaking-changes/buttons
  // default old button styles
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    backgroundColor: Colors.black87,
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );

  ButtonStyle raisedButtonStyle({
    double elevation = 2,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 16),
    Color? backgroundColor,
    Color foregroundColor = Colors.grey,
    Size minimumSize = const Size(88, 36),
    dynamic shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
    TextStyle? textStyle,
  }) => ElevatedButton.styleFrom(
    elevation: elevation,
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    textStyle: textStyle,
    minimumSize: minimumSize,
    padding: padding,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  final ButtonStyle outlineButtonStyle =
      OutlinedButton.styleFrom(
        backgroundColor: Colors.black87,
        minimumSize: const Size(88, 36),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
      ).copyWith(
        side: WidgetStateProperty.resolveWith<BorderSide>((
          Set<WidgetState> states,
        ) {
          return BorderSide(
            // color: Theme.of(context).colorScheme.primary,
            color: states.contains(WidgetState.pressed)
                ? Colors.orange
                : Colors.grey,
            width: 1,
          );
        }),
      );

  Widget blink(Widget child) => Blink(child: child);

  /// A custom Path to paint stars.

  // PositionedRightTab({required double vPos, required Color bgColor, required Color borderColor, required Widget child}) {
  //   return Positioned(
  //     top: vPos,
  //     right: 0,
  //     child: RotatedBox(
  //       quarterTurns: 3,
  //       child: Container(
  //         decoration: BoxDecoration(
  //           color: bgColor,
  //           borderRadius: BorderRadius.only(
  //             topLeft: const Radius.circular(16.0),
  //             topRight: const Radius.circular(16.0),
  //           ),
  //           // boxShadow: [
  //           //   BoxShadow(color: borderColor, blurRadius: 3, spreadRadius: 2),
  //           //],
  //         ),
  //         child: child,
  //       ),
  //     ),
  //   );
  // }
  //
  // PositionedLeftTab({required double vPos, required Color bgColor, required Color borderColor, required Widget child}) {
  //   return Positioned(
  //     top: vPos,
  //     left: 0,
  //     child: RotatedBox(
  //       quarterTurns: 3,
  //       child: Container(
  //         decoration: BoxDecoration(
  //           color: bgColor,
  //           borderRadius: BorderRadius.only(
  //             bottomLeft: const Radius.circular(16.0),
  //             bottomRight: const Radius.circular(16.0),
  //           ),
  //           // boxShadow: [
  //           //   BoxShadow(color: borderColor, blurRadius: 3, spreadRadius: 2),
  //           //],
  //         ),
  //         child: Container(child: child),
  //       ),
  //     ),
  //   );
  // }

  PositionedTab({
    Rect? rect,
    double? top,
    double? left,
    double? bottom,
    double? right,
    required Color bgColor,
    required Color borderColor,
    bool? dontRotate,
    required Widget child,
    GlobalKey? key,
  }) {
    assert(left == 0 || right == 0 || top == 0 || bottom == 0);
    rect ??= const Rect.fromLTWH(0, 0, double.infinity, double.infinity);
    return Positioned(
      key: key,
      top: top,
      left: left,
      bottom: bottom,
      right: right,
      child: RotatedBox(
        quarterTurns: left == 0 || right == 0
            ? 3
            : top == 0
            ? 0
            : 0,
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: left == 0
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  )
                : right == 0
                ? const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  )
                : top == 0
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
            boxShadow: [
              BoxShadow(color: borderColor, blurRadius: 3, spreadRadius: 2),
            ],
          ),
          child: Container(child: child),
        ),
      ),
    );
  }

  Text coloredText(
    String s, {
    double? fontSize,
    Color? color,
    String? fontFamily,
    double? letterSpacing,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double scaleFactor = 1.0,
    int? maxLines,
    TextOverflow? overflow = TextOverflow.ellipsis,
  }) => Text(
    s,
    textScaler: TextScaler.linear(scaleFactor),
    // textScaleFactor: scaleFactor,
    style: TextStyle(
      inherit: true,
      color: color,
      fontSize: fontSize,
      fontFamily: fontFamily,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    ),
    maxLines: maxLines,
    softWrap: (maxLines ?? 0) > 1,
    overflow: overflow,
  );

  Text purpleText(String s, {double? fontSize, String? family}) => Text(
    s,
    style: TextStyle(
      inherit: true,
      color: Colors.purple,
      fontSize: fontSize,
      fontFamily: family,
    ),
  );

  TextStyle enclosureLabelTextStyle = const TextStyle(
    fontSize: 14,
    fontFamily: 'monospace',
    color: Colors.grey,
  );

  ButtonStyle buttonStyle(double fontSize) =>
      TextButton.styleFrom(textStyle: TextStyle(fontSize: fontSize));

  Icon whiteIcon(IconData iconData) => Icon(iconData, color: Colors.white);

  BoxDecoration rectangularBox({
    Color? color,
    double thickness = 1.0,
    double radius = 0.0,
  }) {
    return BoxDecoration(
      color: color,
      border: Border.all(width: thickness),
      borderRadius: radius > 0
          ? BorderRadius.all(Radius.circular(radius))
          : null,
    );
  }

  Widget boxedText({String text = '', Color? color}) => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.yellow[50],
      border: Border.all(width: 1),
    ),
    child: Text(text),
  );

  String asset(String name) {
    // only need to specify the asset pkg when used by a client project; i.e. not within the flutter_content project itself
    return fca.skipAssetPkgName ? name : 'packages/flutter_content/$name';
  }

  Widget gap(double gap) => Gap(gap);

  Image loadingImage256() => Image(
    image: AssetImage(
      'lib/assets/images/loading-icon-256x256.png',
      package: 'flutter_callouts',
    ),
  );
}

extension ExtendedOffset on Offset {
  String toFlooredString() {
    return '(${dx.floor()}, ${dy.floor()})';
  }
}
