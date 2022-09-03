import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/layout/page_app_bar.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/components/participant_card.dart';
import 'package:flutter_boilerplate/event/data/event_participant_model.dart';

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
        hasBackButton: true,
      ),
      body: SafeArea(
        child: ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(height: 37);
            },
            itemCount: participants.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: CustomPadding.body,
                    right: CustomPadding.body,
                    top: index == 0 ? CustomPadding.body : 0),
                child: ParticipantCard(
                    firstName: participants[index].firstName,
                    lastName: participants[index].lastName,
                    location: participants[index].location?.suburb ?? ""),
              );
            }),
      ),
    );
  }
}
