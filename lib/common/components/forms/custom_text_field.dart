import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_date_picker.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';

class CustomTextField extends StatefulWidget {
  final CustomFormInput input;
  final GlobalKey<FormState> formKey;
  final Color labelColor;
  final TextStyle inputStyle;

  const CustomTextField({
    Key? key,
    required this.input,
    required this.formKey,
    required this.labelColor,
    required this.inputStyle,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _error = false;
  bool _obscured = true;
  bool _confirmObscured = true;

  void toggleVisibility() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  void toggleConfirmVisibility() {
    setState(() {
      _confirmObscured = !_confirmObscured;
    });
  }

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
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: widget.labelColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 11.0),
              child: widget.input.type == TextFieldType.date
                  ? CustomDatePicker(
                      input: widget.input,
                      firstDate: widget.input.firstDate,
                      lastDate: widget.input.lastDate,
                      inputStyle: widget.inputStyle,
                    )
                  : TextFormField(
                      controller: widget.input.controller,
                      obscureText: widget.input.type == TextFieldType.password
                          ? _obscured
                          : false,
                      readOnly: widget.input.disable,
                      style: widget.inputStyle,
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
                          fillColor: widget.input.disable
                              ? Theme.of(context)
                                  .colorScheme
                                  .tertiary
                                  .withOpacity(0.41)
                              : Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.21),
                          suffixIcon: widget.input.type ==
                                  TextFieldType.password
                              ? _obscured
                                  ? IconButton(
                                      icon: const Icon(Icons.visibility_off),
                                      onPressed: () {
                                        toggleVisibility();
                                      },
                                    )
                                  : IconButton(
                                      icon: const Icon(Icons.visibility),
                                      onPressed: () {
                                        toggleVisibility();
                                      },
                                    )
                              : null),
                      onChanged: (value) {
                        widget.input.confirmField
                            ? widget.formKey.currentState!.validate()
                            : null;
                        validateField();
                      },
                    ),
            ),
            widget.input.confirmField
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        "Confirm ${widget.input.label}",
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 11.0,
                      ),
                      TextFormField(
                        controller: widget.input.confirmController,
                        validator: (value) {
                          if (value != widget.input.controller.text) {
                            return 'Have to be the same as your ${widget.input.label}';
                          }
                          return null;
                        },
                        obscureText: widget.input.type == TextFieldType.password
                            ? _confirmObscured
                            : false,
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
                                .withOpacity(0.21),
                            suffixIcon: widget.input.type ==
                                    TextFieldType.password
                                ? _confirmObscured
                                    ? IconButton(
                                        icon: const Icon(Icons.visibility_off),
                                        onPressed: () {
                                          toggleConfirmVisibility();
                                        },
                                      )
                                    : IconButton(
                                        icon: const Icon(Icons.visibility),
                                        onPressed: () {
                                          toggleConfirmVisibility();
                                        },
                                      )
                                : null),
                        onChanged: (value) {
                          widget.formKey.currentState!.validate();
                        },
                      )
                    ],
                  )
                : const SizedBox(height: 0.0),
          ],
        ),
      ),
    );
  }
}
