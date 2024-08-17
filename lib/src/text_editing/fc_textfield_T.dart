import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

/// https://www.flutterbeads.com/multiline-textfield-in-flutter/
///
class FC_TextField extends StatefulWidget {
  final String Function()? prompt;
  final String Function()? inputDecorationLabel;
  final String originalS;
  final ValueChanged<String> onTextChangedF;
  final void Function(String) onEditingCompleteF;
  final void Function(String)? onEscapedF;
  final Widget? prefixIcon;

  // final bool expands;
  final int maxLines;
  final bool canExpand;
  final bool dontAutoFocus;
  final Color? bgColor;
  final InputDecoration? decoration;
  final bool isPassword;
  final String? passwordHelp;
  final Type inputType;
  final TextStyleF? textStyleF;
  final TextAlignF? textAlignF;

  const FC_TextField({
    this.prompt,
    this.inputDecorationLabel,
    required this.originalS,
    required this.onTextChangedF,
    required this.onEditingCompleteF,
    this.onEscapedF,
    this.prefixIcon,
    this.maxLines = 1,
    this.canExpand = false,
    required this.dontAutoFocus,
    this.bgColor,
    this.decoration,
    required this.inputType,
    this.isPassword = false,
    this.passwordHelp,
    this.textStyleF,
    this.textAlignF,
    super.key,
  });

  @override
  FC_TextEditorState createState() => FC_TextEditorState();
}

class FC_TextEditorState extends State<FC_TextField> {
  late TextEditingController _txtController;
  bool passwordVisible = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    // passwordVisible = true;

    _focusNode = FocusNode(
      onKeyEvent: (node, event) {
        final enterPressedWithoutShift = event is KeyDownEvent &&
            event.physicalKey == PhysicalKeyboardKey.enter &&
            !HardwareKeyboard.instance.physicalKeysPressed.any(
              (key) => <PhysicalKeyboardKey>{
                PhysicalKeyboardKey.shiftLeft,
                PhysicalKeyboardKey.shiftRight,
              }.contains(key),
            );

        final enterPressedWithShift = event is KeyDownEvent &&
            event.physicalKey == PhysicalKeyboardKey.enter &&
            HardwareKeyboard.instance.physicalKeysPressed.any(
              (key) => <PhysicalKeyboardKey>{
                PhysicalKeyboardKey.shiftLeft,
                PhysicalKeyboardKey.shiftRight,
              }.contains(key),
            );

        // when maxLines != 1, shift-enter accepts text
        if ((widget.maxLines > 1 && enterPressedWithShift) ||
            (widget.maxLines < 2 &&
                (enterPressedWithShift || enterPressedWithoutShift))) {
          widget.onEditingCompleteF.call(_txtController.text);
          // CalloutState? state = Callout.of(context);
          // if (state != null) {
          //   state.hideOP();
          // } else {
          //   Callout.removeParentCallout(context);
          // }
          return KeyEventResult.handled;
        }

        // esc key
        if (event.physicalKey == PhysicalKeyboardKey.escape) {
          widget.onEscapedF?.call(widget.originalS);
          // CalloutState? state = Callout.of(context);
          // if (state != null) {
          //   state.hideOP();
          // } else {
          //   Callout.removeParentCallout(context);
          // }
          return KeyEventResult.handled;
        }

        // Disable holding enter
        if (event is KeyRepeatEvent) {
          return KeyEventResult.handled;
        }

        // just ignore anything else
        return KeyEventResult.ignored;
      },
    );

    _txtController = TextEditingController();
    _txtController.text = widget.originalS;
    if (!widget.dontAutoFocus) {
      fca.afterNextBuildDo(() {
        _focusNode.requestFocus();
      });
    } else {
      _focusNode.unfocus();
    }
  }

  @override
  void dispose() {
    _txtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Widget? prefixWidget;
    // if (widget.prefixIcon != null &&
    //     (widget.prompt?.call().isNotEmpty ?? false)) {
    //   prefixWidget = Row(
    //     children: [
    //       widget.prefixIcon!,
    //       FCA.coloredText(
    //         widget.prompt!.call(),
    //         color: Colors.purpleAccent,
    //         fontSize: 14,
    //       ),
    //     ],
    //   );
    // } else if (widget.prefixIcon != null) {
    //   prefixWidget = widget.prefixIcon!;
    // }
    // if (widget.prompt?.call().isNotEmpty ?? false) {
    //   prefixWidget = Padding(
    //     padding: const EdgeInsets.only(top: 8.0),
    //     child: FCA.coloredText(widget.prompt!.call(), color: Colors.purpleAccent),
    //   );
    // }

    // TextInputType keyboardType = widget.isPassword
    //     ? TextInputType.visiblePassword
    //     : TextInputType.multiline;

    // if (!kIsWeb && widget.inputType == int) {
    //   keyboardType = TextInputType.number;
    // } else if (!kIsWeb && widget.inputType == double) {
    //   keyboardType = const TextInputType.numberWithOptions(decimal: true);
    // }

    InputDecoration inputDecoration = widget.isPassword
        ? InputDecoration(
            // border: const,
            //hintText: "Password",
            labelText: _txtController.text.isEmpty ? "Password" : '',
            // labelStyle: Useful.enclosureLabelTextStyle,
            labelStyle: const TextStyle(
                fontSize: 10, fontFamily: 'monospace', color: Colors.grey),
            // floatingLabelStyle: const TextStyle(fontSize: 18, fontFamily: 'monospace', color: Colors.grey),
            helperText: widget.passwordHelp,
            helperStyle: const TextStyle(color: Colors.green),
            suffixIcon: IconButton(
              icon: Icon(
                  passwordVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(
                  () {
                    passwordVisible = !passwordVisible;
                  },
                );
              },
            ),
            // contentPadding: const EdgeInsets.all(TextEditor.CONTENT_PADDING),
            alignLabelWithHint: true,
            filled: false,
          )
        : InputDecoration(
            labelText: widget.inputDecorationLabel?.call(),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26),
            ),
          );

    var inputFormatters = [
      if (widget.inputType == double)
        FilteringTextInputFormatter.allow(RegExp(r'^[\d/.]*$')),
      if (widget.inputType == int)
        FilteringTextInputFormatter.allow(RegExp(r'^[\d]*$')),
      if (!widget.canExpand)
        TextInputFormatter.withFunction((oldValue, newValue) {
          int newLines = newValue.text.split('\n').length;
          if (newLines > widget.maxLines) {
            return oldValue;
          } else {
            return newValue;
          }
        }),
    ];

    // Type T = widget.inputType;
    // bool isAString =  (sameType<widget.inputType, String>());

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 2),
      alignment:
          widget.inputType == String ? Alignment.centerLeft : Alignment.center,
      child: widget.inputType == String
          ? _stringTextField(inputFormatters, inputDecoration)
          : _numberTextField(inputFormatters, inputDecoration),
    );
  }

  Widget _stringTextField(inputFormatters, inputDecoration) => FocusScope(
        canRequestFocus: true,
        child: TextField(
          controller: _txtController,
          focusNode: _focusNode,
          maxLines: widget.isPassword
              ? 1
              : widget.maxLines == 1
                  ? null
                  : widget.maxLines,
          expands: false,
          // expands: widget.expands,
          // let key handler decide whether enter completes or appends newline
          inputFormatters: inputFormatters,
          decoration: inputDecoration,
          autofocus: !widget.dontAutoFocus,
          obscureText: widget.isPassword && !passwordVisible,
          style: widget.textStyleF != null
              ? (widget.textStyleF!).call()
              : TextStyle(
                  fontSize: 18,
                  fontFamily: 'monospace',
                  letterSpacing: 2,
                  color: Colors.blue[900]),
          textAlign: widget.textAlignF != null
              ? (widget.textAlignF!).call()
              : TextAlign.left,
          textAlignVertical: TextAlignVertical.top,
          onTap: () {
            // fca.logi("TextField tapped");
            // widget.focusNode.requestFocus();
          },
          onChanged: (s) {
            widget.onTextChangedF.call(s);
          },
          onTapOutside: (_) {
            _focusNode.unfocus();
            Callout.allowParentCalloutDrag(context);
          },
          autocorrect: false,
          enableInteractiveSelection: true,
          scrollPadding: const EdgeInsets.all(10),
        ),
      );

  Widget _numberTextField(inputFormatters, inputDecoration) => FocusScope(
        canRequestFocus: true,
        child: TextField(
          maxLines: 1,
          style: const TextStyle(
              fontSize: 16, fontFamily: 'monospace', color: Colors.black),
          controller: _txtController,
          inputFormatters: inputFormatters,
          decoration: inputDecoration,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          autofocus: true,
          onEditingComplete: () {
            widget.onEditingCompleteF.call(_txtController.text);
          },
          onTapOutside: (_) {
            widget.onEditingCompleteF.call(_txtController.text);
          },
        ),
      );
}
