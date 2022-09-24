import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/layout/network_image_container.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/build_loading.dart';
import 'package:flutter_boilerplate/event/components/common/date_card.dart';
import 'package:flutter_boilerplate/page/event/event_detail.dart';

class EventCardSmall extends StatefulWidget {
  final int eventID;
  final String title;
  final double distance;
  final String month;
  final String date;
  final String? image;
  final bool loading;

  const EventCardSmall({
    Key? key,
    required this.eventID,
    required this.title,
    required this.distance,
    required this.month,
    required this.date,
    this.image,
    this.loading = false,
  }) : super(key: key);

  const EventCardSmall.loading({
    Key? key,
    this.eventID = 0,
    this.title = '',
    this.distance = 0,
    this.month = '',
    this.date = '',
    this.image = '',
    this.loading = true,
  }) : super(key: key);

  @override
  State<EventCardSmall> createState() => _EventCardSmallState();
}

class _EventCardSmallState extends State<EventCardSmall> {
  @override
  Widget build(BuildContext context) {
    return !widget.loading
        ? Card(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            elevation: 3.0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, EventDetail.routeName,
                    arguments: widget.eventID);
              },
              child: SizedBox(
                width: 192.0,
                height: 210.0,
                child: Padding(
                    padding: const EdgeInsets.all(CustomPadding.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: NetworkImageContainer(
                            width: 174.0,
                            height: 139.0,
                            image: widget.image,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 9.0, right: 9.0),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: DateCard(
                                    month: widget.month,
                                    date: widget.date,
                                  )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 7.0, right: 7.0, top: 1.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Text(
                                    widget.title,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                '${widget.distance}km',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: neutral.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          )
        : BuildLoading.buildRectangularLoading(
            width: 192, height: 210, borderRadius: 20);
  }
}
