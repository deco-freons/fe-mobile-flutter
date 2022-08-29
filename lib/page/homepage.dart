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

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
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
          child: HomeContent(
              title: 'Featured',
              contentPadding: 45.0,
              contentWidgets: [
                SizedBox(
                  width: 322.0,
                  height: 343.0,
                  child: DecoratedBox(
                      decoration: BoxDecoration(color: neutral.shade400)),
                ),
              ]),
        ),
        const ShowCategories(),
      ],
    );
  }
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
        HomeContent(title: 'Categories', contentPadding: 25.0, contentWidgets: [
          Padding(
            padding: const EdgeInsets.only(right: 17.0),
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
            Padding(
              padding: const EdgeInsets.only(right: 17.0),
              child: PreferenceButton(
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
              ),
            )
        ]),
        BlocBuilder<PopularEventsCubit, PopularEventsState>(
            builder: (context, state) {
          if (state is PopularEventsErrorState) {
            return Center(child: Text(state.errorMessage));
          }
          bool isSuccessState = state is PopularEventsSuccessState;
          return HomeContent(
              title: 'Popular events',
              isPopular: true,
              contentPadding: 30.0,
              titlePadding: 0.0,
              contentWidgets: isSuccessState
                  ? state.events.map((event) {
                      String formattedDate = DateFormat('MMMM dd, yyyy')
                          .format(DateTime.parse(event.date));
                      List<String> splittedDate = formattedDate.split(' ');
                      return Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: EventCardSmall(
                            title: event.eventName,
                            distance: event.distance,
                            month: splittedDate[0].substring(0, 3),
                            date: splittedDate[1].substring(0, 2),
                            image:
                                'lib/common/assets/images/SmallEventTest.png'),
                      );
                    }).toList()
                  : const [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 4.0, top: 5.0, right: 32.0),
                        child: EventCardSmall.loading(),
                      ),
                      EventCardSmall.loading(),
                    ]);
        })
      ],
    );
  }

  void getPopularEvents(BuildContext context, List<String> data) {
    final cubit = context.read<PopularEventsCubit>();
    cubit.getPopularEvents(data);
  }
}
