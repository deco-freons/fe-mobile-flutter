import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/buttons/search_bar.dart';
import 'package:flutter_boilerplate/common/components/layout/page_app_bar.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/date_parser.dart';
import 'package:flutter_boilerplate/common/utils/debounce.dart';
import 'package:flutter_boilerplate/event/bloc/search_event/search_event_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/search_event/search_event_state.dart';
import 'package:flutter_boilerplate/event/components/event_card_large.dart';
import 'package:flutter_boilerplate/event/components/no_events_Card.dart';
import 'package:flutter_boilerplate/event/data/common/popular_event_model.dart';
import 'package:flutter_boilerplate/event/data/search_event/filter_event_page_model.dart';
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const PageAppBar(title: "Search Events", hasDivider: false),
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
  const BuildSearchEvents({
    Key? key,
  }) : super(key: key);

  @override
  State<BuildSearchEvents> createState() => _BuildSearchEventsState();
}

class _BuildSearchEventsState extends State<BuildSearchEvents> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final Debounce _debounce = Debounce(delay: const Duration(milliseconds: 500));
  late FilterEventPageModel filter =
      FilterEventPageModel(searchTerm: _textEditingController.text);
  late FilterEventPageModel filterInitial = filter;
  final SearchEventsCubit _searchEventsCubit =
      SearchEventsCubit(SearchEventsRepositoryImpl());
  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      filter = filter.copyWith(searchTerm: _textEditingController.text);
      if (filterInitial.searchTerm != filter.searchTerm) {
        _debounce(() {
          _searchEventsCubit.searchEvents(filter);
        });
      }
    });

    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        SearchEventsState state = _searchEventsCubit.state;
        if (state is SearchEventsSuccessState) {
          if (state.hasMore) {
            _searchEventsCubit.getMoreEvents(filter);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _debounce.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchEventsCubit>(
      create: (BuildContext blocContext) =>
          _searchEventsCubit..searchEvents(filter),
      child: Expanded(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: CustomPadding.body),
              child: SearchBar(
                textEditingController: _textEditingController,
                label: 'Search event...',
                hasSecondIcon: true,
                secondIcon: const Icon(Icons.filter_list),
                iconOnPressedHandler: () async {
                  String? response = await showGeneralDialog(
                      context: context,
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return buildFilterDialog();
                      });
                  if (response == "submit") {
                    filterInitial = filter;
                    _searchEventsCubit.searchEvents(filter);
                  } else {
                    cancelFilter();
                  }
                },
              ),
            ),
            Container(
              height: CustomPadding.base,
              decoration: BoxDecoration(
                color: neutral.shade100,
                border: Border(
                  bottom: BorderSide(width: 1.5, color: neutral.shade400),
                ),
              ),
            ),
            BlocConsumer<SearchEventsCubit, SearchEventsState>(
                listener: (context, state) {
              if (state is SearchEventsFetchMoreErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMsg),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            }, builder: (context, state) {
              if (state is SearchEventsErrorState) {
                return Text(state.errorMessage);
              }
              bool isSuccessState = state is SearchEventsSuccessState;
              bool isFetchMoreErrorState =
                  state is SearchEventsFetchMoreErrorState;
              bool isEventEmpty = false;
              isSuccessState
                  ? (state.events.isEmpty ? isEventEmpty = true : null)
                  : null;
              return Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: CustomPadding.body,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: isEventEmpty
                        ? const FittedBox(
                            child: Padding(
                            padding: EdgeInsets.only(top: CustomPadding.base),
                            child: NoEventsCard(),
                          ))
                        : isSuccessState || isFetchMoreErrorState
                            ? RefreshIndicator(
                                onRefresh: (() async {
                                  context
                                      .read<SearchEventsCubit>()
                                      .searchEvents(filter);
                                }),
                                child: SingleChildScrollView(
                                  controller: _scrollController,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: CustomPadding.base),
                                    child: Column(
                                      children: isSuccessState
                                          ? state.events
                                              .map((event) =>
                                                  buildEvent(context, event))
                                              .toList()
                                          : isFetchMoreErrorState
                                              ? state.events
                                                  .map((event) => buildEvent(
                                                      context, event))
                                                  .toList()
                                              : [],
                                    ),
                                  ),
                                ),
                              )
                            : ListView(
                                shrinkWrap: true,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: CustomPadding.xl,
                                        top: CustomPadding.base),
                                    child: EventCardLarge.loading(
                                        onTapHandler: () {}),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: CustomPadding.xl),
                                    child: EventCardLarge.loading(
                                        onTapHandler: () {}),
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
      ),
    );
  }

  Widget buildEvent(BuildContext context, PopularEventModel? event) {
    if (event == null) {
      return const SizedBox.shrink();
    }
    List<String> splittedDate = DateParser.parseEventDate(event.date);
    return Padding(
        key: ValueKey(event.eventID),
        padding: const EdgeInsets.only(bottom: CustomPadding.lg),
        child: EventCardLarge(
          title: event.eventName,
          author: event.eventCreator.username,
          distance: event.distance,
          location: '${event.locationName}, ${event.location.city}',
          month: splittedDate[0].substring(0, 3),
          date: splittedDate[1].substring(0, 2),
          image: event.eventImage?.imageUrl,
          onTapHandler: () {
            Navigator.of(context)
                .pushNamed(EventDetail.routeName, arguments: event.eventID);
          },
        ));
  }

  Widget buildFilterDialog() {
    return StatefulBuilder(builder: (context, StateSetter newSetState) {
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
