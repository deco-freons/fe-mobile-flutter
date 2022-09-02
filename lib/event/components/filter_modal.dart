import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/bloc/filter_event_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/filter_event_state.dart';
import 'package:flutter_boilerplate/event/components/filter_button.dart';
import 'package:flutter_boilerplate/event/components/filter_content.dart';
import 'package:flutter_boilerplate/event/data/filter_event_modal_model.dart';
import 'package:flutter_boilerplate/preference/components/preference_button.dart';

// ignore: must_be_immutable
class FilterModal extends StatefulWidget {
  final FilterEventModalModel filter;

  const FilterModal({
    Key? key,
    required this.filter,
  }) : super(key: key);

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterEventCubit(),
      child: Container(
          padding: const EdgeInsets.only(
              right: CustomPadding.xxl,
              left: CustomPadding.xxl,
              top: CustomPadding.xl),
          height: 600,
          child: BuildFilterModal(filter: widget.filter)),
    );
  }
}

class BuildFilterModal extends StatefulWidget {
  final FilterEventModalModel filter;
  final String errorMessage;

  const BuildFilterModal(
      {Key? key, required this.filter, this.errorMessage = ''})
      : super(key: key);

  @override
  State<BuildFilterModal> createState() => _BuildFilterModalState();
}

class _BuildFilterModalState extends State<BuildFilterModal> {
  FilterEventModalModel filter = const FilterEventModalModel(
      categories: [],
      daysChoice: null,
      distanceChoice: null,
      allCheck: false,
      prefCheck: [],
      weekCheck: [],
      distanceCheck: []);

  FilterEventModalModel clearFilter = FilterEventModalModel(
      categories: const [],
      daysChoice: null,
      distanceChoice: null,
      allCheck: false,
      prefCheck: List.filled(PrefType.values.length, true),
      weekCheck: List.filled(DaysFilter.values.length, true),
      distanceCheck: List.filled(DistanceFilter.values.length, true));

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
              FilterEventModalModel filter = FilterEventModalModel(
                  categories: widget.filter.categories,
                  daysChoice: widget.filter.daysChoice,
                  distanceChoice: widget.filter.distanceChoice,
                  allCheck: widget.filter.allCheck,
                  prefCheck: widget.filter.prefCheck,
                  weekCheck: widget.filter.weekCheck,
                  distanceCheck: widget.filter.distanceCheck);
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
              filter = FilterEventModalModel(
                  categories: const [],
                  daysChoice: null,
                  distanceChoice: null,
                  allCheck: false,
                  prefCheck: List.filled(PrefType.values.length, true),
                  weekCheck: List.filled(DaysFilter.values.length, true),
                  distanceCheck:
                      List.filled(DistanceFilter.values.length, true));
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
  final FilterEventModalModel filter;

  const BuildFilter({Key? key, required this.filter}) : super(key: key);

  @override
  State<BuildFilter> createState() => _BuildFilterState();
}

class _BuildFilterState extends State<BuildFilter> {
  List<PrefType> categories = [];
  DaysFilter? daysChoice;
  DistanceFilter? distanceChoice;
  bool allCheck = false;
  List<bool> prefCheck = [];
  List<bool> weekCheck = [];
  List<bool> distanceCheck = [];

  @override
  void initState() {
    super.initState();
    categories = List.from(widget.filter.categories);
    daysChoice = widget.filter.daysChoice;
    distanceChoice = widget.filter.distanceChoice;
    allCheck = widget.filter.allCheck;
    prefCheck = List.from(widget.filter.prefCheck);
    weekCheck = List.from(widget.filter.weekCheck);
    distanceCheck = List.from(widget.filter.distanceCheck);
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
                  FilterEventModalModel filter = FilterEventModalModel(
                      categories: categories,
                      daysChoice: daysChoice,
                      distanceChoice: distanceChoice,
                      allCheck: allCheck,
                      prefCheck: prefCheck,
                      weekCheck: weekCheck,
                      distanceCheck: distanceCheck);
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
  final FilterEventModalModel filter;

  const BuildClearFilter({Key? key, required this.filter}) : super(key: key);

  @override
  State<BuildClearFilter> createState() => _BuildClearFilterState();
}

class _BuildClearFilterState extends State<BuildClearFilter> {
  List<PrefType> categories = [];
  DaysFilter? daysChoice;
  DistanceFilter? distanceChoice;
  bool allCheck = false;
  List<bool> prefCheck = [];
  List<bool> weekCheck = [];
  List<bool> distanceCheck = [];

  @override
  void initState() {
    super.initState();
    categories = List.from(widget.filter.categories);
    daysChoice = widget.filter.daysChoice;
    distanceChoice = widget.filter.distanceChoice;
    allCheck = widget.filter.allCheck;
    prefCheck = List.from(widget.filter.prefCheck);
    weekCheck = List.from(widget.filter.weekCheck);
    distanceCheck = List.from(widget.filter.distanceCheck);
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
                  FilterEventModalModel filter = FilterEventModalModel(
                      categories: categories,
                      daysChoice: daysChoice,
                      distanceChoice: distanceChoice,
                      allCheck: allCheck,
                      prefCheck: prefCheck,
                      weekCheck: weekCheck,
                      distanceCheck: distanceCheck);
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
