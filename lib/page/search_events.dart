import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/buttons/search_bar.dart';
import 'package:flutter_boilerplate/common/components/layout/page_app_bar.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/date_parser.dart';
import 'package:flutter_boilerplate/event/bloc/search_event/search_event_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/search_event/search_event_state.dart';
import 'package:flutter_boilerplate/event/components/event_card_large.dart';
import 'package:flutter_boilerplate/event/data/search_event/models/filter_event_page_model.dart';
import 'package:flutter_boilerplate/event/data/search_event/search_event_repository.dart';
import 'package:flutter_boilerplate/page/event_detail.dart';
import 'package:flutter_boilerplate/page/search_events_filter.dart';

class SearchEvents extends StatefulWidget {
  const SearchEvents({Key? key}) : super(key: key);
  static const routeName = '/search-events';

  @override
  State<SearchEvents> createState() => _SearchEventsState();
}

class _SearchEventsState extends State<SearchEvents>
    with AutomaticKeepAliveClientMixin<SearchEvents> {
  bool keepAlive = true;
  FilterEventPageModel filter = FilterEventPageModel();
  late SearchEventsCubit _searchEventsCubit;

  @override
  void initState() {
    super.initState();
    _searchEventsCubit = SearchEventsCubit(SearchEventsRepositoryImpl());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => _searchEventsCubit..searchEvents(filter),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const PageAppBar(title: "Search Events"),
        body: Container(
          color: Theme.of(context).colorScheme.secondary,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(top: CustomPadding.sm),
            child: Column(
              children: [
                BuildSearchEvents(
                  searchEventsCubit: _searchEventsCubit,
                ),
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
  final SearchEventsCubit searchEventsCubit;
  const BuildSearchEvents(
      {Key? key, this.errorMessage = '', required this.searchEventsCubit})
      : super(key: key);

  @override
  State<BuildSearchEvents> createState() => _BuildSearchEventsState();
}

class _BuildSearchEventsState extends State<BuildSearchEvents> {
  TextEditingController textEditingController = TextEditingController();
  late FilterEventPageModel filter =
      FilterEventPageModel(searchTerm: textEditingController.text);
  late FilterEventPageModel filterInitial = filter;

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(() {
      filter = filter.copyWith(searchTerm: textEditingController.text);
      if (filterInitial.searchTerm != filter.searchTerm) {
        widget.searchEventsCubit.searchEvents(filter);
      }
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: CustomPadding.body),
            child: SearchBar(
              textEditingController: textEditingController,
              label: 'Search event...',
              hasSecondIcon: true,
              secondIcon: const Icon(Icons.filter_list),
              iconOnPressedHandler: () async {
                final cubit = context.read<SearchEventsCubit>();
                String? response = await showGeneralDialog(
                    context: context,
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return StatefulBuilder(
                          builder: (context, StateSetter newSetState) {
                        return SearchEventsFilter(
                          setState: newSetState,
                          filter: filter,
                          onCategoryTap: handleCategoryTap,
                          onTimeTap: handleTimeTap,
                          onDistanceTap: handleDistanceTap,
                          onSortTap: handleSortTap,
                          resetFilter: resetFilter,
                          onAllTap: handleAllTap,
                        );
                      });
                    });
                if (response == "submit") {
                  // SUBMIT AND UPDATE INITIAL HERE
                  filterInitial = filter;
                  // reset page count
                  cubit.searchEvents(filter);
                } else {
                  cancelFilter();
                }
              },
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const SizedBox(
            height: 28,
          ),
          BlocConsumer<SearchEventsCubit, SearchEventsState>(
              listener: (context, state) {
            // if (state is PopularEventsSuccessState) {
            //   if (state.events.isNotEmpty) {
            //     for (var resEvent in state.events) {
            //       if (!eventList.contains(resEvent)) {
            //         eventList.add(resEvent);
            //       }
            //     }
            //   }
            // } else if (state is PopularEventsFilterState) {
            //   eventList = [];
            //   searchEvents(context, filter);
            // }
          }, builder: (context, state) {
            if (state is SearchEventsErrorState) {
              return Text(state.errorMessage);
            }
            bool isSuccessState = state is SearchEventsSuccessState;
            ScrollController scrollController = ScrollController();
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
                                    .read<SearchEventsCubit>()
                                    .getMoreEvents(filter, state.pageCount);
                              }
                            }),
                          children: state.events.map((event) {
                            List<String> splittedDate =
                                DateParser.parseEventDate(event.date);
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: EventCardLarge(
                                  title: event.eventName,
                                  author: event.eventCreator.username,
                                  distance: event.distance,
                                  location:
                                      '${event.locationName}, ${event.location.city}',
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

  void cancelFilter() {
    filter = filterInitial;
  }

  void resetFilter() {
    filter = FilterEventPageModel(searchTerm: filter.searchTerm);
  }

  void handleAllTap() {
    if (!filter.allCheck) {
      filter = filter.copyWith(
          allCheck: true,
          prefCheck: filter.prefCheck
              .map((pref) => pref.copyWith(isPicked: true))
              .toList());
    }
  }

  void handleCategoryTap(PrefType choosenCategory) {
    if (!filter.isOnePreferencePicked(choosenCategory)) {
      filter = filter.copyWith(
          allCheck: false,
          prefCheck: filter.prefCheck
              .map((pref) => pref.data == choosenCategory
                  ? pref.copyWith(
                      isPicked: filter.allCheck ? null : !pref.isPicked)
                  : pref.copyWith(isPicked: filter.allCheck ? false : null))
              .toList());
    }
  }

  void handleTimeTap(TimeFilter choosenTime) {
    filter = filter.copyWith(
        timeCheck: filter.timeCheck
            .map((time) => time.data == choosenTime
                ? time.copyWith(isPicked: !time.isPicked)
                : time.copyWith(isPicked: false))
            .toList());
  }

  void handleDistanceTap(DistanceFilter choosenDistance) {
    filter = filter.copyWith(
        distanceCheck: filter.distanceCheck
            .map((distance) => distance.data == choosenDistance
                ? distance.copyWith(isPicked: !distance.isPicked)
                : distance.copyWith(isPicked: false))
            .toList());
  }

  void handleSortTap(EventSort choosenSort) {
    filter = filter.copyWith(
        sortCheck: filter.sortCheck
            .map((sort) => sort.data == choosenSort
                ? sort.copyWith(isPicked: !sort.isPicked)
                : sort.copyWith(isPicked: false))
            .toList());
  }
}
