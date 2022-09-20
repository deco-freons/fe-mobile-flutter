import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final double width;
  final double height;
  final Color color;
  final Color fontColor;

  CustomChip({
    Key? key,
    required this.label,
    this.width = 100,
    this.height = 25,
    this.color = primary,
    Color? fontColor,
  })  : fontColor = fontColor ?? neutral.shade100,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(CustomRadius.xxl),
            boxShadow: [
              BoxShadow(
                color: neutral.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 3),
              )
            ]),
        width: width,
        height: height,
        child: Text(
          label,
          style: TextStyle(color: fontColor, fontWeight: FontWeight.bold),
        ));
  }
}
