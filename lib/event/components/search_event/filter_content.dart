import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class FilterContent extends StatelessWidget {
  final String title;
  final List<Widget> widgets;
  final double widgetPadding;

  const FilterContent(
      {Key? key,
      required this.title,
      required this.widgets,
      this.widgetPadding = CustomPadding.xxl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: CustomPadding.xxl),
          child: Text(
            title,
            style: const TextStyle(
                fontSize: CustomFontSize.md, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: widgetPadding),
          child: Wrap(
            spacing: CustomPadding.sm,
            runSpacing: CustomPadding.sm,
            children: widgets,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
