import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class EventReported extends StatefulWidget {
  const EventReported({Key? key}) : super(key: key);

  @override
  State<EventReported> createState() => _EventReportedState();
}

class _EventReportedState extends State<EventReported> {
  bool isShowDesc = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: neutral.shade100,
      width: 45,
      height: 45,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            child: Container(
              color: neutral.shade100,
              width: 45 + CustomPadding.body,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isShowDesc = !isShowDesc;
                  });
                },
                child: const Icon(
                  Icons.warning_rounded,
                  color: warning,
                  semanticLabel: "Event is suspicious",
                  size: 42,
                ),
              ),
            ),
          ),
          isShowDesc
              ? Positioned(
                  left: -228,
                  top: -76,
                  child: Container(
                      width: 272,
                      padding: const EdgeInsets.all(CustomPadding.sm),
                      decoration: BoxDecoration(
                          color: neutral.shade400,
                          borderRadius:
                              BorderRadius.circular(CustomRadius.base),
                          border: Border.all(color: neutral.shade900)),
                      child: const Center(
                        child: Text(
                          "This event has been reported as suspicious. Please be careful!",
                          style: TextStyle(
                            fontSize: CustomFontSize.base,
                          ),
                        ),
                      )),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
