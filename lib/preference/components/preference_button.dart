import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';

class PreferenceButton extends StatefulWidget {
  final PrefType type;
  final VoidCallback onPressedHandler;
  final double cornerRadius;
  final bool click;

  const PreferenceButton({
    Key? key,
    required this.type,
    required this.onPressedHandler,
    this.cornerRadius = 50.0,
    this.click = true,
  }) : super(key: key);

  @override
  State<PreferenceButton> createState() => _PreferenceButtonState();
}

class _PreferenceButtonState extends State<PreferenceButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0.0,
          primary: (widget.click)
              ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
              : Theme.of(context).colorScheme.primary,
          onPrimary: (widget.click)
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(widget.cornerRadius)),
          )),
      onPressed: widget.onPressedHandler,
      child: Text(
        widget.type.desc,
        style: const TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
