import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class WalkthroughTextBox extends StatelessWidget {
  final double topMargin;
  final String text;
  final String buttonText;
  final VoidCallback onTapHandler;
  const WalkthroughTextBox(
      {Key? key,
      required this.topMargin,
      required this.text,
      required this.buttonText,
      required this.onTapHandler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(CustomRadius.xxl),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: CustomPadding.base,
                    horizontal: CustomPadding.xl,
                  ),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: neutral.shade100,
                        fontSize: CustomFontSize.md,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: onTapHandler,
            child: Text(
              buttonText,
              style: TextStyle(
                  color: neutral.shade900,
                  fontSize: CustomFontSize.lg,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
