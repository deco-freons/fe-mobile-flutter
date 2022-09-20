import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class CircleIconButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback onPressed;
  final double? radius;
  final Color? bgColor;
  final Color? iconColor;
  final double? iconSize;
  const CircleIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.radius = 25,
    this.bgColor,
    this.iconColor,
    this.iconSize = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: bgColor ?? neutral.shade100,
      child: IconButton(
        padding: EdgeInsets.zero,
        color: iconColor ?? neutral.shade900,
        iconSize: iconSize,
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}
