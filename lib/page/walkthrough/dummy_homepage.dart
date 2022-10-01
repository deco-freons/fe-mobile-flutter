import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_dropdown_button.dart';
import 'package:flutter_boilerplate/common/components/layout/custom_bottom_navigation.dart';
import 'package:flutter_boilerplate/common/components/layout/network_image_avatar.dart';
import 'package:flutter_boilerplate/common/components/layout/walkthrough_text_box.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/data/image_model.dart';
import 'package:flutter_boilerplate/event/components/common/event_list.dart';
import 'package:flutter_boilerplate/event/components/event_matching/event_matching_home_card.dart';
import 'package:flutter_boilerplate/event/components/common/home_content.dart';
import 'package:flutter_boilerplate/event/data/common/event_currency_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_location_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_participant_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_price_response_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_status_model.dart';
import 'package:flutter_boilerplate/event/data/events_by_user/event_by_user_model.dart';
import 'package:flutter_boilerplate/page/walkthrough/dummy_event_matching.dart';
import 'package:flutter_boilerplate/preference/components/preference_button.dart';

class DummyHomepage extends StatefulWidget {
  const DummyHomepage({Key? key}) : super(key: key);
  static const routeName = '/dummy-homepage';

  @override
  State<DummyHomepage> createState() => _DummyHomepageState();
}

class _DummyHomepageState extends State<DummyHomepage> {
  bool allCheck = true;
  DistanceFilter radiusValue = DistanceFilter.ten;
  List<DistanceFilter> radiusOptions = DistanceFilter.values;
  EventMatchingCardHome featuredEventCard = EventMatchingCardHome(
    title: "Harry Styles with Jennie",
    author: "Jennie Kim",
    distance: 2,
    location: 'Marvel Stadium, Melbourne',
    month: "Mar",
    date: "24",
    image: "lib/common/assets/images/LargeEventImage.png",
    isAssetImage: true,
    fee: 0,
    onTapHandler: () {},
  );
  List<EventModel> events = [
    const EventModel(
      eventID: 1,
      eventName: "Live Music at City Hall",
      date: "2000-12-12",
      distance: 2,
      longitude: 13,
      latitude: 13,
      eventCreator: EventParticipantModel(
          username: "creator1", firstName: "Dwayne", lastName: "Johnson"),
      location: EventLocationModel(suburb: "Brisbane City", city: "Brisbane"),
      locationName: "City Hall",
      participants: 12,
      eventStatus: EventStatusModel(statusName: EventStatus.COMING_SOON),
      eventImage: ImageModel(
          imageUrl: "lib/common/assets/images/SmallEventImageBand.png"),
      eventPrice: EventPriceResponseModel(
        priceID: 0,
        fee: 20,
        currency: EventCurrencyModel(currencyShortName: "AU\$"),
      ),
    ),
    const EventModel(
      eventID: 2,
      eventName: "Dessert Crawl at West End",
      date: "2023-06-04",
      distance: 3,
      longitude: 12,
      latitude: 12,
      eventCreator: EventParticipantModel(
          username: "creator1", firstName: "Zahra", lastName: "Abraara"),
      location: EventLocationModel(suburb: "West End", city: "Brisbane"),
      locationName: "Kings George Station",
      participants: 10,
      eventStatus: EventStatusModel(statusName: EventStatus.COMING_SOON),
      eventImage: ImageModel(
          imageUrl: "lib/common/assets/images/SmallEventImageCake.png"),
      eventPrice: EventPriceResponseModel(
        priceID: 0,
        fee: 20,
        currency: EventCurrencyModel(currencyShortName: "AU\$"),
      ),
    ),
  ];

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
        return WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: CustomPadding.lg),
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 120),
                  child: ListView(shrinkWrap: true, children: [
                    Container(
                      decoration: BoxDecoration(
                        color: neutral.shade100,
                        borderRadius: BorderRadius.circular(CustomRadius.xxl),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: CustomPadding.sm),
                      child: HomeContent(
                          title: '',
                          isCentered: true,
                          onlyContent: true,
                          contentWidgets: [featuredEventCard]),
                    ),
                  ]),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 440),
                    child: Image.asset(
                        "lib/common/assets/images/TapGestureIcon.png"),
                  ),
                ),
                WalkthroughTextBox(
                  topMargin: 550,
                  text: "Click here to see what we've curated for you!",
                  buttonText: "Next",
                  onTapHandler: () {
                    Navigator.of(context)
                        .pushNamed(DummyEventMatching.routeName);
                  },
                ),
              ]),
            ),
          ),
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
                  child: const NetworkImageAvatar(imageUrl: null, radius: 25),
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
            contentWidgets: [featuredEventCard]),
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
            events: events
                .map((event) => EventByUserModel(
                    eventID: event.eventID,
                    eventName: event.eventName,
                    distance: event.distance,
                    date: event.date,
                    latitude: event.latitude,
                    longitude: event.longitude,
                    eventImage: event.eventImage))
                .toList(),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
