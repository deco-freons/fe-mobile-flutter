import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class SeeMore extends StatefulWidget {
  final String text;
  final int characterLimit;
  const SeeMore({Key? key, required this.text, this.characterLimit = 70})
      : super(key: key);

  @override
  State<SeeMore> createState() => _SeeMoreState();
}

class _SeeMoreState extends State<SeeMore> {
  bool isOpen = false;

  final TextStyle _textStyle = TextStyle(
    fontSize: CustomFontSize.base,
    color: neutral.shade700,
  );

  @override
  Widget build(BuildContext context) {
    return widget.text.length <= widget.characterLimit
        ? Text(widget.text, style: _textStyle)
        : RichText(
            text: TextSpan(
              text: isOpen
                  ? '${widget.text}   '
                  : '${widget.text.substring(0, widget.characterLimit).trimRight()}...',
              style: _textStyle,
              children: [
                TextSpan(
                  text: isOpen ? "See Less" : " Read More",
                  style: const TextStyle(color: primary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        isOpen = !isOpen;
                      });
                    },
                ),
              ],
            ),
          );
  }
}
