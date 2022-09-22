import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/components/event_card_small.dart';
import 'package:flutter_boilerplate/event/components/home_content.dart';
import 'package:flutter_boilerplate/event/components/no_events_card.dart';
import 'package:flutter_boilerplate/event/data/event_by_user_model.dart';
import 'package:intl/intl.dart';

class EventList extends StatelessWidget {
  final List<EventByUserModel> events;
  final VoidCallback onPressed;
  final bool isLoading;
  final String title;
  const EventList(
      {Key? key,
      required this.events,
      required this.onPressed,
      required this.isLoading,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeContent(
        title: title,
        titleBottomSpacing: CustomPadding.xs,
        isPair: true,
        secondWidget: CustomTextButton(
            text: 'See All >',
            fontSize: CustomFontSize.sm,
            type: TextButtonType.tertiary,
            onPressedHandler: onPressed),
        contentWidgets: isLoading
            ? List.filled(
                3,
                const Padding(
                  padding: EdgeInsets.only(
                      left: CustomPadding.sm, top: CustomPadding.xs),
                  child: EventCardSmall.loading(),
                ),
              )
            : events.isEmpty
                ? List.filled(1, const NoEventsCard())
                : events.map((event) {
                    String formattedDate = DateFormat('MMMM dd, yyyy')
                        .format(DateTime.parse(event.date));
                    List<String> splittedDate = formattedDate.split(' ');
                    return EventCardSmall(
                        eventID: event.eventID,
                        title: event.eventName,
                        distance: event.distance,
                        month: splittedDate[0].substring(0, 3),
                        date: splittedDate[1].substring(0, 2),
                        image: 'lib/common/assets/images/SmallEventTest.png');
                  }).toList());
  }
}
