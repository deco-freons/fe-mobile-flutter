import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class ConfirmationModalBottom extends StatelessWidget {
  final String description;
  final String confirmText;
  final String cancelText;
  final TextButtonType? confirmButtonType;
  final TextButtonType? cancelButtonType;
  final VoidCallback onConfirmPressed;
  final VoidCallback onCancelPressed;

  const ConfirmationModalBottom(
      {Key? key,
      required this.description,
      required this.confirmText,
      required this.cancelText,
      this.confirmButtonType,
      this.cancelButtonType,
      required this.onConfirmPressed,
      required this.onCancelPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 29, right: 29, top: 44),
      height: 270,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: TextStyle(
                color: neutral.shade700,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 27,
            ),
            CustomTextButton(
              text: confirmText,
              fontSize: CustomFontSize.lg,
              type: confirmButtonType,
              onPressedHandler: onConfirmPressed,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextButton(
              text: cancelText,
              fontSize: CustomFontSize.lg,
              type: cancelButtonType,
              onPressedHandler: onCancelPressed,
            ),
          ],
        ),
      ),
    );
  }
}
