import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String label;
  final String type;
  final VoidCallback onPressedHandler;
  final double cornerRadius;

  const CustomButton(
      {Key? key,
      required this.label,
      required this.type,
      required this.onPressedHandler,
      this.cornerRadius = 10.0})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  String type = 'primary';

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onFocusChange: (value) {
        if (type == 'primary') {
          type = 'inverse';
        } else {
          type = 'primary';
        }
      },
      style: ElevatedButton.styleFrom(
          primary: widget.type == 'primary'
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
          onPrimary: widget.type == 'primary'
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.primary,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(widget.cornerRadius)),
          )),
      onPressed: widget.onPressedHandler,
      child: Text(
        widget.label,
        style: TextStyle(
          color: widget.type == 'primary'
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.primary,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
