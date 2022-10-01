import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/data/item_filter_model.dart';

class CustomToggleButtons extends StatelessWidget {
  final List<ItemFilterModel<String>> options;
  final Color activeBackgroundColor;
  final Color activeColor;
  final Color backgroundColor;
  final Color color;
  final double borderRadius;
  final void Function(int) onPressed;
  CustomToggleButtons({
    Key? key,
    required this.options,
    required this.onPressed,
    Color? activeBackgroundColor,
    Color? activeColor,
    Color? backgroundColor,
    Color? color,
    this.borderRadius = 10,
  })  : activeBackgroundColor = activeBackgroundColor ?? primary,
        activeColor = activeColor ?? neutral.shade100,
        backgroundColor = backgroundColor ?? primary.shade300,
        color = color ?? primary,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: options
          .asMap()
          .map(
            (i, option) => MapEntry(
              i,
              Expanded(
                child: InkWell(
                  onTap: () {
                    onPressed(i);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: CustomPadding.base),
                    decoration: BoxDecoration(
                      color: option.isPicked
                          ? activeBackgroundColor
                          : backgroundColor,
                      boxShadow: option.isPicked
                          ? null
                          : [
                              BoxShadow(
                                color: neutral.withOpacity(0.5),
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              )
                            ],
                      borderRadius: i == 0
                          ? BorderRadius.only(
                              bottomLeft: Radius.circular(borderRadius),
                              topLeft: Radius.circular(borderRadius),
                            )
                          : i == options.length - 1
                              ? BorderRadius.only(
                                  bottomRight: Radius.circular(borderRadius),
                                  topRight: Radius.circular(borderRadius),
                                )
                              : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      option.data,
                      style: TextStyle(
                          color: option.isPicked ? activeColor : color,
                          fontSize: CustomFontSize.lg,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          )
          .values
          .toList(),
    );
  }
}
