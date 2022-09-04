import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class BackButton extends StatelessWidget {
  final VoidCallback onPressed;
  const BackButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      iconSize: 35,
      onPressed: onPressed,
      color: neutral.shade800,
      icon: const Icon(Icons.arrow_back),
    );
  }
}
