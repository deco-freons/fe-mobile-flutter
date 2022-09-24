import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class SeeMore extends StatefulWidget {
  final String text;
  final int characterLimit;
  final double fontSize;
  const SeeMore(
      {Key? key,
      required this.text,
      this.characterLimit = 70,
      this.fontSize = CustomFontSize.base})
      : super(key: key);

  @override
  State<SeeMore> createState() => _SeeMoreState();
}

class _SeeMoreState extends State<SeeMore> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      fontSize: widget.fontSize,
      color: neutral.shade700,
    );

    return widget.text.length <= widget.characterLimit
        ? Text(widget.text, style: textStyle)
        : RichText(
            text: TextSpan(
              text: isOpen
                  ? '${widget.text}   '
                  : '${widget.text.substring(0, widget.characterLimit).trimRight()}...',
              style: textStyle,
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
