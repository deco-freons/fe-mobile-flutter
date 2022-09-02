import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/page_app_bar.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/bloc/popular_events_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/popular_events_state.dart';
import 'package:flutter_boilerplate/event/components/event_card_large.dart';
import 'package:flutter_boilerplate/event/components/home_content.dart';
import 'package:flutter_boilerplate/event/components/search_bar.dart';
import 'package:flutter_boilerplate/event/data/popular_event_model.dart';
import 'package:flutter_boilerplate/event/data/popular_events_repository.dart';
import 'package:flutter_boilerplate/page/event_detail.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/preference/components/preference_button.dart';
import 'package:intl/intl.dart';

class SearchEvents extends StatefulWidget {
  const SearchEvents({Key? key}) : super(key: key);
  static const routeName = '/search-events';

  @override
  State<SearchEvents> createState() => _SearchEventsState();
}

class _SearchEventsState extends State<SearchEvents> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PopularEventsCubit(PopularEventsRepositoryImpl())
        ..getAllPopularEvents([]),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const PageAppBar(title: "Search Events"),
        body: Container(
          color: Theme.of(context).colorScheme.secondary,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(top: CustomPadding.sm),
            child: Column(
              children: const [
                BuildSearchEvents(),
              ],
            ),
          )),
        ),
      ),
    );
  }
}

class BuildSearchEvents extends StatefulWidget {
  final String errorMessage;

  const BuildSearchEvents({Key? key, this.errorMessage = ''}) : super(key: key);

  @override
  State<BuildSearchEvents> createState() => _BuildSearchEventsState();
}

class _BuildSearchEventsState extends State<BuildSearchEvents> {
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: CustomPadding.body),
            child: SearchBar(
              label: 'Search event...',
              hasSecondIcon: true,
              secondIcon: const Icon(Icons.filter_list),
              iconOnPressedHandler: () {},
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          HomeContent(
            title: 'Categories',
            contentWidgets: [
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
                )
            ],
          ),
          const SizedBox(
            height: 28,
          ),
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomPadding.body),
                child: SizedBox(
                  width: double.infinity,
                  child: isSuccessState
                      ? ListView(
                          shrinkWrap: true,
                          controller: scrollController
                            ..addListener(() {
                              if (scrollController.offset ==
                                  scrollController.position.maxScrollExtent) {
                                context
                                    .read<PopularEventsCubit>()
                                    .getMoreEvents(
                                        categoriesData, state.pageCount);
                              }
                            }),
                          children: eventList.map((event) {
                            String formattedDate = DateFormat('MMMM dd, yyyy')
                                .format(DateTime.parse(event.date));
                            List<String> splittedDate =
                                formattedDate.split(' ');
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
                                    Navigator.of(context).pushNamed(
                                        EventDetail.routeName,
                                        arguments: event.eventID);
                                  },
                                ));
                          }).toList(),
                        )
                      : ListView(
                          shrinkWrap: true,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: CustomPadding.xl),
                              child:
                                  EventCardLarge.loading(onTapHandler: () {}),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: CustomPadding.xl),
                              child:
                                  EventCardLarge.loading(onTapHandler: () {}),
                            ),
                            EventCardLarge.loading(onTapHandler: () {})
                          ],
                        ),
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
