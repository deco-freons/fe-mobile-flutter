import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/preference/components/preference_button.dart';

class CustomInterestField extends StatefulWidget {
  final CustomFormInput input;
  final TextStyle inputStyle;
  const CustomInterestField({
    Key? key,
    required this.input,
    required this.inputStyle,
  }) : super(key: key);

  @override
  State<CustomInterestField> createState() => _CustomInterestFieldState();
}

class _CustomInterestFieldState extends State<CustomInterestField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: CustomPadding.sm,
          runSpacing: 0.0,
          children: widget.input.preferences.isNotEmpty
              ? widget.input.preferences
                  .map(
                    (pref) => PreferenceButton(
                      stringInput: pref.preferenceName,
                      useStringInput: true,
                      cancelIcon: true,
                      onPressedHandler: () {
                        widget.input.removePreferences(pref);
                        setState(() {});
                      },
                    ),
                  )
                  .toList()
              : [
                  Text(
                    "No picked categories",
                    style: widget.inputStyle,
                  )
                ],
        ),
        SizedBox(
          height: 38,
          child: TextFormField(
            decoration: const InputDecoration(border: InputBorder.none),
            readOnly: true,
            validator: (value) {
              if (widget.input.preferences.isEmpty) {
                return "Pick at least 1 category";
              } else {
                return null;
              }
            },
          ),
        )
      ],
    );
  }
}
