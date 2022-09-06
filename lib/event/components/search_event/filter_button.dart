import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class FilterButton extends StatefulWidget {
  final String desc;
  final VoidCallback onPressedHandler;
  final double cornerRadius;
  final bool click;
  final double elevation;
  final double clickedElevation;

  const FilterButton({
    Key? key,
    required this.desc,
    required this.onPressedHandler,
    this.cornerRadius = 50.0,
    this.click = true,
    this.elevation = 0.0,
    this.clickedElevation = 0.0,
  }) : super(key: key);

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
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
        child: Text(
          widget.desc,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
