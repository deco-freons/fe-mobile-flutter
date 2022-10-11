import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class FilterContent extends StatelessWidget {
  final List<Widget> widgets;
  final double widgetPadding;

  const FilterContent({Key? key, required this.widgets, this.widgetPadding = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
