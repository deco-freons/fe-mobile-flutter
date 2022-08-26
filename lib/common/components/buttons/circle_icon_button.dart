import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class CircleIconButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback onPressed;
  const CircleIconButton(
      {Key? key, required this.icon, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: neutral.shade100,
      child: IconButton(
        color: neutral.shade900,
        iconSize: 30,
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}
