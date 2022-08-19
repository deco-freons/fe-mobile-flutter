import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final TextButtonType type;
  final double fontSize;
  final FontWeight textWeight;
  final VoidCallback onPressedHandler;

  const CustomTextButton(
      {Key? key,
      required this.text,
      this.type = TextButtonType.primary,
      this.fontSize = 14.0,
      this.textWeight = FontWeight.bold,
      required this.onPressedHandler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor:
            MaterialStateColor.resolveWith((states) => Colors.transparent),
      ),
      onPressed: onPressedHandler,
      child: Text(
        text,
        style: TextStyle(
            color: type == TextButtonType.primary
                ? Theme.of(context).colorScheme.primary
                : type == TextButtonType.secondary
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.tertiary,
            fontWeight: textWeight,
            fontSize: fontSize),
      ),
    );
  }
}
