import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/event/data/event_participant_model.dart';

class EventParticipants extends StatefulWidget {
  static const routeName = "/event-participants";
  final List<EventParticipantModel> participants;
  const EventParticipants({Key? key, required this.participants})
      : super(key: key);

  @override
  State<EventParticipants> createState() => _EventParticipantsState();
}

class _EventParticipantsState extends State<EventParticipants> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
