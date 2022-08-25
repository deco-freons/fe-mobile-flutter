import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/events/bloc/event_cubit.dart';
import 'package:flutter_boilerplate/events/bloc/popular_events_state.dart';
import 'package:flutter_boilerplate/events/components/event_card_small.dart';
import 'package:flutter_boilerplate/events/components/home_content.dart';
import 'package:flutter_boilerplate/events/data/event_model.dart';
import 'package:flutter_boilerplate/events/data/event_repository.dart';
import 'package:flutter_boilerplate/page/profile.dart';
import 'package:flutter_boilerplate/preference/components/preference_button.dart';

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
      create: (context) =>
          EventCubit(EventRepositoryImpl())..getPopularEvents([]),
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
                      decoration: BoxDecoration(color: grey.shade400)),
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
        BlocBuilder<EventCubit, PopularEventsState>(builder: (context, state) {
          if (state is PopularEventsLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          } else if (state is PopularEventsErrorState) {
            return Text(state.errorMessage);
          } else if (state is PopularEventsSuccessState) {
            return buildPopular(context, state.events);
          } else {
            return const Text('');
          }
        })
      ],
    );
  }

  Widget buildPopular(BuildContext context, List<EventModel> events) {
    return HomeContent(
        title: 'Popular events',
        isPopular: true,
        contentPadding: 30.0,
        titlePadding: 0.0,
        contentWidgets: buildEvents(events));
  }

  List<Widget> buildEvents(List<EventModel> events) {
    List<Widget> widgets = events.map((event) {
      return Padding(
        padding: const EdgeInsets.only(right: 25.0),
        child: EventCardSmall(
            title: event.eventName,
            distance: event.distance,
            month: 'Mar',
            date: '24',
            image: 'lib/common/assets/images/SmallEventTest.png'),
      );
    }).toList();
    return widgets;
  }

  void getPopularEvents(BuildContext context, List<String> data) {
    final cubit = context.read<EventCubit>();
    cubit.getPopularEvents(data);
  }
}
