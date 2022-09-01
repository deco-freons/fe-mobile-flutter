import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class BackButton extends StatelessWidget {
  final VoidCallback onPressesed;
  const BackButton({Key? key, required this.onPressesed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressesed,
      icon: Icon(Icons.arrow_back, color: neutral.shade800, size: 35.0),
    );
  }
}
