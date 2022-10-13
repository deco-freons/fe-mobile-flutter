import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/layout/walkthrough_text_box.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/components/walkthrough/walkthrough_overlay.dart';

class HomepageOverlayAppBarHomepage extends StatelessWidget {
  final VoidCallback onNextPressed;
  final VoidCallback onBackPressed;
  final IconData iconData;
  final double? iconPositionedLeft;
  final double? iconPositionedRight;
  final Color? iconColor;
  final Alignment gestureIconAlignment;
  final EdgeInsetsGeometry gestureIconPadding;
  final String gestureIcon;
  final double gestureIconScale;
  final String walkthroughText;
  final double walkthroughTextTopMargin;
  const HomepageOverlayAppBarHomepage(
      {Key? key,
      required this.onNextPressed,
      required this.onBackPressed,
      required this.iconData,
      this.iconPositionedLeft,
      this.iconColor,
      this.iconPositionedRight,
      required this.gestureIconAlignment,
      required this.gestureIconPadding,
      required this.gestureIcon,
      required this.gestureIconScale,
      required this.walkthroughText,
      required this.walkthroughTextTopMargin})
      : super(key: key);

  const HomepageOverlayAppBarHomepage.homepage(
      {Key? key,
      required this.onNextPressed,
      required this.onBackPressed,
      this.iconData = Icons.home_outlined,
      this.iconPositionedLeft,
      this.iconPositionedRight,
      this.iconColor = primary,
      this.gestureIconAlignment = Alignment.bottomLeft,
      this.gestureIconPadding = const EdgeInsets.only(bottom: 70),
      this.gestureIcon =
          "lib/common/assets/images/TapGestureIconDownFlipped.png",
      this.gestureIconScale = 1.1,
      this.walkthroughText = "Click here to go to the homepage!",
      this.walkthroughTextTopMargin = 520})
      : super(key: key);

  const HomepageOverlayAppBarHomepage.search(
      {Key? key,
      required this.onNextPressed,
      required this.onBackPressed,
      this.iconData = Icons.search_outlined,
      required this.iconPositionedLeft,
      this.iconPositionedRight,
      this.iconColor,
      this.gestureIconAlignment = Alignment.bottomLeft,
      required this.gestureIconPadding,
      this.gestureIcon =
          "lib/common/assets/images/TapGestureIconDownFlipped.png",
      this.gestureIconScale = 1.1,
      this.walkthroughText = "Click here to search some events!",
      this.walkthroughTextTopMargin = 520})
      : super(key: key);

  const HomepageOverlayAppBarHomepage.scheduled(
      {Key? key,
      required this.onNextPressed,
      required this.onBackPressed,
      this.iconData = Icons.edit_calendar_outlined,
      this.iconPositionedLeft,
      required this.iconPositionedRight,
      this.iconColor,
      this.gestureIconAlignment = Alignment.bottomRight,
      required this.gestureIconPadding,
      this.gestureIcon = "lib/common/assets/images/TapGestureIconDown.png",
      this.gestureIconScale = 1.1,
      this.walkthroughText =
          "Click here to find and manage your scheduled events!",
      this.walkthroughTextTopMargin = 520})
      : super(key: key);

  const HomepageOverlayAppBarHomepage.history(
      {Key? key,
      required this.onNextPressed,
      required this.onBackPressed,
      this.iconData = Icons.history_outlined,
      this.iconPositionedLeft,
      this.iconPositionedRight = 0,
      this.iconColor,
      this.gestureIconAlignment = Alignment.bottomRight,
      this.gestureIconPadding = const EdgeInsets.only(bottom: 70, right: 0),
      this.gestureIcon = "lib/common/assets/images/TapGestureIconDown.png",
      this.gestureIconScale = 1.1,
      this.walkthroughText = "Click here to look at your past events!",
      this.walkthroughTextTopMargin = 520})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WalkthroughOverlay(
      handleWillPop: onBackPressed,
      children: [
        Positioned(
          bottom: CustomPadding.xl,
          left: iconPositionedLeft,
          right: iconPositionedRight,
          child: Container(
            decoration: BoxDecoration(
                color: neutral.shade100,
                borderRadius: BorderRadius.circular(100)),
            child: Icon(
              iconData,
              size: 40.0,
              color: iconColor,
            ),
          ),
        ),
        Align(
          alignment: gestureIconAlignment,
          child: Padding(
            padding: gestureIconPadding,
            child: Image.asset(
              gestureIcon,
              scale: gestureIconScale,
            ),
          ),
        ),
        WalkthroughTextBox(
          topMargin: walkthroughTextTopMargin,
          text: walkthroughText,
          buttonText: "Next",
          onTapHandler: onNextPressed,
        ),
      ],
    );
  }
}
