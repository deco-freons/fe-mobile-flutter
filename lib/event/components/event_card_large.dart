import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/layout/network_image_container.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/build_loading.dart';
import 'package:flutter_boilerplate/event/components/date_card.dart';

class EventCardLarge extends StatelessWidget {
  final String title;
  final String? author;
  final double distance;
  final String location;
  final String month;
  final String date;
  final String? image;
  final double width;
  final double height;
  final VoidCallback onTapHandler;
  final bool loading;

  const EventCardLarge({
    Key? key,
    required this.title,
    required this.author,
    required this.distance,
    required this.location,
    required this.month,
    required this.date,
    this.image,
    required this.onTapHandler,
    this.loading = false,
    this.width = 340.0,
    this.height = 256.0,
  }) : super(key: key);

  const EventCardLarge.loading({
    Key? key,
    this.title = '',
    this.author = '',
    this.distance = 0,
    this.location = '',
    this.month = '',
    this.date = '',
    this.image,
    required this.onTapHandler,
    this.loading = true,
    this.width = 340.0,
    this.height = 256.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !loading
        ? Card(
            margin: EdgeInsets.zero,
            elevation: 8.0,
            shadowColor: neutral.shade700,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(CustomRadius.xxl))),
            child: InkWell(
              onTap: onTapHandler,
              child: NetworkImageContainer(
                width: width,
                height: height,
                image: image,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: CustomPadding.md),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipRRect(
                      child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                          child: Container(
                            width: 311.0,
                            height: 96.0,
                            decoration: BoxDecoration(
                              color: neutral.shade400.withOpacity(0.6),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(CustomRadius.xxl),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(CustomPadding.xs),
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: CustomPadding.base),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                    ),
                  ),
                ),
              ),
            ),
          )
        : BuildLoading.buildRectangularLoading(
            width: 342, height: 257, borderRadius: 20);
  }
}
