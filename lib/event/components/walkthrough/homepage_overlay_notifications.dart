import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/layout/walkthrough_text_box.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/components/walkthrough/walkthrough_overlay.dart';

class HomepageOverlayNotification extends StatelessWidget {
  final VoidCallback onNextPressed;
  final VoidCallback onBackPressed;
  const HomepageOverlayNotification(
      {Key? key, required this.onNextPressed, required this.onBackPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WalkthroughOverlay(
      handleWillPop: onBackPressed,
      children: [
        SizedBox(
          height: appBarHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: CustomPadding.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: neutral.shade100,
                      borderRadius: BorderRadius.circular(100)),
                  child: const Icon(
                    Icons.notifications_outlined,
                    size: 45.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Image.asset("lib/common/assets/images/TapGestureIcon.png"),
          ),
        ),
        WalkthroughTextBox(
          topMargin: 160,
          text: "Click here to see any notifications about your events!",
          buttonText: "Next",
          onTapHandler: onNextPressed,
        ),
      ],
    );
  }
}
