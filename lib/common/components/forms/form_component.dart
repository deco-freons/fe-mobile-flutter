import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_text_field.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';

class CustomForm extends StatefulWidget {
  final String title;
  final List<CustomFormInput> inputs;
  final String submitTitle;
  final String bottomText;
  final String textButton;
  final VoidCallback submitHandler;
  final bool hasForgotPassword;
  final VoidCallback textButtonHandler;
  final String errorMessage;
  final double submitPadding;
  final double textButtonPadding;
  final double bottomPadding;
  final double sidePadding;
  final Color labelColor;
  final TextStyle inputStyle;

  const CustomForm({
    Key? key,
    this.title = "",
    required this.inputs,
    required this.submitTitle,
    required this.submitHandler,
    required this.textButtonHandler,
    this.errorMessage = "",
    this.bottomText = "",
    this.textButton = "",
    this.hasForgotPassword = false,
    this.submitPadding = 45.0,
    this.textButtonPadding = 48.0,
    this.bottomPadding = 40.0,
    this.sidePadding = 22.0,
    Color? labelColor,
    TextStyle? inputStyle,
  })  : labelColor = labelColor ?? const Color(0xFF404852),
        inputStyle = inputStyle ??
            const TextStyle(fontSize: 16.0, height: 1, color: Colors.black),
        super(key: key);

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormState>();

  double calculateHeight(List<CustomFormInput> inputs) {
    double height = 0.0;
    for (CustomFormInput input in inputs) {
      height = height + 119.0;
      if (input.confirmField) {
        height = height + 119.0;
      }
    }
    return height;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: widget.sidePadding, right: widget.sidePadding, top: 34.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            widget.errorMessage != ""
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      widget.errorMessage,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  )
                : const SizedBox(
                    width: 0,
                    height: 0,
                  ),
            SizedBox(
              height: calculateHeight(widget.inputs),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.inputs.length,
                itemBuilder: (context, index) {
                  return CustomTextField(
                    formKey: _formKey,
                    input: widget.inputs[index],
                    labelColor: widget.labelColor,
                    inputStyle: widget.inputStyle,
                  );
                },
              ),
            ),
            if (widget.hasForgotPassword)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomTextButton(
                    text: 'Forgot Password?',
                    type: TextButtonType.tertiary,
                    onPressedHandler: () {},
                  ),
                ],
              ),
            Padding(
              padding:
                  EdgeInsets.only(top: widget.hasForgotPassword ? 0.0 : 45.0),
              child: CustomButton(
                label: widget.submitTitle,
                type: ButtonType.primary,
                onPressedHandler: () {
                  if (_formKey.currentState!.validate()) {
                    widget.submitHandler();
                  }
                },
              ),
            ),
            if (widget.bottomText != '' || widget.textButton != '')
              Padding(
                padding: const EdgeInsets.only(top: 48.0, bottom: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.bottomText != '')
                      Text(
                        widget.bottomText,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0),
                      ),
                    if (widget.textButton != '')
                      CustomTextButton(
                        text: widget.textButton,
                        type: widget.bottomText == ''
                            ? TextButtonType.tertiary
                            : TextButtonType.primary,
                        onPressedHandler: widget.textButtonHandler,
                      ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
