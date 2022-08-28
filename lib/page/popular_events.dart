import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/bloc/popular_events_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/popular_events_state.dart';
import 'package:flutter_boilerplate/event/components/event_card_large.dart';
import 'package:flutter_boilerplate/event/components/home_content.dart';
import 'package:flutter_boilerplate/event/data/popular_event_model.dart';
import 'package:flutter_boilerplate/event/data/popular_events_repository.dart';
import 'package:flutter_boilerplate/page/event_detail.dart';
import 'package:flutter_boilerplate/page/homepage.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/preference/components/preference_button.dart';
import 'package:intl/intl.dart';

class PopularEvents extends StatefulWidget {
  const PopularEvents({Key? key}) : super(key: key);
  static const routeName = '/popular-events';

  @override
  State<PopularEvents> createState() => _PopularEventsState();
}

class _PopularEventsState extends State<PopularEvents> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PopularEventsCubit(PopularEventsRepositoryImpl())
        ..getAllPopularEvents([]),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          color: Theme.of(context).colorScheme.secondary,
          child: SafeArea(
              child: Column(
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
                          icon: Icon(Icons.arrow_back,
                              color: neutral.shade900, size: 35.0),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Homepage.routeName);
                          },
                        )),
                    const Text(
                      'Popular Events',
                      style: TextStyle(
                          fontSize: 26.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const ShowCategories(),
            ],
          )),
        ),
      ),
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
  final scrollController = ScrollController();
  List<bool> clickCheck = List.filled(PrefType.values.length, true);
  bool allCheck = false;
  List<PrefType> categories = [];
  List<String> categoriesData = [];
  List<PopularEventModel> eventList = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          HomeContent(
              title: 'Categories',
              contentPadding: 25.0,
              contentWidgets: [
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
                          clickCheck[category.index] =
                              !clickCheck[category.index];
                        }
                        categories = [];
                        categoriesData = [];
                        getAllPopularEvents(context, categoriesData);
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
                          getAllPopularEvents(context, categoriesData);
                        } else if (!clickCheck.contains(false)) {
                          allCheck = false;
                          categories = [];
                          categoriesData = [];
                          getAllPopularEvents(context, categoriesData);
                        } else {
                          categories.remove(pref);
                          categoriesData.remove(pref.name);
                          getAllPopularEvents(context, categoriesData);
                        }
                      },
                      click: clickCheck[pref.index],
                    ),
                  )
              ]),
          BlocConsumer<PopularEventsCubit, PopularEventsState>(
              listener: (context, state) {
            if (state is PopularEventsSuccessState) {
              if (!(state.events.isEmpty && eventList.isNotEmpty)) {
                for (var resEvent in state.events) {
                  if (!eventList.contains(resEvent)) {
                    eventList.add(resEvent);
                  }
                }
                eventList.removeWhere((event) => !state.events.contains(event));
              }
            }
          }, builder: (context, state) {
            if (state is PopularEventsErrorState) {
              return Text(state.errorMessage);
            }
            bool isSuccessState = state is PopularEventsSuccessState;
            return Expanded(
              child: SizedBox(
                width: 350.0,
                child: isSuccessState
                    ? ListView(
                        shrinkWrap: true,
                        controller: scrollController
                          ..addListener(() {
                            if (scrollController.offset ==
                                scrollController.position.maxScrollExtent) {
                              context.read<PopularEventsCubit>().getMoreEvents(
                                  categoriesData, state.pageCount);
                            }
                          }),
                        children: eventList.map((event) {
                          String formattedDate = DateFormat('MMMM dd, yyyy')
                              .format(DateTime.parse(event.date));
                          List<String> splittedDate = formattedDate.split(' ');
                          return Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: EventCardLarge(
                                title: event.eventName,
                                author: event.eventCreator['username'],
                                distance: event.distance,
                                location:
                                    '${event.location[0]}, ${event.location[1]}',
                                month: splittedDate[0].substring(0, 3),
                                date: splittedDate[1].substring(0, 2),
                                image:
                                    'lib/common/assets/images/LargeEventTest.png',
                                onTapHandler: () {
                                  Navigator.of(context)
                                      .pushNamed(EventDetail.routeName,
                                          arguments: event.eventID)
                                      .then((_) => setState(() {}));
                                },
                              ));
                        }).toList(),
                      )
                    : ListView(
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 25.0),
                            child: EventCardLarge.loading(onTapHandler: () {}),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 25.0),
                            child: EventCardLarge.loading(onTapHandler: () {}),
                          ),
                          EventCardLarge.loading(onTapHandler: () {})
                        ],
                      ),
              ),
            );
          }),
        ],
      ),
    );
  }

  void getAllPopularEvents(BuildContext context, List<String> data) {
    final cubit = context.read<PopularEventsCubit>();
    cubit.getAllPopularEvents(data);
  }
}
