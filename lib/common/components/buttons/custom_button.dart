import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final ButtonType type;
  final VoidCallback? onPressedHandler;
  final double cornerRadius;
  final double labelFontSize;
  final double? elevation;
  final double height;
  final double width;
  final bool hasBorder;
  final Color borderColor;

  const CustomButton({
    Key? key,
    required this.label,
    required this.type,
    this.onPressedHandler,
    this.cornerRadius = CustomRadius.lg,
    this.labelFontSize = CustomFontSize.lg,
    this.elevation,
    this.hasBorder = false,
    this.borderColor = Colors.black,
    this.height = 52,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          onSurface: neutral,
          primary: type == ButtonType.primary
              ? Theme.of(context).colorScheme.primary
              : type == ButtonType.inverse
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.error,
          onPrimary: type == ButtonType.primary
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.primary,
          minimumSize: Size(width, height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
          ),
          elevation: elevation,
          side: hasBorder ? BorderSide(color: borderColor) : null),
      onPressed: onPressedHandler,
      child: Text(
        label,
        style: TextStyle(
          color: onPressedHandler == null
              ? neutral.shade600
              : type == ButtonType.inverse
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,
          fontSize: labelFontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
