import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/layout/page_app_bar.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/components/common/event_content_card.dart';

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
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return EventContentCard(
            title: "Title",
            month: "Month",
            date: "data",
            distance: 12,
            location: "locatio",
            author: "autho",
            color: neutral.shade100,
            elevation: 7,
            verticalPadding: CustomPadding.base,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 30,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => keepAlive;
}
