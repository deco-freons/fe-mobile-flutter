import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class PreferenceButton extends StatefulWidget {
  final PrefType type;
  final VoidCallback onPressedHandler;
  final double cornerRadius;
  final bool click;
  final double elevation;
  final double clickedElevation;
  final bool isAll;

  const PreferenceButton({
    Key? key,
    required this.type,
    required this.onPressedHandler,
    this.cornerRadius = 50.0,
    this.click = true,
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
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(widget.cornerRadius)),
          )),
      onPressed: widget.onPressedHandler,
      child: Text(
        (widget.isAll) ? 'All' : widget.type.desc,
        style: const TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
