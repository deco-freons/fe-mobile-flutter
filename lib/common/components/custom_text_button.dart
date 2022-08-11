import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final String type;

  const CustomTextButton({Key? key, required this.text, this.type = "primary"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor:
            MaterialStateColor.resolveWith((states) => Colors.transparent),
      ),
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(
            color: type == 'primary'
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.bold,
            fontSize: 14.0),
      ),
    );
  }
}
