import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class CustomSwitchField extends StatelessWidget {
  final CustomFormInput input;
  final TextStyle labelStyle;
  final TextStyle inputStyle;
  final double width;
  final double height;
  final double borderRadius;
  const CustomSwitchField(
      {Key? key,
      required this.input,
      required this.labelStyle,
      required this.inputStyle,
      this.width = 60.0,
      this.height = 26.0,
      this.borderRadius = CustomRadius.xxl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(input.label, style: labelStyle),
        ),
        AdvancedSwitch(
          controller: input.switchController,
          activeColor: primary,
          inactiveColor: neutral,
          activeChild: Text(
            'ON',
            style: inputStyle,
          ),
          inactiveChild: Text(
            'OFF',
            style: inputStyle,
          ),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          width: width,
          height: height,
          enabled: true,
        )
      ],
    );
  }
}
