import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/events/bloc/event_cubit.dart';
import 'package:flutter_boilerplate/events/bloc/popular_events_state.dart';
import 'package:flutter_boilerplate/events/components/event_card_large.dart';
import 'package:flutter_boilerplate/events/components/home_content.dart';
import 'package:flutter_boilerplate/events/data/event_model.dart';
import 'package:flutter_boilerplate/events/data/event_repository.dart';
import 'package:flutter_boilerplate/page/homepage.dart';
import '../../common/config/enum.dart';
import '../preference/components/preference_button.dart';

class PopularEvents extends StatefulWidget {
  const PopularEvents({Key? key}) : super(key: key);
  static const routeName = '/popular-events';

  @override
  State<PopularEvents> createState() => _PopularEventsState();
}

class _PopularEventsState extends State<PopularEvents> {
  List<bool> clickCheck = List.filled(PrefType.values.length, true);
  bool allCheck = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EventCubit(EventRepositoryImpl())..getPopularEvents([]),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          color: Theme.of(context).colorScheme.secondary,
          child: SafeArea(child: buildPopularEvents()),
        ),
      ),
    );
  }

  Widget buildPopularEvents() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 54.0, left: 22.0, right: 40.0, bottom: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(right: 50.0),
                  child: IconButton(
                    icon:
                        const Icon(Icons.arrow_back, color: black, size: 35.0),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Homepage.routeName);
                    },
                  )),
              const Text(
                'Popular Events',
                style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
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
    return Column(
      children: buildEvents(events),
    );
  }

  List<Widget> buildEvents(List<EventModel> events) {
    List<Widget> widgets = events.map((event) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: EventCardLarge(
            title: event.eventName,
            author: event.eventCreator['username'],
            distance: event.distance,
            location: 'Marvel Stadium, Melbourne',
            month: 'Mar',
            date: '24',
            image: 'lib/common/assets/images/LargeEventTest.png'),
      );
    }).toList();
    return widgets;
  }

  void getPopularEvents(BuildContext context, List<String> data) {
    final cubit = context.read<EventCubit>();
    cubit.getPopularEvents(data);
  }
}
