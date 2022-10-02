import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/layout/network_image_container.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/build_loading.dart';
import 'package:flutter_boilerplate/event/components/common/date_card.dart';
import 'package:flutter_boilerplate/page/event/event_detail.dart';

class EventCardSmall extends StatelessWidget {
  final int eventID;
  final String title;
  final double distance;
  final String month;
  final String date;
  final String? image;
  final bool isAssetImage;
  final bool loading;
  final double fee;

  const EventCardSmall({
    Key? key,
    required this.eventID,
    required this.title,
    required this.distance,
    required this.month,
    required this.date,
    required this.fee,
    this.image,
    this.isAssetImage = false,
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
    this.isAssetImage = false,
    this.loading = true,
    this.fee = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageWidth = 176.0;
    double imageHeight = 136.0;
    return !loading
        ? Card(
            margin: const EdgeInsets.symmetric(vertical: CustomPadding.xs),
            elevation: 3.0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, EventDetail.routeName,
                    arguments: eventID);
              },
              child: SizedBox(
                width: 192.0,
                height: 208.0,
                child: Padding(
                    padding: const EdgeInsets.all(CustomPadding.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(CustomRadius.xxl)),
                          ),
                          child: isAssetImage
                              ? Container(
                                  width: imageWidth,
                                  height: imageHeight,
                                  decoration: BoxDecoration(
                                      image: image != null
                                          ? DecorationImage(
                                              image: AssetImage(image!),
                                              fit: BoxFit.cover)
                                          : null),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: CustomPadding.sm,
                                      right: CustomPadding.sm,
                                    ),
                                    child: Column(
                                      children: [
                                        DateCard(month: month, date: date)
                                      ],
                                    ),
                                  ),
                                )
                              : NetworkImageContainer(
                                  width: imageWidth,
                                  height: imageHeight,
                                  image: image,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: CustomPadding.sm,
                                      right: CustomPadding.sm,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        DateCard(month: month, date: date),
                                        const SizedBox(
                                          height: CustomPadding.xs,
                                        ),
                                        ClipRRect(
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 3.0, sigmaY: 3.0),
                                            child: Card(
                                              elevation: 0,
                                              color: neutral.shade100,
                                              margin: EdgeInsets.zero,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      CustomRadius.md),
                                                ),
                                              ),
                                              child: Container(
                                                height: 38.0,
                                                width: 38.0,
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Center(
                                                  child: Text(
                                                    fee > 0 ? "\$\$" : "FREE",
                                                    style: const TextStyle(
                                                        color: success,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            CustomFontSize.xs),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: CustomPadding.sm,
                              right: CustomPadding.sm,
                              top: 1.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Text(
                                    title,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                '${distance}km',
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
