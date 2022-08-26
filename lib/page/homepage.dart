import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/page/create_event.dart';
import 'package:flutter_boilerplate/page/profile.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);
  static const routeName = '/homepage';

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.secondary),
        child: SafeArea(child: buildProfile()),
      ),
    );
  }

  Widget buildProfile() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      children: [
        Row(
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
              onPressed: () {
                Navigator.pushNamed(context, CreateEvent.routeName);
              },
              icon: const Icon(Icons.notifications_outlined),
            ),
          ],
        ),
      ],
    );
  }
}
