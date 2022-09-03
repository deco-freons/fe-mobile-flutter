import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/layout/page_app_bar.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/components/event_card_small.dart';
import 'package:flutter_boilerplate/event/components/home_content.dart';
import 'package:flutter_boilerplate/preference/data/preference_model.dart';
import 'package:flutter_boilerplate/profile/components/profile_field.dart';
import 'package:flutter_boilerplate/profile/components/user_interests_chips.dart';

class FriendProfile extends StatelessWidget {
  static const routeName = "friend-profile";

  final int userID;
  const FriendProfile({Key? key, required this.userID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget spacing = const SizedBox(
      height: 38,
    );
    return Scaffold(
      backgroundColor: neutral.shade100,
      appBar: const PageAppBar(title: "Kim Ji-soo", hasBackButton: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: CustomPadding.base),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 75,
                backgroundImage: AssetImage(
                    'lib/common/assets/images/CircleAvatarDefault.png'),
              ),
            ),
            buildField("Username", "jisoo"),
            buildField("Location", "Brisbane City"),
            spacing,
            buildInterests(),
            spacing,
            HomeContent(
              title: "Events by Me",
              titleBottomSpacing: CustomPadding.sm,
              isSeeAll: true,
              contentWidgets: List.filled(
                3,
                const EventCardSmall.loading(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildField(String label, String value) {
    return Padding(
        padding: bodyPadding, child: ProfileField(label: label, value: value));
  }

  Widget buildInterests() {
    return Padding(
      padding: bodyPadding,
      child: UserInterestChips(preferences: [
        PreferenceModel(preferenceID: "CL", preferenceName: PrefType.CL.desc),
        PreferenceModel(preferenceID: "DC", preferenceName: PrefType.DC.desc)
      ]),
    );
  }
}
