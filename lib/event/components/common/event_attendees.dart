import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/layout/network_image_avatar.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/data/common/event_participant_model.dart';

class EventAttendees extends StatelessWidget {
  final List<EventParticipantModel> attendees;
  const EventAttendees({Key? key, required this.attendees}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 1.0,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ...buildImageAvatars(),
        const SizedBox(
          width: 5,
        ),
        attendees.length > 3
            ? Text(
                "+${attendees.length - 3} More",
                style: TextStyle(
                    fontSize: CustomFontSize.xs, color: neutral.shade500),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  List<Widget> buildImageAvatars() {
    return attendees
        .take(3)
        .map((attendee) => NetworkImageAvatar(
            imageUrl: attendee.userImage?.imageUrl, radius: 12.5))
        .toList();
  }
}
