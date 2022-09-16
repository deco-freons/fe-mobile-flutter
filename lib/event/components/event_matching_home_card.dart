import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/build_loading.dart';
import 'package:flutter_boilerplate/event/components/date_card.dart';

class EventMatchingCardHome extends StatelessWidget {
  final String title;
  final String author;
  final double distance;
  final String location;
  final String month;
  final String date;
  final String image;
  final VoidCallback onTapHandler;
  final bool loading;
  final bool isEventEmpty;

  const EventMatchingCardHome(
      {Key? key,
      required this.title,
      required this.author,
      required this.distance,
      required this.location,
      required this.month,
      required this.date,
      required this.image,
      required this.onTapHandler,
      this.loading = false,
      this.isEventEmpty = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !loading
        ? Stack(alignment: AlignmentDirectional.topCenter, children: [
            Card(
              elevation: 3.0,
              color: neutral.shade400,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(CustomRadius.xxl))),
              child: const SizedBox(
                width: 305.0,
                height: 346.0,
              ),
            ),
            Card(
              elevation: 3.0,
              color: neutral.shade400,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(CustomRadius.xxl))),
              child: const SizedBox(
                width: 320.0,
                height: 333.0,
              ),
            ),
            isEventEmpty
                ? Card(
                    elevation: 3.0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(CustomRadius.xxl))),
                    child: SizedBox(
                      width: 330.0,
                      height: 320.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'lib/common/assets/images/NoResult.png',
                                width: 70,
                                height: 70,
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              const Text('Hmm, no sign of any events',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: CustomFontSize.lg,
                                      fontWeight: FontWeight.bold))
                            ]),
                      ),
                    ),
                  )
                : Card(
                    elevation: 3.0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(CustomRadius.xxl))),
                    child: InkWell(
                      onTap: onTapHandler,
                      child: Container(
                        width: 330.0,
                        height: 320.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(image), fit: BoxFit.cover)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(bottom: CustomPadding.base),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ClipRRect(
                              child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 2.5, sigmaY: 2.5),
                                  child: Container(
                                    width: 300.0,
                                    height: 96.0,
                                    decoration: BoxDecoration(
                                        color:
                                            neutral.shade400.withOpacity(0.6),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(CustomRadius.xxl))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                          CustomPadding.xs),
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
                                                        fontSize:
                                                            CustomFontSize.sm,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                  ),
          ])
        : BuildLoading.buildRectangularLoading(
            width: 320, height: 320, borderRadius: CustomRadius.xxl);
  }
}
