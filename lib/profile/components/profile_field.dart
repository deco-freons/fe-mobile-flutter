import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class ProfileField extends StatelessWidget {
  final String label;
  final String value;
  const ProfileField({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 38.0),
        Text(
          label,
          style: TextStyle(
            fontSize: CustomFontSize.base,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: CustomFontSize.lg,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
