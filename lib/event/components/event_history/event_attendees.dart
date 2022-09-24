import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/layout/network_image_avatar.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class EventAttendees extends StatelessWidget {
  final List<String> attendees;
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
        .map((attendee) => const NetworkImageAvatar(
            imageUrl:
                "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80",
            radius: 12.5))
        .toList();
  }
}
