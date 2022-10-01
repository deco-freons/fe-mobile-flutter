import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final double? width;
  final double? height;
  final Color color;
  final Color fontColor;
  final EdgeInsets? padding;
  final List<BoxShadow>? boxShadow;

  CustomChip({
    Key? key,
    required this.label,
    this.width = 100,
    this.height = 25,
    this.color = primary,
    Color? fontColor,
    this.padding,
    this.boxShadow,
  })  : fontColor = fontColor ?? neutral.shade100,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(CustomRadius.xxl),
          boxShadow: boxShadow,
        ),
        width: width,
        height: height,
        child: Text(
          label,
          style: TextStyle(color: fontColor, fontWeight: FontWeight.bold),
        ));
  }
}
