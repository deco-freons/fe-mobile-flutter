import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class ReportBottomModal extends StatelessWidget {
  const ReportBottomModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: CustomPadding.xxl, vertical: CustomPadding.xl),
      height: 185,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextButton(
            text: "Report Event",
            fontSize: 20,
            type: TextButtonType.tertiaryDark,
            onPressedHandler: () {
              showModalBottomSheet(
                barrierColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                ),
                context: context,
                builder: (context) {
                  return Container();
                },
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            label: "Close",
            cornerRadius: CustomRadius.button,
            type: ButtonType.primary,
            onPressedHandler: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
