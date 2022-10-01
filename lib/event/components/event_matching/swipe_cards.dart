import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_chip.dart';
import 'package:flutter_boilerplate/common/components/layout/network_image_container.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/components/common/event_info.dart';
import 'package:flutter_boilerplate/event/components/event_matching/card_provider.dart';
import 'package:flutter_boilerplate/event/components/common/see_more.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SwipeCards extends StatefulWidget {
  final int eventID;
  final String eventName;
  final int participants;
  final String date;
  final String startTime;
  final String endTime;
  final String suburb;
  final String city;
  final String shortDescription;
  final String locationName;
  final double distance;
  final String? image;
  final bool isEventEmpty;
  final bool isFront;
  final int fee;

  const SwipeCards({
    Key? key,
    this.isEventEmpty = false,
    required this.eventID,
    required this.eventName,
    required this.participants,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.suburb,
    required this.city,
    required this.shortDescription,
    required this.locationName,
    required this.distance,
    this.image,
    required this.isFront,
    required this.fee,
  }) : super(key: key);

  const SwipeCards.empty({
    Key? key,
    this.eventID = 0,
    this.isEventEmpty = true,
    this.eventName = "",
    this.participants = 0,
    this.date = "",
    this.startTime = "",
    this.endTime = "",
    this.suburb = "",
    this.city = "",
    this.shortDescription = "",
    this.locationName = "",
    this.distance = 0,
    this.image,
    this.isFront = false,
    this.fee = 0,
  }) : super(key: key);

  @override
  State<SwipeCards> createState() => _SwipeCardsState();
}

class _SwipeCardsState extends State<SwipeCards> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;

      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.setScreenSize(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.isFront ? buildFrontCard() : buildCard();
  }

  Widget buildFrontCard() {
    return GestureDetector(
      child: Builder(builder: (context) {
        final provider = Provider.of<CardProvider>(context);
        final position = provider.position;
        int milliseconds = provider.isDragging ? 0 : 400;

        return AnimatedContainer(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: milliseconds),
            transform: Matrix4.identity()..translate(position.dx),
            child: buildCard());
      }),
      onPanStart: (details) {
        final provider = Provider.of<CardProvider>(context, listen: false);
        provider.startPosition(details);
      },
      onPanUpdate: (details) {
        final provider = Provider.of<CardProvider>(context, listen: false);
        provider.updatePosition(details);
      },
      onPanEnd: (details) {
        final provider = Provider.of<CardProvider>(context, listen: false);
        provider.endPosition();
      },
    );
  }

  Widget buildCard() {
    return !widget.isEventEmpty
        ? Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(CustomRadius.xxl),
                boxShadow: [
                  BoxShadow(
                    color: neutral.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 4,
                  )
                ]),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(CustomRadius.xxl),
              ),
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(CustomPadding.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(CustomRadius.xxl),
                        child: NetworkImageContainer(
                          height: 220.0,
                          image: widget.image,
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: Padding(
                          padding: const EdgeInsets.all(CustomPadding.base),
                          child: CustomChip(
                            label: "Upcoming",
                          ),
                        ),
                      )
                    ]),
                    const SizedBox(
                      height: 15,
                    ),
                    _buildEventName(widget.eventName),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildParticipantsDetail(widget.participants),
                    const SizedBox(
                      height: 20,
                    ),
                    EventInfo(
                      icon: Icons.access_time_outlined,
                      title: DateFormat('MMMM dd, yyyy')
                          .format(DateTime.parse(widget.date)),
                      titleFontSize: CustomFontSize.sm,
                      bodyFontSize: CustomFontSize.base,
                      iconBoxSize: 40,
                      iconSize: 20,
                      body: '${widget.startTime} - ${widget.endTime}',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    EventInfo(
                      icon: Icons.location_on_outlined,
                      title: "${widget.suburb}, ${widget.city}",
                      body: widget.locationName,
                      titleFontSize: CustomFontSize.sm,
                      bodyFontSize: CustomFontSize.base,
                      iconBoxSize: 40,
                      iconSize: 20,
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "About Event",
                      style: TextStyle(
                          color: neutral.shade700,
                          fontSize: CustomFontSize.md,
                          fontWeight: FontWeight.bold),
                    ),
                    _buildEventDescription(widget.shortDescription),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomChip(label: '${widget.distance} km'),
                        const SizedBox(
                          width: CustomPadding.md,
                        ),
                        CustomChip(
                            color: success,
                            label: widget.fee > 0 ? "\$${widget.fee}" : "FREE")
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        : Container(
            width: 342,
            height: 500,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(CustomRadius.xxl),
                boxShadow: [
                  BoxShadow(
                    color: neutral.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 4,
                  )
                ]),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(CustomRadius.xxl),
              ),
              margin: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('lib/common/assets/images/WhoopsImage.png'),
                  const SizedBox(
                    height: 55,
                  ),
                  const Text(
                    "Whoops....",
                    style: TextStyle(
                        fontSize: CustomFontSize.lg,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "No more event nearby",
                    style: TextStyle(
                        fontSize: CustomFontSize.md,
                        fontWeight: FontWeight.bold,
                        color: neutral),
                  )
                ],
              ),
            ),
          );
  }

  Widget _buildEventName(String eventName) {
    return Text(
      eventName,
      style: TextStyle(
        color: neutral.shade700,
        fontSize: CustomFontSize.md,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildParticipantsDetail(int participantsCount) {
    return RichText(
      text: TextSpan(
        text: participantsCount.toString(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: neutral.shade900,
          fontSize: CustomFontSize.sm,
        ),
        children: const <TextSpan>[
          TextSpan(
            text: " people are going",
            style: TextStyle(
              fontSize: CustomFontSize.sm,
              color: neutral,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventDescription(String shortDescription) {
    return SeeMore(
      text: shortDescription == "-" ? "No description" : shortDescription,
      characterLimit: 140,
      fontSize: CustomFontSize.sm,
    );
  }
}
