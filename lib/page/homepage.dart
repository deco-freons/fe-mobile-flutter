import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/events/components/event_card_small.dart';
import 'package:flutter_boilerplate/events/components/home_content.dart';
import 'package:flutter_boilerplate/page/profile.dart';
import 'package:flutter_boilerplate/preference/components/preference_button.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);
  static const routeName = '/homepage';

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<bool> clickCheck = List.filled(PrefType.values.length, true);
  bool allCheck = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.secondary),
        child: SafeArea(child: buildHome()),
      ),
    );
  }

  Widget buildHome() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                iconSize: 50.0,
                onPressed: () {
                  Navigator.pushNamed(context, Profile.routeName);
                },
                icon: CircleAvatar(
                  radius: 25.0,
                  child: Image.asset(
                      'lib/common/assets/images/CircleAvatarDefault.png'),
                ),
              ),
              IconButton(
                iconSize: 45.0,
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: HomeContent(title: 'Featured', contentWidgets: [
            Center(
              child: SizedBox(
                width: 322.0,
                height: 343.0,
                child: DecoratedBox(
                    decoration: BoxDecoration(color: grey.shade400)),
              ),
            ),
          ]),
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
        const HomeContent(
            title: 'Popular events',
            isPopular: true,
            contentPadding: 17.0,
            titlePadding: 0.0,
            contentWidgets: [
              EventCardSmall(
                title: 'Live music at city hall',
                distance: '2 km',
                month: 'Mar',
                date: '24',
                image: 'lib/common/assets/images/SmallEventTest.png',
              ),
              EventCardSmall(
                title: 'Live music at city hall',
                distance: '2 km',
                month: 'Mar',
                date: '24',
                image: 'lib/common/assets/images/SmallEventTest.png',
              ),
              EventCardSmall(
                title: 'Live music at city hall',
                distance: '2 km',
                month: 'Mar',
                date: '24',
                image: 'lib/common/assets/images/SmallEventTest.png',
              ),
              EventCardSmall(
                title: 'Live music at city hall',
                distance: '2 km',
                month: 'Mar',
                date: '24',
                image: 'lib/common/assets/images/SmallEventTest.png',
              ),
              EventCardSmall(
                title: 'Live music at city hall',
                distance: '2 km',
                month: 'Mar',
                date: '24',
                image: 'lib/common/assets/images/SmallEventTest.png',
              ),
            ])
      ],
    );
  }
}
