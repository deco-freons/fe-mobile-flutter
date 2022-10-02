import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/layout/network_image_container.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/build_loading.dart';
import 'package:flutter_boilerplate/event/components/common/event_content_card.dart';

class EventCardLarge extends StatelessWidget {
  final String title;
  final String author;
  final double distance;
  final String location;
  final String month;
  final String date;
  final String? image;
  final bool isAssetImage;
  final double width;
  final double height;
  final VoidCallback onTapHandler;
  final double elevation;
  final bool loading;
  final double fee;

  const EventCardLarge({
    Key? key,
    required this.title,
    required this.author,
    required this.distance,
    required this.location,
    required this.month,
    required this.date,
    this.image,
    this.isAssetImage = false,
    required this.onTapHandler,
    this.loading = false,
    this.width = 340.0,
    this.height = 256.0,
    this.elevation = 8.0,
    required this.fee,
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
    this.isAssetImage = false,
    required this.onTapHandler,
    this.loading = true,
    this.width = 340.0,
    this.height = 256.0,
    this.elevation = 8.0,
    this.fee = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !loading
        ? Card(
            margin: EdgeInsets.zero,
            elevation: elevation,
            shadowColor: neutral.shade700,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(CustomRadius.xxl))),
            child: InkWell(
              onTap: onTapHandler,
              child: isAssetImage
                  ? Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                          image: image != null
                              ? DecorationImage(
                                  image: AssetImage(image!), fit: BoxFit.cover)
                              : null),
                      child: buildContent(),
                    )
                  : NetworkImageContainer(
                      width: width,
                      height: height,
                      image: image,
                      emptyImageIconTopPadding: height / 7,
                      child: buildContent()),
            ),
          )
        : BuildLoading.buildRectangularLoading(
            width: 342, height: 257, borderRadius: 20);
  }

  Widget buildContent() {
    return Padding(
      padding: const EdgeInsets.only(bottom: CustomPadding.md),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: CustomPadding.md),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: EventContentCard(
              author: author,
              title: title,
              month: month,
              date: date,
              distance: distance,
              location: location,
              width: 312.0,
              fee: fee,
              color: image == null ? neutral.shade100.withOpacity(0.4) : null,
            ),
          ),
        ),
      ),
    );
  }
}
