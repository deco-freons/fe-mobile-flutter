import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class CustomCheckboxField extends StatefulWidget {
  final CustomFormInput input;
  const CustomCheckboxField({Key? key, required this.input}) : super(key: key);

  @override
  State<CustomCheckboxField> createState() => _CustomCheckboxFieldState();
}

class _CustomCheckboxFieldState extends State<CustomCheckboxField> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        widget.input.label,
        style: const TextStyle(
          fontSize: CustomFontSize.sm,
          fontWeight: FontWeight.bold,
        ),
      ),
      value: widget.input.checkbox,
      onChanged: (e) {
        setState(() {
          widget.input.toggleCheckbox();
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
