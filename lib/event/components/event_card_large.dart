import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/components/date_card.dart';
import 'package:flutter_boilerplate/page/landing.dart';

class EventCardLarge extends StatefulWidget {
  final String title;
  final String? author;
  final double distance;
  final String location;
  final String month;
  final String date;
  final String image;

  const EventCardLarge(
      {Key? key,
      required this.title,
      required this.author,
      required this.distance,
      required this.location,
      required this.month,
      required this.date,
      required this.image})
      : super(key: key);

  @override
  State<EventCardLarge> createState() => _EventCardLargeState();
}

class _EventCardLargeState extends State<EventCardLarge> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Landing.routeName);
        },
        child: Container(
          width: 342.0,
          height: 257.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(widget.image), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20.0))),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0, right: 9.0),
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 9.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        widget.title,
                                        style: const TextStyle(
                                          fontSize: 14.0,
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
                                DateCard(month: widget.month, date: widget.date)
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Image.asset(
                                    'lib/common/assets/images/LocationIcon.png'),
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
    );
  }
}
