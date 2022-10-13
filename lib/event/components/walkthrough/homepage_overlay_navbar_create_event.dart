import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/layout/walkthrough_text_box.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/components/walkthrough/walkthrough_overlay.dart';

class HomepageOverlayNavbarCreateEvent extends StatelessWidget {
  final VoidCallback onNextPressed;
  final VoidCallback onBackPressed;
  const HomepageOverlayNavbarCreateEvent(
      {Key? key, required this.onNextPressed, required this.onBackPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WalkthroughOverlay(
      handleWillPop: onBackPressed,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Container(
              padding: const EdgeInsets.only(top: CustomPadding.lg),
              width: 80,
              height: 80,
              child: FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(
                    Icons.add,
                    size: 50,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {}),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Image.asset(
              "lib/common/assets/images/TapGestureIconDown.png",
              scale: 1.1,
            ),
          ),
        ),
        WalkthroughTextBox(
          topMargin: 520,
          text: "Click here to create your own events!",
          buttonText: "Next",
          onTapHandler: onNextPressed,
        ),
      ],
    );
  }
}
