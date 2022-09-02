import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/layout/page_app_bar.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/bloc/popular_events_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/popular_events_state.dart';
import 'package:flutter_boilerplate/event/components/event_card_large.dart';
import 'package:flutter_boilerplate/event/components/filter_modal.dart';
import 'package:flutter_boilerplate/event/components/search_bar.dart';
import 'package:flutter_boilerplate/event/data/popular_event_model.dart';
import 'package:flutter_boilerplate/event/data/popular_events_repository.dart';
import 'package:flutter_boilerplate/page/event_detail.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:intl/intl.dart';

class SearchEvents extends StatefulWidget {
  const SearchEvents({Key? key}) : super(key: key);
  static const routeName = '/search-events';

  @override
  State<SearchEvents> createState() => _SearchEventsState();
}

class _SearchEventsState extends State<SearchEvents>
    with AutomaticKeepAliveClientMixin<SearchEvents> {
  bool keepAlive = true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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

  @override
  bool get wantKeepAlive => keepAlive;
}

class BuildSearchEvents extends StatefulWidget {
  final String errorMessage;

  const BuildSearchEvents({Key? key, this.errorMessage = ''}) : super(key: key);

  @override
  State<BuildSearchEvents> createState() => _BuildSearchEventsState();
}

class _BuildSearchEventsState extends State<BuildSearchEvents> {
  final scrollController = ScrollController();
  List<PrefType> categories = [];
  List<String> categoriesData = [];
  List<PopularEventModel> eventList = [];
  List<bool> prefCheck = [];
  bool allCheck = false;

  @override
  Widget build(BuildContext context) {
    for (var pref in PrefType.values) {
      if (categoriesData.contains(pref.name)) {
        prefCheck.add(false);
      } else {
        prefCheck.add(true);
      }
    }
    if (prefCheck.contains(false)) {
      allCheck = true;
    }
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: CustomPadding.body),
            child: SearchBar(
              label: 'Search event...',
              hasSecondIcon: true,
              secondIcon: const Icon(Icons.filter_list),
              iconOnPressedHandler: () async {
                await showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(CustomRadius.body),
                      ),
                    ),
                    builder: (context) => FilterModal(
                          initialCategories: categoriesData,
                          prefCheck: prefCheck,
                          allCheck: allCheck,
                        )).then((value) => setState(() {
                      categoriesData = value;
                    }));
                // ignore: use_build_context_synchronously
                context.read<PopularEventsCubit>().emitFilterState();
              },
            ),
          ),
          const SizedBox(
            height: 25,
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
            } else if (state is PopularEventsFilterState) {
              getAllPopularEvents(context, categoriesData);
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
