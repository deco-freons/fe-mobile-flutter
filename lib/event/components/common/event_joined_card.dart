import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/build_loading.dart';
import 'package:flutter_boilerplate/event/components/common/event_content_card.dart';
import 'package:flutter_boilerplate/event/components/common/event_attendees.dart';
import 'package:flutter_boilerplate/event/data/common/event_participant_model.dart';
import 'package:flutter_boilerplate/page/event/event_detail.dart';

class EventJoinedCard extends StatelessWidget {
  final int eventID;
  final String title;
  final String author;
  final String month;
  final String date;
  final double distance;
  final String location;
  final EventJoinedCardType type;
  final bool isLoading;
  final List<EventParticipantModel> participants;

  final void Function(int eventID)? onCancelClick;

  const EventJoinedCard({
    Key? key,
    required this.eventID,
    required this.title,
    required this.author,
    required this.month,
    required this.date,
    required this.distance,
    required this.location,
    this.type = EventJoinedCardType.HISTORY,
    this.isLoading = false,
    this.onCancelClick,
    required this.participants,
  })  : assert(
            type == EventJoinedCardType.SCHEDULED
                ? onCancelClick != null
                : true,
            "OnCancelClick is required for type SCHEDULED"),
        super(key: key);

  const EventJoinedCard.loading(
      {Key? key,
      this.eventID = 0,
      this.title = "",
      this.author = "",
      this.month = "",
      this.date = "",
      this.distance = 0,
      this.location = "",
      this.type = EventJoinedCardType.HISTORY,
      this.isLoading = true,
      this.onCancelClick,
      this.participants = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, EventDetail.routeName,
                  arguments: eventID);
            },
            child: EventContentCard(
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
                  Padding(
                    padding: const EdgeInsets.only(
                        top: CustomPadding.sm, left: CustomPadding.base),
                    child: EventAttendees(
                      attendees: participants,
                    ),
                  ),
                  type == EventJoinedCardType.HISTORY
                      ? buildRating()
                      : buildCancel()
                ],
              ),
            ),
          )
        : BuildLoading.buildRectangularLoading(
            height: 130, borderRadius: CustomRadius.xxl);
  }

  Widget buildCancel() {
    return CustomButton(
      label: "Cancel",
      padding: const EdgeInsets.symmetric(
          vertical: CustomPadding.xs, horizontal: CustomPadding.sm),
      onPressedHandler: () {
        // HANDLE CANCEL HERE
        if (onCancelClick == null) return;
        onCancelClick!(eventID);
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