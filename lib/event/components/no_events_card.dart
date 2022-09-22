import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class NoEventsCard extends StatelessWidget {
  const NoEventsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: neutral.shade100,
          borderRadius:
              const BorderRadius.all(Radius.circular(CustomRadius.xxl)),
          boxShadow: [
            BoxShadow(
              color: neutral.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
            )
          ]),
      child: SizedBox(
        width: 360,
        height: 120,
        child: Padding(
          padding: const EdgeInsets.only(
            top: CustomPadding.md,
            bottom: CustomPadding.md,
            left: CustomPadding.xxl,
            right: CustomPadding.sm,
          ),
          child: Row(
            children: [
              Image.asset(
                'lib/common/assets/images/NoResult.png',
                width: 70,
                height: 70,
              ),
              const SizedBox(
                width: 25.0,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hmm, no sign of any events',
                      style: TextStyle(
                          fontSize: CustomFontSize.sm,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    Expanded(
                      child: Text(
                        "We couldnt find what you're looking for. Let's try something else.",
                        style: TextStyle(
                            fontSize: CustomFontSize.base,
                            fontWeight: FontWeight.bold,
                            color: neutral.shade300),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
