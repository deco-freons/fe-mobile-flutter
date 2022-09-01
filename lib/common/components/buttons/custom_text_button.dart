import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final TextButtonType? type;
  final double fontSize;
  final FontWeight textWeight;
  final VoidCallback onPressedHandler;

  const CustomTextButton(
      {Key? key,
      required this.text,
      this.type = TextButtonType.primary,
      this.fontSize = CustomFontSize.sm,
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
                    : type == TextButtonType.tertiary
                        ? Theme.of(context).colorScheme.tertiary
                        : type == TextButtonType.tertiaryDark
                            ? neutral.shade700
                            : Theme.of(context).colorScheme.error,
            fontWeight: textWeight,
            fontSize: fontSize),
      ),
    );
  }
}
