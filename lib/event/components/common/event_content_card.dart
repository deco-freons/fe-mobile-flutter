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
  final double width;
  final double height;
  final Color? color;

  const EventContentCard({
    Key? key,
    required this.title,
    this.author,
    required this.month,
    required this.date,
    required this.distance,
    required this.location,
    this.width = 312.0,
    this.height = 96.0,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: color ?? neutral.shade400.withOpacity(0.6),
              borderRadius: const BorderRadius.all(
                Radius.circular(CustomRadius.xxl),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(CustomPadding.xs),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: CustomPadding.base),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: CustomFontSize.sm,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                    DateCard(month: month, date: date)
                  ],
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: primary,
                        size: 40,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$distance km'),
                            Expanded(
                              child: Text(
                                location,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            ),
          )),
    );
  }
}
