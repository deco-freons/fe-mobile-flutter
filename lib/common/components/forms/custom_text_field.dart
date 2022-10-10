import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class CustomTextField extends StatefulWidget {
  final CustomFormInput input;
  final TextStyle inputStyle;
  final GlobalKey<FormState> formKey;
  const CustomTextField(
      {Key? key,
      required this.input,
      required this.inputStyle,
      required this.formKey})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isError = false;
  bool isObscured = true;
  bool isConfirmObscured = true;

  void toggleVisibility() {
    setState(() {
      isObscured = !isObscured;
    });
  }

  void toggleConfirmVisibility() {
    setState(() {
      isConfirmObscured = !isConfirmObscured;
    });
  }

  void validateField() {
    setState(() {
      isError = !RegExp(widget.input.pattern)
                  .hasMatch(widget.input.controller.text) &&
              widget.input.errorMessage != ''
          ? true
          : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.input.controller,
          obscureText:
              widget.input.type == TextFieldType.password ? isObscured : false,
          readOnly: widget.input.disable,
          keyboardType: widget.input.type == TextFieldType.textArea
              ? TextInputType.multiline
              : TextInputType.text,
          maxLines: widget.input.type == TextFieldType.textArea ? 4 : 1,
          maxLength: widget.input.maxLength,
          style: widget.inputStyle,
          decoration: InputDecoration(
              hintText: widget.input.placeholder ??
                  (widget.input.type == TextFieldType.textArea
                      ? 'Please enter ${widget.input.label} here...'
                      : null),
              errorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                    width: 1.0, color: Theme.of(context).colorScheme.error),
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide.none,
              ),
              errorText: isError ? widget.input.errorMessage : null,
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide(
                    width: 1.0, color: Theme.of(context).colorScheme.error),
              ),
              filled: true,
              fillColor: widget.input.disable
                  ? Theme.of(context).colorScheme.tertiary.withOpacity(0.41)
                  : primary.shade300,
              suffixIcon: widget.input.type == TextFieldType.password
                  ? isObscured
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
          validator: (value) {
            if (widget.input.required && widget.input.controller.text == "") {
              return "Required field";
            } else {
              return null;
            }
          },
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
                      fontSize: CustomFontSize.base,
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
                        ? isConfirmObscured
                        : false,
                    style: const TextStyle(
                        fontSize: CustomFontSize.base,
                        height: 1,
                        color: Colors.black),
                    decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 1.0,
                              color: Theme.of(context).colorScheme.error),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                        fillColor: primary.shade300,
                        suffixIcon: widget.input.type == TextFieldType.password
                            ? isConfirmObscured
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
            : const SizedBox.shrink(),
      ],
    );
  }
}
