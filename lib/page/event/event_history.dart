import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/layout/page_app_bar.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/components/common/event_joined_card.dart';

class EventHistory extends StatefulWidget {
  const EventHistory({Key? key}) : super(key: key);
  static const routeName = "/history";

  @override
  State<EventHistory> createState() => _EventHistoryState();
}

class _EventHistoryState extends State<EventHistory>
    with AutomaticKeepAliveClientMixin<EventHistory> {
  bool keepAlive = true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: neutral.shade100,
      appBar: const PageAppBar(title: "History"),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(
            horizontal: CustomPadding.body, vertical: CustomPadding.base),
        itemCount: 3,
        itemBuilder: (context, index) {
          return const EventJoinedCard(
            title: "Title",
            author: "author",
            month: "month",
            date: "date",
            distance: 12,
            location: "location",
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: CustomPadding.xxl,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => keepAlive;
}
