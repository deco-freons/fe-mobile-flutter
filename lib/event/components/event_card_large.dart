import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/build_loading.dart';
import 'package:flutter_boilerplate/event/components/date_card.dart';

class EventCardLarge extends StatefulWidget {
  final String title;
  final String? author;
  final double distance;
  final String location;
  final String month;
  final String date;
  final String image;
  final VoidCallback onTapHandler;
  final bool loading;

  const EventCardLarge(
      {Key? key,
      required this.title,
      required this.author,
      required this.distance,
      required this.location,
      required this.month,
      required this.date,
      required this.image,
      required this.onTapHandler,
      this.loading = false})
      : super(key: key);

  const EventCardLarge.loading(
      {Key? key,
      this.title = '',
      this.author = '',
      this.distance = 0,
      this.location = '',
      this.month = '',
      this.date = '',
      this.image = '',
      required this.onTapHandler,
      this.loading = true})
      : super(key: key);

  @override
  State<EventCardLarge> createState() => _EventCardLargeState();
}

class _EventCardLargeState extends State<EventCardLarge> {
  @override
  Widget build(BuildContext context) {
    return !widget.loading
        ? Card(
            elevation: 5.0,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(CustomRadius.xxl))),
            child: InkWell(
              onTap: widget.onTapHandler,
              child: Container(
                width: 342.0,
                height: 257.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(widget.image), fit: BoxFit.cover)),
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
                                    Radius.circular(CustomRadius.xxl))),
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
                                              widget.title,
                                              style: const TextStyle(
                                                fontSize: CustomFontSize.sm,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'By ${widget.author}',
                                            style: TextStyle(
                                              fontSize: 10.0,
                                              color: neutral.shade700,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    DateCard(
                                        month: widget.month, date: widget.date)
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
                                            Text('${widget.distance} km'),
                                            Expanded(
                                              child: Text(
                                                widget.location,
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
