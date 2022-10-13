import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class WalkthroughOverlay extends StatelessWidget {
  final VoidCallback handleWillPop;
  final List<Widget> children;

  const WalkthroughOverlay(
      {Key? key, required this.handleWillPop, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        handleWillPop();
        return Future.value(false);
      },
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: CustomPadding.lg),
          child: Stack(children: children),
        ),
      ),
    );
  }
}
