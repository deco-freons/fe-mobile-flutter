import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/layout/walkthrough_text_box.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/config/walkthrough_constants.dart';
import 'package:flutter_boilerplate/event/components/common/home_content.dart';
import 'package:flutter_boilerplate/event/components/walkthrough/walkthrough_overlay.dart';
import 'package:flutter_boilerplate/page/walkthrough/dummy_event_matching.dart';

class HomepageOverlayEventMatching extends StatelessWidget {
  final VoidCallback onNextPressed;
  final VoidCallback onBackPressed;
  const HomepageOverlayEventMatching(
      {Key? key, required this.onNextPressed, required this.onBackPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WalkthroughOverlay(
      handleWillPop: onBackPressed,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 120),
          child: ListView(shrinkWrap: true, children: [
            Container(
              decoration: BoxDecoration(
                color: neutral.shade100,
                borderRadius: BorderRadius.circular(CustomRadius.xxl),
              ),
              padding: const EdgeInsets.symmetric(vertical: CustomPadding.sm),
              child: HomeContent(
                  title: '',
                  isCentered: true,
                  onlyContent: true,
                  contentWidgets: [exampleFeaturedEventCard]),
            ),
          ]),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 440),
            child: Image.asset("lib/common/assets/images/TapGestureIcon.png"),
          ),
        ),
        WalkthroughTextBox(
          topMargin: 550,
          text: "Click here to see what we've curated for you!",
          buttonText: "Next",
          onTapHandler: () {
            Navigator.of(context).pushNamed(DummyEventMatching.routeName);
          },
        ),
      ],
    );
  }
}
