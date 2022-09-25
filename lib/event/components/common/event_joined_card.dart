import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/components/common/event_content_card.dart';
import 'package:flutter_boilerplate/event/components/event_history/event_attendees.dart';

class EventJoinedCard extends StatelessWidget {
  final String title;
  final String author;
  final String month;
  final String date;
  final double distance;
  final String location;
  final EventJoinedCardType type;
  final Widget? bottomContent;

  const EventJoinedCard({
    Key? key,
    required this.title,
    required this.author,
    required this.month,
    required this.date,
    required this.distance,
    required this.location,
    this.bottomContent,
    this.type = EventJoinedCardType.HISTORY,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EventContentCard(
      title: title,
      month: month,
      date: date,
      distance: distance,
      location: location,
      author: author,
      color: neutral.shade100,
      elevation: 7,
      verticalPadding: CustomPadding.base,
      bottomContent: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(
                top: CustomPadding.sm, left: CustomPadding.base),
            child: EventAttendees(
              attendees: ["a", "b", "c", "d", "e"],
            ),
          ),
          type == EventJoinedCardType.HISTORY ? buildRating() : buildCancel()
        ],
      ),
    );
  }

  Widget buildCancel() {
    return CustomButton(
      label: "Cancel",
      padding: const EdgeInsets.symmetric(
          vertical: CustomPadding.xs, horizontal: CustomPadding.sm),
      onPressedHandler: () {
        // HANDLE CANCEL HERE
      },
      labelFontSize: CustomFontSize.sm,
      height: 0,
      width: 0,
      type: ButtonType.red,
    );
  }

  Widget buildRating() {
    return Padding(
      padding: const EdgeInsets.only(right: CustomPadding.base),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.star,
            color: primary,
          ),
          Text(
            "5.0",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: CustomFontSize.sm),
          )
        ],
      ),
    );
  }
}
