import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/layout/network_image_avatar.dart';
import 'package:flutter_boilerplate/common/components/layout/walkthrough_text_box.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/components/walkthrough/walkthrough_overlay.dart';

class HomepageOverlayProfile extends StatelessWidget {
  final VoidCallback onNextPressed;
  final VoidCallback onBackPressed;
  const HomepageOverlayProfile(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                NetworkImageAvatar(imageUrl: null, radius: 23),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Image.asset("lib/common/assets/images/TapGestureIcon.png"),
          ),
        ),
        WalkthroughTextBox(
          topMargin: 160,
          text: "Click here to see and edit your profile!",
          buttonText: "Next",
          onTapHandler: onNextPressed,
        ),
      ],
    );
  }
}
