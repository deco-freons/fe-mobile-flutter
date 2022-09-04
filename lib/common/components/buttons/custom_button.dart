import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class CustomButton extends StatefulWidget {
  final String label;
  final ButtonType type;
  final VoidCallback? onPressedHandler;
  final double cornerRadius;
  final double labelFontSize;
  final double? elevation;
  final bool hasBorder;
  final Color borderColor;

  const CustomButton(
      {Key? key,
      required this.label,
      required this.type,
      this.onPressedHandler,
      this.cornerRadius = CustomRadius.lg,
      this.labelFontSize = CustomFontSize.lg,
      this.elevation,
      this.hasBorder = false,
      this.borderColor = Colors.black})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          onSurface: neutral,
          primary: widget.type == ButtonType.primary
              ? Theme.of(context).colorScheme.primary
              : widget.type == ButtonType.inverse
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.error,
          onPrimary: widget.type == ButtonType.primary
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.primary,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(widget.cornerRadius)),
          ),
          elevation: widget.elevation,
          side:
              widget.hasBorder ? BorderSide(color: widget.borderColor) : null),
      onPressed: widget.onPressedHandler,
      child: Text(
        widget.label,
        style: TextStyle(
          color: widget.onPressedHandler == null
              ? neutral.shade600
              : widget.type == ButtonType.inverse
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,
          fontSize: widget.labelFontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
