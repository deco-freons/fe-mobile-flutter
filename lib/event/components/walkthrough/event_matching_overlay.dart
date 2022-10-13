import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/layout/walkthrough_text_box.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/components/walkthrough/walkthrough_overlay.dart';
import 'package:flutter_boilerplate/page/dashboard.dart';
import 'package:flutter_boilerplate/page/walkthrough/dummy_homepage.dart';

class EventMatchingOverlay extends StatefulWidget {
  const EventMatchingOverlay({Key? key}) : super(key: key);

  @override
  State<EventMatchingOverlay> createState() => _EventMatchingOverlayState();
}

class _EventMatchingOverlayState extends State<EventMatchingOverlay> {
  bool secondPage = false;
  @override
  Widget build(BuildContext context) {
    return WalkthroughOverlay(
        handleWillPop: () {
          if (secondPage) {
            setState(() {
              secondPage = false;
            });
          } else {
            Navigator.of(context)
                .pushNamed(DummyHomepage.routeName, arguments: 7);
          }
        },
        children: [
          Align(
            alignment: secondPage ? Alignment.topLeft : Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 350),
              child: Image.asset(secondPage
                  ? "lib/common/assets/images/SwipeLeftGestureIcon.png"
                  : "lib/common/assets/images/SwipeRightGestureIcon.png"),
            ),
          ),
          WalkthroughTextBox(
              topMargin: 540,
              text: secondPage
                  ? "If you're not interested in joining this event, swipe left or click the X button."
                  : "If you're interested in joining this event, swipe right or click the heart button.",
              buttonText: secondPage ? "Finish" : "Next",
              onTapHandler: () {
                if (secondPage) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Dashboard.routeName,
                    (route) => false,
                  );
                } else {
                  setState(() {
                    secondPage = true;
                  });
                }
              }),
          buildButtons(!secondPage, false),
          buildButtons(secondPage, true),
        ]);
  }

  Widget buildButtons(bool isOverlayOn, bool isLeft) {
    return Positioned(
      bottom: 40,
      left: isLeft ? 60 : null,
      right: isLeft ? null : 60,
      child: Stack(children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {},
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                color: isLeft ? error : primary,
                borderRadius: BorderRadius.circular(100)),
            child: isLeft
                ? Icon(
                    Icons.close_rounded,
                    color: neutral.shade100,
                    size: 50,
                  )
                : ImageIcon(
                    const AssetImage('lib/common/assets/images/HeartIcon.png'),
                    color: neutral.shade100,
                  ),
          ),
        ),
        isOverlayOn
            ? const SizedBox.shrink()
            : Container(
                decoration: BoxDecoration(
                    color: neutral.shade400.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(100)),
                width: 70,
                height: 70,
              ),
      ]),
    );
  }
}
