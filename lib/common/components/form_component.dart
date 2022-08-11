import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/custom_button.dart';
import 'package:flutter_boilerplate/common/components/custom_text_button.dart';
import 'package:flutter_boilerplate/common/components/custom_text_field.dart';

class CustomForm extends StatefulWidget {
  final String title;
  final List<String> fieldTitles;
  final List<TextEditingController> controllers;
  final String submitTitle;
  final String bottomText;
  final String textButton;
  final VoidCallback submitHandler;
  final bool hasForgotPassword;

  const CustomForm(
      {Key? key,
      required this.title,
      required this.fieldTitles,
      required this.controllers,
      required this.submitTitle,
      required this.submitHandler,
      this.bottomText = "",
      this.textButton = "",
      this.hasForgotPassword = false})
      : super(key: key);

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 22.0, right: 22.0, top: 34.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
        color: Theme.of(context).colorScheme.secondary,
      ),
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
          SizedBox(
            height: widget.fieldTitles.length * 109.0,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.fieldTitles.length,
              itemBuilder: (context, index) {
                return CustomTextField(
                  label: widget.fieldTitles[index],
                  isPassword: widget.fieldTitles[index] == "Password",
                );
              },
            ),
          ),
          if (widget.hasForgotPassword)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                CustomTextButton(text: 'Forgot Password?', type: 'inverse'),
              ],
            ),
          Padding(
            padding:
                EdgeInsets.only(top: widget.hasForgotPassword ? 0.0 : 45.0),
            child: CustomButton(
              label: widget.submitTitle,
              type: 'primary',
              onPressedHandler: widget.submitHandler,
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
                      type: widget.bottomText == '' ? 'inverse' : 'primary',
                    ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
