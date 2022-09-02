import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/bloc/popular_events_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/popular_events_state.dart';
import 'package:flutter_boilerplate/event/components/event_card_small.dart';
import 'package:flutter_boilerplate/event/components/home_content.dart';
import 'package:flutter_boilerplate/event/data/popular_events_repository.dart';
import 'package:flutter_boilerplate/page/popular_events.dart';
import 'package:flutter_boilerplate/page/profile.dart';
import 'package:flutter_boilerplate/preference/components/preference_button.dart';
import 'package:intl/intl.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);
  static const routeName = '/homepage';

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with AutomaticKeepAliveClientMixin<Homepage> {
  bool keepAlive = true;
  double radiusValue = 10.0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => PopularEventsCubit(PopularEventsRepositoryImpl())
        ..getPopularEvents([], radiusValue),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.secondary),
          child: const SafeArea(child: BuildHome()),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => keepAlive;
}

class BuildHome extends StatefulWidget {
  final String errorMessage;

  const BuildHome({Key? key, this.errorMessage = ''}) : super(key: key);

  @override
  State<BuildHome> createState() => _BuildHomeState();
}

class _BuildHomeState extends State<BuildHome> {
  List<bool> clickCheck = List.filled(PrefType.values.length, true);
  bool allCheck = false;
  List<PrefType> categories = [];
  List<String> categoriesData = [];
  double radiusValue = 10.0;

  @override
  Widget build(BuildContext context) {
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
                  onTap: () {
                    Navigator.pushNamed(context, Profile.routeName);
                  },
                  child: CircleAvatar(
                    radius: 25,
                    child: Image.asset(
                        'lib/common/assets/images/CircleAvatarDefault.png'),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.notifications_outlined,
                    size: 45.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        HomeContent(
            title: 'Featured',
            isPair: true,
            secondWidget: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: neutral.shade500)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: DropdownButton(
                  items: const [
                    DropdownMenuItem(
                      value: 5.0,
                      child: Text('5 km'),
                    ),
                    DropdownMenuItem(
                      value: 10.0,
                      child: Text('10 km'),
                    ),
                    DropdownMenuItem(
                      value: 20.0,
                      child: Text('20 km'),
                    ),
                  ],
                  value: radiusValue,
                  onChanged: (double? selectedRadius) {
                    setState(() {
                      radiusValue = selectedRadius!;
                    });
                    getPopularEvents(context, categoriesData, radiusValue);
                  },
                  iconSize: 40.0,
                  iconEnabledColor: neutral.shade900,
                  underline: Container(
                    color: neutral.shade100,
                  ),
                ),
              ),
            ),
            contentWidgets: [
              Padding(
                padding: const EdgeInsets.only(
                    left: CustomPadding.body, right: CustomPadding.body),
                child: SizedBox(
                  width: 350,
                  height: 343.0,
                  child: DecoratedBox(
                      decoration: BoxDecoration(color: neutral.shade400)),
                ),
              ),
            ]),
        const SizedBox(
          height: 32,
        ),
        HomeContent(title: 'Categories', contentWidgets: [
          Padding(
            padding: const EdgeInsets.only(left: CustomPadding.body),
            child: PreferenceButton(
              type: PrefType.GM,
              isAll: true,
              elevation: 4.0,
              onPressedHandler: () {
                setState(() {
                  if (clickCheck.contains(false)) {
                    allCheck = !allCheck;
                  }
                });
                if (!allCheck) {
                  for (var category in categories) {
                    clickCheck[category.index] = !clickCheck[category.index];
                  }
                  categories = [];
                  categoriesData = [];
                  getPopularEvents(context, categoriesData, radiusValue);
                }
              },
              click: allCheck,
            ),
          ),
          for (var pref in PrefType.values)
            PreferenceButton(
              type: pref,
              elevation: 4.0,
              onPressedHandler: () {
                setState(() {
                  clickCheck[pref.index] = !clickCheck[pref.index];
                });
                if (!clickCheck[pref.index]) {
                  categories.add(pref);
                  categoriesData.add(pref.name);
                  if (!allCheck) {
                    allCheck = !allCheck;
                  }
                  getPopularEvents(context, categoriesData, radiusValue);
                } else if (!clickCheck.contains(false)) {
                  allCheck = false;
                  categories = [];
                  categoriesData = [];
                  getPopularEvents(context, categoriesData, radiusValue);
                } else {
                  categories.remove(pref);
                  categoriesData.remove(pref.name);
                  getPopularEvents(context, categoriesData, radiusValue);
                }
              },
              click: clickCheck[pref.index],
            )
        ]),
        const SizedBox(
          height: 22,
        ),
        BlocBuilder<PopularEventsCubit, PopularEventsState>(
            builder: (context, state) {
          if (state is PopularEventsErrorState) {
            return Center(child: Text(state.errorMessage));
          }
          bool isSuccessState = state is PopularEventsSuccessState;
          return Padding(
            padding: const EdgeInsets.only(bottom: CustomPadding.md),
            child: HomeContent(
                title: 'Popular events',
                titleBottomSpacing: CustomPadding.xs,
                isPair: true,
                secondWidget: CustomTextButton(
                    text: 'See All >',
                    fontSize: CustomFontSize.sm,
                    type: TextButtonType.tertiary,
                    onPressedHandler: () {
                      Navigator.pushNamed(context, PopularEvents.routeName);
                    }),
                contentWidgets: isSuccessState
                    ? state.events.map((event) {
                        String formattedDate = DateFormat('MMMM dd, yyyy')
                            .format(DateTime.parse(event.date));
                        List<String> splittedDate = formattedDate.split(' ');
                        return EventCardSmall(
                            eventID: event.eventID,
                            title: event.eventName,
                            distance: event.distance,
                            month: splittedDate[0].substring(0, 3),
                            date: splittedDate[1].substring(0, 2),
                            image:
                                'lib/common/assets/images/SmallEventTest.png');
                      }).toList()
                    : const [
                        EventCardSmall.loading(),
                        EventCardSmall.loading(),
                      ]),
          );
        }),
      ],
    );
  }

  void getPopularEvents(
      BuildContext context, List<String> data, double radius) {
    final cubit = context.read<PopularEventsCubit>();
    cubit.getPopularEvents(data, radius);
  }
}
