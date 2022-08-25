import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/events/components/event_card_large.dart';
import 'package:flutter_boilerplate/events/components/home_content.dart';
import 'package:flutter_boilerplate/page/homepage.dart';
import '../../common/config/enum.dart';
import '../preference/components/preference_button.dart';

class PopularEvents extends StatefulWidget {
  const PopularEvents({Key? key}) : super(key: key);
  static const routeName = '/popular-events';

  @override
  State<PopularEvents> createState() => _PopularEventsState();
}

class _PopularEventsState extends State<PopularEvents> {
  List<bool> clickCheck = List.filled(PrefType.values.length, true);
  bool allCheck = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: SafeArea(child: buildPopularEvents()),
      ),
    );
  }

  Widget buildPopularEvents() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 54.0, left: 22.0, right: 40.0, bottom: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(right: 50.0),
                  child: IconButton(
                    icon:
                        const Icon(Icons.arrow_back, color: black, size: 35.0),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Homepage.routeName);
                    },
                  )),
              const Text(
                'Popular Events',
                style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        HomeContent(title: 'Categories', contentPadding: 25.0, contentWidgets: [
          Padding(
            padding: const EdgeInsets.only(right: 17.0),
            child: PreferenceButton(
              type: PrefType.GM,
              isAll: true,
              elevation: 4.0,
              // isAll: true,
              onPressedHandler: () {
                setState(() {
                  allCheck = !allCheck;
                });
              },
              click: allCheck,
            ),
          ),
          for (var pref in PrefType.values)
            Padding(
              padding: const EdgeInsets.only(right: 17.0),
              child: PreferenceButton(
                type: pref,
                elevation: 4.0,
                onPressedHandler: () {
                  setState(() {
                    clickCheck[pref.index] = !clickCheck[pref.index];
                  });
                },
                click: clickCheck[pref.index],
              ),
            )
        ]),
        const ShowEvents(),
      ],
    );
  }
}

class ShowEvents extends StatefulWidget {
  final String errorMessage;

  const ShowEvents({Key? key, this.errorMessage = ''}) : super(key: key);

  @override
  State<ShowEvents> createState() => _ShowEventsState();
}

class _ShowEventsState extends State<ShowEvents> {
  @override
  Widget build(BuildContext context) {
    return Column(children: const [
      EventCardLarge(
        title: 'Harry Styles with Jennie',
        author: 'Jennie Kim',
        distance: '2 km',
        location: 'Marvel Stadium, Melbourne',
        month: 'Mar',
        date: '24',
        image: 'lib/common/assets/images/LargeEventTest.png',
      ),
    ]);
  }
}
