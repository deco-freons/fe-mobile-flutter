import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final String type;
  final double fontSize;
  final VoidCallback onPressedHandler;

  const CustomTextButton(
      {Key? key,
      required this.text,
      this.type = "primary",
      this.fontSize = 14.0,
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
            color: type == 'primary'
                ? Theme.of(context).colorScheme.primary
                : type == 'secondary'
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.bold,
            fontSize: fontSize),
      ),
    );
  }
}
