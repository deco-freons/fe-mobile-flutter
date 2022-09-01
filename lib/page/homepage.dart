import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/bloc/popular_events_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/popular_events_state.dart';
import 'package:flutter_boilerplate/event/components/event_card_small.dart';
import 'package:flutter_boilerplate/event/components/home_content.dart';
import 'package:flutter_boilerplate/event/data/popular_events_repository.dart';
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => PopularEventsCubit(PopularEventsRepositoryImpl())
        ..getPopularEvents([]),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.secondary),
          child: SafeArea(child: buildHome()),
        ),
      ),
    );
  }

  Widget buildHome() {
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
        HomeContent(title: 'Featured', contentWidgets: [
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
        const ShowCategories(),
      ],
    );
  }

  @override
  bool get wantKeepAlive => keepAlive;
}

class ShowCategories extends StatefulWidget {
  final String errorMessage;

  const ShowCategories({Key? key, this.errorMessage = ''}) : super(key: key);

  @override
  State<ShowCategories> createState() => _ShowCategoriesState();
}

class _ShowCategoriesState extends State<ShowCategories> {
  List<bool> clickCheck = List.filled(PrefType.values.length, true);
  bool allCheck = false;
  List<PrefType> categories = [];
  List<String> categoriesData = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  getPopularEvents(context, categoriesData);
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
                  getPopularEvents(context, categoriesData);
                } else if (!clickCheck.contains(false)) {
                  allCheck = false;
                  categories = [];
                  categoriesData = [];
                  getPopularEvents(context, categoriesData);
                } else {
                  categories.remove(pref);
                  categoriesData.remove(pref.name);
                  getPopularEvents(context, categoriesData);
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
                isPopular: true,
                titleBottomSpacing: CustomPadding.xs,
                contentWidgets: isSuccessState
                    ? state.events
                        .asMap()
                        .map((i, event) {
                          String formattedDate = DateFormat('MMMM dd, yyyy')
                              .format(DateTime.parse(event.date));
                          List<String> splittedDate = formattedDate.split(' ');
                          return MapEntry(
                            i,
                            Padding(
                              padding: i == 0
                                  ? const EdgeInsets.only(
                                      left: CustomPadding.lg)
                                  : EdgeInsets.zero,
                              child: EventCardSmall(
                                  eventID: event.eventID,
                                  title: event.eventName,
                                  distance: event.distance,
                                  month: splittedDate[0].substring(0, 3),
                                  date: splittedDate[1].substring(0, 2),
                                  image:
                                      'lib/common/assets/images/SmallEventTest.png'),
                            ),
                          );
                        })
                        .values
                        .toList()
                    : const [
                        EventCardSmall.loading(),
                        EventCardSmall.loading(),
                      ]),
          );
        })
      ],
    );
  }

  void getPopularEvents(BuildContext context, List<String> data) {
    final cubit = context.read<PopularEventsCubit>();
    cubit.getPopularEvents(data);
  }
}
