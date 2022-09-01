import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_back_button.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
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
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 96,
        backgroundColor: neutral.shade700,
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: bodyPadding - 4.5),
          child: CustomBackButton(onPressed: () {
            Navigator.of(context).pop();
          }),
        ),
        title: Text(
          "Participants",
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: neutral.shade900),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: screenBodyPadding,
          child: ListView.builder(
              itemCount: participants.length,
              itemBuilder: (context, index) {
                return const Text("AAA");
              }),
        ),
      ),
    );
  }
}
