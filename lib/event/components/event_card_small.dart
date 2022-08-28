import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/components/date_card.dart';
import 'package:flutter_boilerplate/page/landing.dart';

class EventCardSmall extends StatefulWidget {
  final String title;
  final double distance;
  final String month;
  final String date;
  final String image;

  const EventCardSmall(
      {Key? key,
      required this.title,
      required this.distance,
      required this.month,
      required this.date,
      required this.image})
      : super(key: key);

  @override
  State<EventCardSmall> createState() => _EventCardSmallState();
}

class _EventCardSmallState extends State<EventCardSmall> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Landing.routeName);
        },
        child: SizedBox(
          width: 192.0,
          height: 210.0,
          child: Padding(
              padding: const EdgeInsets.only(
                  top: 9.0, left: 9.0, right: 9.0, bottom: 13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: Container(
                      width: 174.0,
                      height: 139.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(widget.image),
                        fit: BoxFit.cover,
                      )),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 9.0, right: 9.0),
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
                    padding:
                        const EdgeInsets.only(left: 7.0, right: 7.0, top: 1.0),
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
    );
  }
}
