import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_text_field.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/page/auth/forget_password.dart';

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
  final double topPadding;
  final double bottomPadding;
  final double sidePadding;
  final Color labelColor;
  final TextStyle inputStyle;
  final double submitButtonRadius;

  CustomForm({
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
    this.topPadding = CustomPadding.xxxl,
    this.bottomPadding = 40.0,
    this.sidePadding = CustomPadding.xl,
    this.submitButtonRadius = CustomPadding.lg,
    Color? labelColor,
    TextStyle? inputStyle,
  })  : labelColor = labelColor ?? neutral.shade700,
        inputStyle = inputStyle ??
            TextStyle(
                fontSize: CustomFontSize.base,
                height: 1,
                color: neutral.shade900),
        super(key: key);

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: widget.sidePadding,
          right: widget.sidePadding,
          top: widget.topPadding,
          bottom: widget.bottomPadding),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(CustomRadius.body),
            topRight: Radius.circular(CustomRadius.body)),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.title != ""
                ? Text(
                    widget.title,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: CustomFontSize.xxl,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const SizedBox.shrink(),
            widget.errorMessage != ""
                ? Padding(
                    padding: const EdgeInsets.only(top: CustomPadding.xs),
                    child: Text(
                      widget.errorMessage,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontWeight: FontWeight.bold,
                          fontSize: CustomFontSize.base),
                    ),
                  )
                : const SizedBox.shrink(),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
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
            if (widget.hasForgotPassword)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomTextButton(
                    text: 'Forgot Password?',
                    type: TextButtonType.tertiary,
                    onPressedHandler: () {
                      Navigator.of(context).pushNamed(ForgetPassword.routeName);
                    },
                  ),
                ],
              ),
            Padding(
              padding:
                  EdgeInsets.only(top: widget.hasForgotPassword ? 0.0 : 45.0),
              child: CustomButton(
                label: widget.submitTitle,
                type: ButtonType.primary,
                cornerRadius: widget.submitButtonRadius,
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
                            fontSize: CustomFontSize.sm),
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
