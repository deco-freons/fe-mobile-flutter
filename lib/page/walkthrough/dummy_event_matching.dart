import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_chip.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_dropdown_button.dart';
import 'package:flutter_boilerplate/common/components/layout/page_app_bar.dart';
import 'package:flutter_boilerplate/common/components/layout/walkthrough_text_box.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/config/walkthrough_constants.dart';
import 'package:flutter_boilerplate/event/components/common/event_info.dart';
import 'package:flutter_boilerplate/event/components/common/see_more.dart';
import 'package:flutter_boilerplate/event/components/walkthrough/walkthrough_overlay.dart';
import 'package:flutter_boilerplate/event/data/event_matching/event_matching_response_model.dart';
import 'package:flutter_boilerplate/page/dashboard.dart';
import 'package:flutter_boilerplate/page/walkthrough/dummy_homepage.dart';
import 'package:intl/intl.dart';

class DummyEventMatching extends StatefulWidget {
  const DummyEventMatching({Key? key}) : super(key: key);
  static const routeName = '/dummy-event-matching';

  @override
  State<DummyEventMatching> createState() => _DummyEventMatchingState();
}

class _DummyEventMatchingState extends State<DummyEventMatching> {
  final List<DistanceFilter> radiusOptions = DistanceFilter.values;
  final DistanceFilter radiusValue = DistanceFilter.ten;

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
        bool secondPage = false;
        return StatefulBuilder(
            builder: (context, setState) => WalkthroughOverlay(
                    handleWillPop: () {
                      if (secondPage) {
                        setState(() {
                          secondPage = false;
                        });
                      } else {
                        Navigator.of(context)
                            .pushNamed(DummyHomepage.routeName, arguments: 7);
                      }
                    },
                    children: [
                      Align(
                        alignment:
                            secondPage ? Alignment.topLeft : Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 350),
                          child: Image.asset(secondPage
                              ? "lib/common/assets/images/SwipeLeftGestureIcon.png"
                              : "lib/common/assets/images/SwipeRightGestureIcon.png"),
                        ),
                      ),
                      WalkthroughTextBox(
                          topMargin: 540,
                          text: secondPage
                              ? "If you're not interested in joining this event, swipe left or click the X button."
                              : "If you're interested in joining this event, swipe right or click the heart button.",
                          buttonText: secondPage ? "Finish" : "Next",
                          onTapHandler: () {
                            if (secondPage) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                Dashboard.routeName,
                                (route) => false,
                              );
                            } else {
                              setState(() {
                                secondPage = true;
                              });
                            }
                          }),
                      buildButtons(!secondPage, false),
                      buildButtons(secondPage, true),
                    ])
            );
      },
    );
  }

  Widget buildButtons(bool isOverlayOn, bool isLeft) {
    return Positioned(
      bottom: 40,
      left: isLeft ? 60 : null,
      right: isLeft ? null : 60,
      child: Stack(children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {},
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                color: isLeft ? error : primary,
                borderRadius: BorderRadius.circular(100)),
            child: isLeft
                ? Icon(
                    Icons.close_rounded,
                    color: neutral.shade100,
                    size: 50,
                  )
                : ImageIcon(
                    const AssetImage('lib/common/assets/images/HeartIcon.png'),
                    color: neutral.shade100,
                  ),
          ),
        ),
        isOverlayOn
            ? const SizedBox.shrink()
            : Container(
                decoration: BoxDecoration(
                    color: neutral.shade400.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(100)),
                width: 70,
                height: 70,
              ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral.shade100,
      resizeToAvoidBottomInset: true,
      appBar: PageAppBar(
        title: "Featured",
        hasLeadingWidget: true,
        widget: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: CustomPadding.base, horizontal: CustomPadding.sm),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: neutral.shade500)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: CustomDropdownButton(
                  options: radiusOptions,
                  texts: radiusValue.descList,
                  initialValue: radiusValue,
                  callback: (newValue) {},
                ),
              ),
            ),
          );
        }),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: CustomPadding.xxl),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 70 / 100),
              child: buildCards(exampleEventMatching),
            ),
          ]),
        ),
      ),
    );
  }

  Widget buildCards(List<EventMatchingResponseModel> events) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: CustomPadding.md),
      child: Stack(
        children: events.map((event) => buildCard(event)).toList(),
      ),
    );
  }

  Widget buildCard(EventMatchingResponseModel event) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(CustomRadius.xxl),
          boxShadow: [
            BoxShadow(
              color: neutral.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
            )
          ]),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CustomRadius.xxl),
        ),
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(CustomPadding.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(CustomRadius.xxl),
                    child: Container(
                      height: 220.0,
                      decoration: BoxDecoration(
                          image: event.eventImage != null
                              ? DecorationImage(
                                  image: AssetImage(event.eventImage!.imageUrl),
                                  fit: BoxFit.cover)
                              : null),
                    )),
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Padding(
                    padding: const EdgeInsets.all(CustomPadding.base),
                    child: CustomChip(
                      label: "Upcoming",
                    ),
                  ),
                )
              ]),
              const SizedBox(
                height: 15,
              ),
              _buildEventName(event.eventName),
              const SizedBox(
                height: 10,
              ),
              _buildParticipantsDetail(event.participants),
              const SizedBox(
                height: 20,
              ),
              EventInfo(
                icon: Icons.access_time_outlined,
                title: DateFormat('MMMM dd, yyyy')
                    .format(DateTime.parse(event.date)),
                titleFontSize: CustomFontSize.sm,
                bodyFontSize: CustomFontSize.base,
                iconBoxSize: 40,
                iconSize: 20,
                body: '${event.startTime} - ${event.endTime}',
              ),
              const SizedBox(
                height: 10,
              ),
              EventInfo(
                icon: Icons.location_on_outlined,
                title: "${event.location.suburb}, ${event.location.city}",
                body: event.locationName,
                titleFontSize: CustomFontSize.sm,
                bodyFontSize: CustomFontSize.base,
                iconBoxSize: 40,
                iconSize: 20,
                onTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "About Event",
                style: TextStyle(
                    color: neutral.shade700,
                    fontSize: CustomFontSize.md,
                    fontWeight: FontWeight.bold),
              ),
              _buildEventDescription(event.shortDescription),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomChip(label: '${event.distance} km'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventName(String eventName) {
    return Text(
      eventName,
      style: TextStyle(
        color: neutral.shade700,
        fontSize: CustomFontSize.md,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildParticipantsDetail(int participantsCount) {
    return RichText(
      text: TextSpan(
        text: participantsCount.toString(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: neutral.shade900,
          fontSize: CustomFontSize.sm,
        ),
        children: const <TextSpan>[
          TextSpan(
            text: " people are going",
            style: TextStyle(
              fontSize: CustomFontSize.sm,
              color: neutral,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventDescription(String shortDescription) {
    return SeeMore(
      text: shortDescription == "-" ? "No description" : shortDescription,
      characterLimit: 140,
      fontSize: CustomFontSize.sm,
    );
  }
}
