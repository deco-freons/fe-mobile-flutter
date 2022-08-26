import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/components/event_info.dart';
import 'package:flutter_boilerplate/event/components/see_more.dart';

class EventDetail extends StatefulWidget {
  static const routeName = "/event-detail";
  const EventDetail({Key? key}) : super(key: key);

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  // REMEMBER TO REVERSE GEO LOCATE TO GET THE LOCATION FORM LONG LAT IN INIT STATE

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Theme.of(context).backgroundColor,
            ),
            Image.asset(
              "lib/common/assets/images/eventBG.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
            ),
            Positioned.fill(
              top: 255,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 17),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Music",
                        style: TextStyle(
                          color: neutral.shade400,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Harry Styles with Jennie",
                        style: TextStyle(
                          color: neutral.shade700,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      buildEventCreatorDetail(),
                      const SizedBox(
                        height: 25,
                      ),
                      buildParticipantsDetail(),
                      const SizedBox(
                        height: 35,
                      ),
                      const EventInfo(
                        icon: Icons.access_time_outlined,
                        title: "March 24, 2023",
                        body: "8:00 - 11:00 PM",
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      EventInfo(
                        icon: Icons.location_on_outlined,
                        title: "Melbourne, VIC",
                        body: "Marvel Stadium",
                        onTap: () {
                          // OPEN GOOGLE MAP
                        },
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      Text(
                        "About Event",
                        style: TextStyle(
                            color: neutral.shade700,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      const SeeMore(
                        text:
                            "Harry Styles Love On Tour Melbourne concert for you Harry Style’s fan Harry Styles Love On Tour Melbourne concert for you Harry Style’s fan Harry Styles Love On Tour Melbourne concert for you Harry Style’s fan",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEventCreatorDetail() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        CircleAvatar(
          radius: 12.5,
          backgroundImage:
              AssetImage("lib/common/assets/images/CircleAvatarDefault.png"),
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          "Jennie Kim",
          style: TextStyle(
              color: neutral, fontWeight: FontWeight.bold, fontSize: 16),
        )
      ],
    );
  }

  Widget buildParticipantsDetail() {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            text: "15",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: neutral.shade900,
              fontSize: 16,
            ),
            children: const <TextSpan>[
              TextSpan(
                text: " people are going",
                style: TextStyle(
                  color: neutral,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        CustomTextButton(
          text: "View All",
          fontSize: 16,
          onPressedHandler: () {
            // GO TO VIEW ALL PARTICIPANTS PAGE
          },
        ),
      ],
    );
  }
}
