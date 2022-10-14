import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/layout/page_app_bar.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/components/event_detail/participant_card.dart';
import 'package:flutter_boilerplate/event/data/common/event_participant_model.dart';
import 'package:flutter_boilerplate/page/user/friend_profile.dart';

class EventParticipants extends StatelessWidget {
  static const routeName = "/event-participants";
  final List<EventParticipantModel> participants;
  const EventParticipants({Key? key, required this.participants})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral.shade100,
      appBar: const PageAppBar(
        title: "Participants",
        hasLeadingWidget: true,
        // subTitle: "Don't worry, you're not going to be alone!",
      ),
      body: SafeArea(
        child: ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(height: 37);
            },
            itemCount: participants.length + 1,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: CustomPadding.body,
                    right: CustomPadding.body,
                    top: index == 0 ? CustomPadding.body : 0,
                    bottom:
                        index == participants.length ? CustomPadding.body : 0),
                child: index == 0
                    ? Text(
                        "Don't worry, you're not going to be alone!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: neutral.shade500,
                          fontSize: CustomFontSize.md,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : ParticipantCard(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            FriendProfile.routeName,
                            arguments: participants[index].userID,
                          );
                        },
                        userImage: participants[index - 1].userImage?.imageUrl,
                        firstName: participants[index - 1].firstName,
                        lastName: participants[index - 1].lastName,
                        location:
                            participants[index - 1].location?.suburb ?? ""),
              );
            }),
      ),
    );
  }
}
