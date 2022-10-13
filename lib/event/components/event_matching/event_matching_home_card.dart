import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/build_loading.dart';
import 'package:flutter_boilerplate/event/components/common/event_card_large.dart';

class EventMatchingCardHome extends StatelessWidget {
  final String title;
  final String author;
  final double distance;
  final String location;
  final String month;
  final String date;
  final String? image;
  final bool isAssetImage;
  final VoidCallback onTapHandler;
  final bool loading;
  final bool isEventEmpty;
  final double fee;

  const EventMatchingCardHome(
      {Key? key,
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
      this.isEventEmpty = false,
      required this.fee})
      : super(key: key);

  const EventMatchingCardHome.empty({
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
    this.loading = false,
    this.isEventEmpty = false,
    this.fee = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        buildBackgroundCard(305, 346),
        buildBackgroundCard(320, 333),
        isEventEmpty
            ? Card(
                elevation: 3.0,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(CustomRadius.xxl))),
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
                          const Text(
                              'Unfortunately, there are no signs of any event nearby :(',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: CustomFontSize.lg,
                                  fontWeight: FontWeight.bold))
                        ]),
                  ),
                ),
              )
            : loading
                ? BuildLoading.buildRectangularLoading(
                    width: 330, height: 320, borderRadius: CustomRadius.xxl)
                : EventCardLarge(
                    title: title,
                    author: author,
                    distance: distance,
                    location: location,
                    month: month,
                    date: date,
                    image: image,
                    isAssetImage: isAssetImage,
                    onTapHandler: onTapHandler,
                    width: 330,
                    height: 320,
                    elevation: 3.0,
                    fee: fee,
                  )
      ],
    );
  }

  Widget buildBackgroundCard(double width, double height) {
    return Card(
      elevation: 3.0,
      color: neutral.shade400,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(CustomRadius.xxl))),
      child: SizedBox(
        width: width,
        height: height,
      ),
    );
  }
}
