import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/bloc/search_event/filter_event_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/search_event/filter_event_state.dart';
import 'package:flutter_boilerplate/event/components/search_event/filter_button.dart';
import 'package:flutter_boilerplate/event/components/search_event/filter_content.dart';
import 'package:flutter_boilerplate/event/data/search_event/filter_event_page_model.dart';
import 'package:flutter_boilerplate/preference/components/preference_button.dart';

class SearchEventsFilter extends StatefulWidget {
  static const routeName = "/search-events/filter";
  final FilterEventPageModel filter;

  const SearchEventsFilter({
    Key? key,
    required this.filter,
  }) : super(key: key);

  @override
  State<SearchEventsFilter> createState() => _SearchEventsFilterState();
}

class _SearchEventsFilterState extends State<SearchEventsFilter> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterEventCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
            color: Theme.of(context).colorScheme.secondary,
            padding: const EdgeInsets.symmetric(horizontal: CustomPadding.xxl),
            child: SafeArea(
                child: BuildSearchEventsFilter(filter: widget.filter))),
      ),
    );
  }
}

class BuildSearchEventsFilter extends StatefulWidget {
  final FilterEventPageModel filter;
  final String errorMessage;

  const BuildSearchEventsFilter(
      {Key? key, required this.filter, this.errorMessage = ''})
      : super(key: key);

  @override
  State<BuildSearchEventsFilter> createState() =>
      _BuildSearchEventsFilterState();
}

class _BuildSearchEventsFilterState extends State<BuildSearchEventsFilter> {
  FilterEventPageModel filter = const FilterEventPageModel(
      categories: [],
      daysChoice: null,
      distanceChoice: null,
      sortChoice: null,
      allCheck: false,
      prefCheck: [],
      weekCheck: [],
      distanceCheck: [],
      sortCheck: []);

  FilterEventPageModel clearFilter = FilterEventPageModel(
      categories: const [],
      daysChoice: null,
      distanceChoice: null,
      sortChoice: null,
      allCheck: false,
      prefCheck: List.filled(PrefType.values.length, true),
      weekCheck: List.filled(DaysFilter.values.length, true),
      distanceCheck: List.filled(DistanceFilter.values.length, true),
      sortCheck: List.filled(EventSort.values.length, true));

  @override
  Widget build(BuildContext context) {
    filter = widget.filter;
    return ListView(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: CustomTextButton(
            text: "Close",
            onPressedHandler: () {
              FilterEventPageModel filter = FilterEventPageModel(
                  categories: widget.filter.categories,
                  daysChoice: widget.filter.daysChoice,
                  distanceChoice: widget.filter.distanceChoice,
                  sortChoice: widget.filter.sortChoice,
                  allCheck: widget.filter.allCheck,
                  prefCheck: widget.filter.prefCheck,
                  weekCheck: widget.filter.weekCheck,
                  distanceCheck: widget.filter.distanceCheck,
                  sortCheck: widget.filter.sortCheck);
              Navigator.pop(context, filter);
            },
            fontSize: CustomFontSize.base,
            type: TextButtonType.primary,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        BlocConsumer<FilterEventCubit, FilterEventState>(
          listener: (context, state) {
            if (state is FilterEventClearState) {
              filter = FilterEventPageModel(
                  categories: const [],
                  daysChoice: null,
                  distanceChoice: null,
                  sortChoice: null,
                  allCheck: false,
                  prefCheck: List.filled(PrefType.values.length, true),
                  weekCheck: List.filled(DaysFilter.values.length, true),
                  distanceCheck:
                      List.filled(DistanceFilter.values.length, true),
                  sortCheck: List.filled(EventSort.values.length, true));
            }
          },
          builder: ((context, state) {
            if (state is FilterEventInitialState) {
              return BuildFilter(filter: filter);
            } else if (state is FilterEventClearState) {
              return BuildClearFilter(filter: clearFilter);
            } else {
              return Text(widget.errorMessage);
            }
          }),
        ),
      ],
    );
  }
}

class BuildFilter extends StatefulWidget {
  final FilterEventPageModel filter;

  const BuildFilter({Key? key, required this.filter}) : super(key: key);

  @override
  State<BuildFilter> createState() => _BuildFilterState();
}

class _BuildFilterState extends State<BuildFilter> {
  List<PrefType> categories = [];
  DaysFilter? daysChoice;
  DistanceFilter? distanceChoice;
  EventSort? sortChoice;
  bool allCheck = false;
  List<bool> prefCheck = [];
  List<bool> weekCheck = [];
  List<bool> distanceCheck = [];
  List<bool> sortCheck = [];

  @override
  void initState() {
    super.initState();
    categories = List.from(widget.filter.categories);
    daysChoice = widget.filter.daysChoice;
    distanceChoice = widget.filter.distanceChoice;
    sortChoice = widget.filter.sortChoice;
    allCheck = widget.filter.allCheck;
    prefCheck = List.from(widget.filter.prefCheck);
    weekCheck = List.from(widget.filter.weekCheck);
    distanceCheck = List.from(widget.filter.distanceCheck);
    sortCheck = List.from(widget.filter.sortCheck);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilterContent(title: 'Categories', widgets: [
          PreferenceButton(
            type: PrefType.GM,
            isAll: true,
            onPressedHandler: () {
              setState(() {
                if (prefCheck.contains(false)) {
                  allCheck = !allCheck;
                }
              });
              if (!allCheck) {
                for (var category in categories) {
                  prefCheck[category.index] = !prefCheck[category.index];
                }
                categories = [];
              }
            },
            click: allCheck,
          ),
          for (var pref in PrefType.values)
            PreferenceButton(
              type: pref,
              onPressedHandler: () {
                setState(() {
                  prefCheck[pref.index] = !prefCheck[pref.index];
                });
                if (!prefCheck[pref.index] && !categories.contains(pref)) {
                  categories.add(pref);
                  if (!allCheck) {
                    allCheck = !allCheck;
                  }
                } else if (!prefCheck.contains(false)) {
                  allCheck = false;
                  categories = [];
                } else {
                  categories.remove(pref);
                }
              },
              click: prefCheck[pref.index],
            ),
        ]),
        FilterContent(title: 'Week', widgets: [
          for (var week in DaysFilter.values)
            FilterButton(
              desc: week.desc,
              onPressedHandler: () {
                setState(() {
                  if (weekCheck.contains(false)) {
                    if (!weekCheck[week.index]) {
                      weekCheck[week.index] = !weekCheck[week.index];
                      daysChoice = null;
                    } else {
                      weekCheck = List.filled(DaysFilter.values.length, true);
                      weekCheck[week.index] = false;
                      daysChoice = week;
                    }
                  } else {
                    weekCheck[week.index] = !weekCheck[week.index];
                    daysChoice = week;
                  }
                });
              },
              click: weekCheck[week.index],
            )
        ]),
        FilterContent(title: 'Distance', widgets: [
          for (var distance in DistanceFilter.values)
            FilterButton(
              desc: distance.desc,
              onPressedHandler: () {
                setState(() {
                  if (distanceCheck.contains(false)) {
                    if (!distanceCheck[distance.index]) {
                      distanceCheck[distance.index] =
                          !distanceCheck[distance.index];
                      distanceChoice = null;
                    } else {
                      distanceCheck =
                          List.filled(DistanceFilter.values.length, true);
                      distanceCheck[distance.index] = false;
                      distanceChoice = distance;
                    }
                  } else {
                    distanceCheck[distance.index] =
                        !distanceCheck[distance.index];
                    distanceChoice = distance;
                  }
                });
              },
              click: distanceCheck[distance.index],
            )
        ]),
        FilterContent(title: 'Sort', widgets: [
          for (var sort in EventSort.values)
            FilterButton(
              desc: sort.desc,
              onPressedHandler: () {
                setState(() {
                  if (sortCheck.contains(false)) {
                    if (!sortCheck[sort.index]) {
                      sortCheck[sort.index] = !sortCheck[sort.index];
                      sortChoice = null;
                    } else {
                      sortCheck = List.filled(EventSort.values.length, true);
                      sortCheck[sort.index] = false;
                      sortChoice = sort;
                    }
                  } else {
                    sortCheck[sort.index] = !sortCheck[sort.index];
                    sortChoice = sort;
                  }
                });
              },
              click: sortCheck[sort.index],
            )
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 120.0,
              height: 40,
              child: CustomButton(
                label: "Clear filters",
                labelFontSize: CustomFontSize.sm,
                cornerRadius: 10.0,
                type: ButtonType.inverse,
                hasBorder: true,
                borderColor: neutral.shade400,
                elevation: 0,
                onPressedHandler: () {
                  context.read<FilterEventCubit>().emitClearState();
                },
              ),
            ),
            SizedBox(
              width: 120.0,
              height: 40,
              child: CustomButton(
                label: "Show results",
                labelFontSize: CustomFontSize.sm,
                cornerRadius: 10.0,
                type: ButtonType.primary,
                elevation: 0,
                onPressedHandler: () {
                  FilterEventPageModel filter = FilterEventPageModel(
                      categories: categories,
                      daysChoice: daysChoice,
                      distanceChoice: distanceChoice,
                      sortChoice: sortChoice,
                      allCheck: allCheck,
                      prefCheck: prefCheck,
                      weekCheck: weekCheck,
                      distanceCheck: distanceCheck,
                      sortCheck: sortCheck);
                  Navigator.pop(context, filter);
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20.0,
        )
      ],
    );
  }
}

class BuildClearFilter extends StatefulWidget {
  final FilterEventPageModel filter;

  const BuildClearFilter({Key? key, required this.filter}) : super(key: key);

  @override
  State<BuildClearFilter> createState() => _BuildClearFilterState();
}

class _BuildClearFilterState extends State<BuildClearFilter> {
  List<PrefType> categories = [];
  DaysFilter? daysChoice;
  DistanceFilter? distanceChoice;
  EventSort? sortChoice;
  bool allCheck = false;
  List<bool> prefCheck = [];
  List<bool> weekCheck = [];
  List<bool> distanceCheck = [];
  List<bool> sortCheck = [];

  @override
  void initState() {
    super.initState();
    categories = List.from(widget.filter.categories);
    daysChoice = widget.filter.daysChoice;
    distanceChoice = widget.filter.distanceChoice;
    sortChoice = widget.filter.sortChoice;
    allCheck = widget.filter.allCheck;
    prefCheck = List.from(widget.filter.prefCheck);
    weekCheck = List.from(widget.filter.weekCheck);
    distanceCheck = List.from(widget.filter.distanceCheck);
    sortCheck = List.from(widget.filter.sortCheck);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilterContent(title: 'Categories', widgets: [
          PreferenceButton(
            type: PrefType.GM,
            isAll: true,
            onPressedHandler: () {
              setState(() {
                if (prefCheck.contains(false)) {
                  allCheck = !allCheck;
                }
              });
              if (!allCheck) {
                for (var category in categories) {
                  prefCheck[category.index] = !prefCheck[category.index];
                }
                categories = [];
              }
            },
            click: allCheck,
          ),
          for (var pref in PrefType.values)
            PreferenceButton(
              type: pref,
              onPressedHandler: () {
                setState(() {
                  prefCheck[pref.index] = !prefCheck[pref.index];
                });
                if (!prefCheck[pref.index] && !categories.contains(pref)) {
                  categories.add(pref);
                  if (!allCheck) {
                    allCheck = !allCheck;
                  }
                } else if (!prefCheck.contains(false)) {
                  allCheck = false;
                  categories = [];
                } else {
                  categories.remove(pref);
                }
              },
              click: prefCheck[pref.index],
            ),
        ]),
        FilterContent(title: 'Week', widgets: [
          for (var week in DaysFilter.values)
            FilterButton(
              desc: week.desc,
              onPressedHandler: () {
                setState(() {
                  if (weekCheck.contains(false)) {
                    if (!weekCheck[week.index]) {
                      weekCheck[week.index] = !weekCheck[week.index];
                      daysChoice = null;
                    } else {
                      weekCheck = List.filled(DaysFilter.values.length, true);
                      weekCheck[week.index] = false;
                      daysChoice = week;
                    }
                  } else {
                    weekCheck[week.index] = !weekCheck[week.index];
                    daysChoice = week;
                  }
                });
              },
              click: weekCheck[week.index],
            )
        ]),
        FilterContent(title: 'Distance', widgets: [
          for (var distance in DistanceFilter.values)
            FilterButton(
              desc: distance.desc,
              onPressedHandler: () {
                setState(() {
                  if (distanceCheck.contains(false)) {
                    if (!distanceCheck[distance.index]) {
                      distanceCheck[distance.index] =
                          !distanceCheck[distance.index];
                      distanceChoice = null;
                    } else {
                      distanceCheck =
                          List.filled(DistanceFilter.values.length, true);
                      distanceCheck[distance.index] = false;
                      distanceChoice = distance;
                    }
                  } else {
                    distanceCheck[distance.index] =
                        !distanceCheck[distance.index];
                    distanceChoice = distance;
                  }
                });
              },
              click: distanceCheck[distance.index],
            )
        ]),
        FilterContent(title: 'Sort', widgets: [
          for (var sort in EventSort.values)
            FilterButton(
              desc: sort.desc,
              onPressedHandler: () {
                setState(() {
                  if (sortCheck.contains(false)) {
                    if (!sortCheck[sort.index]) {
                      sortCheck[sort.index] = !sortCheck[sort.index];
                      sortChoice = null;
                    } else {
                      sortCheck = List.filled(EventSort.values.length, true);
                      sortCheck[sort.index] = false;
                      sortChoice = sort;
                    }
                  } else {
                    sortCheck[sort.index] = !sortCheck[sort.index];
                    sortChoice = sort;
                  }
                });
              },
              click: sortCheck[sort.index],
            )
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 120.0,
              height: 40,
              child: CustomButton(
                label: "Clear filters",
                labelFontSize: CustomFontSize.sm,
                cornerRadius: 10.0,
                type: ButtonType.inverse,
                hasBorder: true,
                borderColor: neutral.shade400,
                elevation: 0,
                onPressedHandler: () {
                  context.read<FilterEventCubit>().emitClearState();
                },
              ),
            ),
            SizedBox(
              width: 120.0,
              height: 40,
              child: CustomButton(
                label: "Show results",
                labelFontSize: CustomFontSize.sm,
                cornerRadius: 10.0,
                type: ButtonType.primary,
                elevation: 0,
                onPressedHandler: () {
                  FilterEventPageModel filter = FilterEventPageModel(
                      categories: categories,
                      daysChoice: daysChoice,
                      distanceChoice: distanceChoice,
                      sortChoice: sortChoice,
                      allCheck: allCheck,
                      prefCheck: prefCheck,
                      weekCheck: weekCheck,
                      distanceCheck: distanceCheck,
                      sortCheck: sortCheck);
                  Navigator.pop(context, filter);
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20.0,
        )
      ],
    );
  }
}
