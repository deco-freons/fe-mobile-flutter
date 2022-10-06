import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/components/layout/network_image_avatar.dart';
import 'package:flutter_boilerplate/common/components/layout/shimmer_widget.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/build_loading.dart';
import 'package:flutter_boilerplate/event/data/event_detail/event_detail_model.dart';
import 'package:flutter_boilerplate/page/event/event_participants.dart';

class EventDetailParticipants extends StatelessWidget {
  final EventDetailModel? event;
  const EventDetailParticipants({Key? key, required this.event})
      : super(key: key);

  const EventDetailParticipants.loading({Key? key})
      : event = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        event != null
            ? RichText(
                text: TextSpan(
                  text: event!.participants.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: neutral.shade900,
                    fontSize: CustomFontSize.base,
                  ),
                  children: const <TextSpan>[
                    TextSpan(
                      text: " people are going:",
                      style: TextStyle(
                        color: neutral,
                      ),
                    ),
                  ],
                ),
              )
            : BuildLoading.buildRectangularLoading(
                height: 16, width: 150, verticalPadding: 3),
        const SizedBox(
          width: 15,
        ),
        ...buildAvatars(),
        const Spacer(),
        event != null
            ? CustomTextButton(
                text: "View All",
                fontSize: CustomFontSize.base,
                onPressedHandler: () {
                  // GO TO VIEW ALL PARTICIPANTS PAGE
                  Navigator.of(context).pushNamed(EventParticipants.routeName,
                      arguments: event!.participantsList);
                },
              )
            : BuildLoading.buildRectangularLoading(
                height: 25, width: 65, verticalPadding: 3)
      ],
    );
  }

  List<Widget> buildAvatars() {
    return event != null
        ? event!.participantsList
            .take(3)
            .map(
              (participant) => Padding(
                  padding: const EdgeInsets.all(1),
                  child: NetworkImageAvatar(
                      imageUrl: participant.userImage?.imageUrl, radius: 10)),
            )
            .toList()
        : List<Widget>.generate(
            3,
            (x) => const Padding(
                  padding: EdgeInsets.all(1),
                  child: ShimmerWidget.circular(width: 20, height: 20),
                ));
  }
}
