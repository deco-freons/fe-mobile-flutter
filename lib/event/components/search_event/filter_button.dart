import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class FilterButton extends StatelessWidget {
  final String desc;
  final VoidCallback onPressedHandler;
  final double cornerRadius;
  final bool isActive;
  final double elevation;
  final double activeElevation;

  const FilterButton({
    Key? key,
    required this.desc,
    required this.onPressedHandler,
    this.cornerRadius = 50.0,
    this.isActive = true,
    this.elevation = 0.0,
    this.activeElevation = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: isActive ? activeElevation : elevation,
          side: BorderSide(width: 1.0, color: primary.shade400),
          primary: isActive
              ? Theme.of(context).colorScheme.primary
              : primary.shade300,
          onPrimary: isActive
              ? Theme.of(context).colorScheme.secondary
              : neutral.shade800,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
          )),
      onPressed: onPressedHandler,
      child: IntrinsicWidth(
        child: Text(
          desc,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
