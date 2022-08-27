import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class PreferenceButton extends StatefulWidget {
  final PrefType type;
  final VoidCallback onPressedHandler;
  final double cornerRadius;
  final bool click;
  final String stringInput;
  final bool useStringInput;
  final bool cancelIcon;

  const PreferenceButton({
    Key? key,
    this.type = PrefType.MV,
    required this.onPressedHandler,
    this.cornerRadius = 50.0,
    this.click = true,
    this.stringInput = "",
    this.useStringInput = false,
    this.cancelIcon = false,
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
              ? neutral.shade800
              : Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(widget.cornerRadius)),
          )),
      onPressed: widget.onPressedHandler,
      child: IntrinsicWidth(
        child: Row(
          children: [
            Text(
              widget.useStringInput ? widget.stringInput : widget.type.desc,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            widget.cancelIcon
                ? Icon(
                    Icons.close_rounded,
                    color: grey.shade500,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
