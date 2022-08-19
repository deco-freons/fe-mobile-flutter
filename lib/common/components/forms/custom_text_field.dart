import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_date_picker.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';

class CustomTextField extends StatefulWidget {
  final CustomFormInput input;

  const CustomTextField({
    Key? key,
    required this.input,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _error = false;

  void validateField() {
    setState(() {
      _error = !RegExp(widget.input.pattern)
                  .hasMatch(widget.input.controller.text) &&
              widget.input.errorMessage != ''
          ? true
          : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 109.0,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.input.label,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 11.0),
              child: widget.input.type == TextFieldType.date
                  ? CustomDatePicker(
                      input: widget.input,
                      firstDate: widget.input.firstDate,
                      lastDate: widget.input.lastDate,
                    )
                  : TextField(
                      controller: widget.input.controller,
                      obscureText: widget.input.type == TextFieldType.password,
                      style: const TextStyle(
                          fontSize: 16.0, height: 1, color: Colors.black),
                      decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                                width: 1.0,
                                color: Theme.of(context).colorScheme.error),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide.none,
                          ),
                          errorText: _error ? widget.input.errorMessage : null,
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                                width: 1.0,
                                color: Theme.of(context).colorScheme.error),
                          ),
                          filled: true,
                          fillColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.21)),
                      onChanged: (value) {
                        validateField();
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
