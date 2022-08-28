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
  final double elevation;
  final double clickedElevation;
  final bool isAll;

  const PreferenceButton({
    Key? key,
    this.type = PrefType.MV,
    required this.onPressedHandler,
    this.cornerRadius = 50.0,
    this.click = true,
    this.stringInput = "",
    this.useStringInput = false,
    this.cancelIcon = false,
    this.elevation = 0.0,
    this.clickedElevation = 0.0,
    this.isAll = false,
  }) : super(key: key);

  @override
  State<PreferenceButton> createState() => _PreferenceButtonState();
}

class _PreferenceButtonState extends State<PreferenceButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation:
              (widget.click) ? widget.elevation : widget.clickedElevation,
          side: BorderSide(width: 1.0, color: primary.shade400),
          primary: (widget.click)
              ? primary.shade300
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
              widget.useStringInput
                  ? widget.stringInput
                  : widget.isAll
                      ? 'All'
                      : widget.type.desc,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            widget.cancelIcon
                ? Icon(
                    Icons.close_rounded,
                    color: neutral.shade500,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
