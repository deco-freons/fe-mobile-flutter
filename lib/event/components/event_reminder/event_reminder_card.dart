import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/components/layout/network_image_avatar.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class EventReminderCard extends StatelessWidget {
  final String eventName;
  final String? imageUrl;
  final VoidCallback handleDismissClick;
  const EventReminderCard(
      {Key? key,
      required this.eventName,
      this.imageUrl,
      required this.handleDismissClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CustomRadius.xxl)),
      child: Container(
        decoration: BoxDecoration(
          color: neutral.shade100,
          borderRadius: BorderRadius.circular(CustomRadius.xxl),
          boxShadow: [
            BoxShadow(
              color: neutral.shade400,
              spreadRadius: 2,
              blurRadius: 3,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            CustomPadding.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  NetworkImageAvatar(
                      imageUrl: imageUrl,
                      radius: 25,
                      placeholderImage:
                          "lib/common/assets/images/NoEventImageIcon.png"),
                  const SizedBox(width: CustomPadding.md),
                  Expanded(
                      child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                          fontSize: CustomFontSize.base,
                          color: neutral.shade700,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: '$eventName, ',
                        ),
                        TextSpan(
                          text: 'starts tomorrow!',
                          style: TextStyle(color: neutral.shade500),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
              const SizedBox(
                height: CustomPadding.lg,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomButton(
                    label: "Dismiss",
                    padding: const EdgeInsets.symmetric(
                        vertical: CustomPadding.xs,
                        horizontal: CustomPadding.md),
                    onPressedHandler: () {
                      handleDismissClick();
                    },
                    labelFontSize: CustomFontSize.base,
                    cornerRadius: CustomRadius.button,
                    hasBorder: true,
                    borderColor: neutral.shade500,
                    elevation: 0,
                    height: 0,
                    width: 0,
                    type: ButtonType.neutral,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
