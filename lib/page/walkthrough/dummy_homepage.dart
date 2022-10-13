import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_dropdown_button.dart';
import 'package:flutter_boilerplate/common/components/layout/custom_bottom_navigation.dart';
import 'package:flutter_boilerplate/common/components/layout/network_image_avatar.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/config/walkthrough_constants.dart';
import 'package:flutter_boilerplate/event/components/common/event_list.dart';
import 'package:flutter_boilerplate/event/components/common/home_content.dart';
import 'package:flutter_boilerplate/event/components/walkthrough/homepage_overlay_app_bar.dart';
import 'package:flutter_boilerplate/event/components/walkthrough/homepage_overlay_event_matching.dart';
import 'package:flutter_boilerplate/event/components/walkthrough/homepage_overlay_navbar_create_event.dart';
import 'package:flutter_boilerplate/event/components/walkthrough/homepage_overlay_notifications.dart';
import 'package:flutter_boilerplate/event/components/walkthrough/homepage_overlay_profile.dart';
import 'package:flutter_boilerplate/event/data/events_by_user/event_by_user_model.dart';
import 'package:flutter_boilerplate/preference/components/preference_button.dart';

class DummyHomepage extends StatefulWidget {
  final int index;
  const DummyHomepage({Key? key, this.index = 0}) : super(key: key);
  static const routeName = '/dummy-homepage';

  @override
  State<DummyHomepage> createState() => _DummyHomepageState();
}

class _DummyHomepageState extends State<DummyHomepage> {
  bool allCheck = true;
  DistanceFilter radiusValue = DistanceFilter.ten;
  List<DistanceFilter> radiusOptions = DistanceFilter.values;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => showOverlay());
  }

  void showOverlay() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: neutral.shade400.withOpacity(0.7),
      builder: (BuildContext context) {
        int index = widget.index;
        return StatefulBuilder(
          builder: (context, setState) {
            void nextPage() {
              setState(() {
                index = index + 1;
              });
            }

            void prevPage() {
              setState(() {
                index = index - 1;
              });
            }

            double screenWidth = MediaQuery.of(context).size.width;
            List<Widget> overlays = [
              HomepageOverlayProfile(
                  onNextPressed: nextPage, onBackPressed: () {}),
              HomepageOverlayNotification(
                  onNextPressed: nextPage, onBackPressed: prevPage),
              HomepageOverlayNavbarCreateEvent(
                  onNextPressed: nextPage, onBackPressed: prevPage),
              HomepageOverlayAppBarHomepage.homepage(
                  onNextPressed: nextPage, onBackPressed: prevPage),
              HomepageOverlayAppBarHomepage.search(
                onNextPressed: nextPage,
                onBackPressed: prevPage,
                iconPositionedLeft: screenWidth * 0.2,
                gestureIconPadding:
                    EdgeInsets.only(bottom: 70, left: screenWidth * 0.19),
              ),
              HomepageOverlayAppBarHomepage.scheduled(
                onNextPressed: nextPage,
                onBackPressed: prevPage,
                iconPositionedRight: screenWidth * 0.2,
                gestureIconPadding:
                    EdgeInsets.only(bottom: 70, right: screenWidth * 0.19),
              ),
              HomepageOverlayAppBarHomepage.history(
                onNextPressed: nextPage,
                onBackPressed: prevPage,
              ),
              HomepageOverlayEventMatching(
                onNextPressed: () {},
                onBackPressed: prevPage,
              ),
            ];
            return overlays[index];
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: Container(
        padding: const EdgeInsets.only(top: CustomPadding.lg),
        width: 80,
        height: 80,
        child: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(
              Icons.add,
              size: 50,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {}),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.secondary),
        child: SafeArea(
          child: buildDummyHome(),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: 0,
        onTap: (i) {},
        children: const <Icon>[
          Icon(Icons.home_outlined),
          Icon(Icons.search_outlined),
          Icon(Icons.edit_calendar_outlined),
          Icon(Icons.history_outlined)
        ],
      ),
    );
  }

  Widget buildDummyHome() {
    return ListView(
      children: [
        SizedBox(
          height: appBarHeight,
          child: Padding(
            padding: const EdgeInsets.only(
                left: CustomPadding.body, right: CustomPadding.body),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  child: const NetworkImageAvatar(imageUrl: null, radius: 23),
                ),
                Builder(builder: (context) {
                  return InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.notifications_outlined,
                      size: 45.0,
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        HomeContent(
            title: 'Featured',
            isPair: true,
            isCentered: true,
            secondWidget: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: neutral.shade500)),
              child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: CustomDropdownButton(
                    options: radiusOptions,
                    texts: radiusValue.descList,
                    initialValue: radiusValue,
                    callback: (newValue) {
                      radiusValue = newValue;
                    },
                  )),
            ),
            contentWidgets: [exampleFeaturedEventCard]),
        const SizedBox(
          height: 32,
        ),
        HomeContent(title: 'Categories', contentWidgets: [
          PreferenceButton(
            type: PrefType.GM,
            isAll: true,
            elevation: 4.0,
            onPressedHandler: () {},
            isActive: allCheck,
          ),
          for (PrefType pref in PrefType.values)
            PreferenceButton(
                type: pref,
                elevation: 4.0,
                onPressedHandler: () {},
                isActive: !allCheck)
        ]),
        const SizedBox(
          height: 22,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: CustomPadding.xxxl),
          child: EventList(
            title: "Popular events",
            isLoading: false,
            isAssetImage: true,
            events: exampleEvents
                .map(
                  (event) => EventByUserModel(
                    eventID: event.eventID,
                    eventName: event.eventName,
                    distance: event.distance,
                    date: event.date,
                    latitude: event.latitude,
                    longitude: event.longitude,
                    eventImage: event.eventImage,
                    eventPrice: event.eventPrice,
                  ),
                )
                .toList(),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
