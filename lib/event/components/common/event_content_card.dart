import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/components/common/date_card.dart';

class EventContentCard extends StatelessWidget {
  final String title;
  final String? author;
  final String month;
  final String date;
  final double distance;
  final String location;
  final double? width;
  final double? height;
  final Color? color;
  final Widget? bottomContent;
  final bool isBlurred;
  final double elevation;
  final double? verticalPadding;

  const EventContentCard(
      {Key? key,
      required this.title,
      this.author,
      required this.month,
      required this.date,
      required this.distance,
      required this.location,
      this.width,
      this.height,
      this.color,
      this.bottomContent,
      this.isBlurred = true,
      this.elevation = 0,
      this.verticalPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: elevation,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CustomRadius.xxl)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(CustomRadius.xxl),
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: isBlurred ? 2.5 : 0, sigmaY: isBlurred ? 2.5 : 0),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: color ?? neutral.shade400.withOpacity(0.6),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: CustomPadding.xs,
                  vertical: verticalPadding ?? CustomPadding.sm),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: CustomPadding.base),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: CustomFontSize.sm,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'By $author',
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: neutral.shade700,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      DateCard(month: month, date: date)
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: primary,
                        size: 40,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('$distance km'),
                            Text(
                              location,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  bottomContent ?? const SizedBox.shrink()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
