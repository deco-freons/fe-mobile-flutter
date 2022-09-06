import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class FilterContent extends StatelessWidget {
  final String title;
  final List<Widget> widgets;

  const FilterContent({Key? key, required this.title, required this.widgets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: CustomFontSize.md, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Wrap(
          spacing: CustomPadding.sm,
          runSpacing: CustomPadding.sm,
          children: widgets,
        ),
        const SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
