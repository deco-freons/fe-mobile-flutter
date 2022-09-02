import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/bloc/update_event_detail_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/update_event_detail_state.dart';
import 'package:flutter_boilerplate/event/components/filter_button.dart';
import 'package:flutter_boilerplate/event/components/filter_content.dart';
import 'package:flutter_boilerplate/event/data/event_detail_repository.dart';
import 'package:flutter_boilerplate/get_it.dart';
import 'package:flutter_boilerplate/preference/components/preference_button.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({
    Key? key,
  }) : super(key: key);

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  List<bool> prefCheck = List.filled(PrefType.values.length, true);
  List<bool> weekCheck = List.filled(2, true);
  List<bool> distanceCheck = List.filled(3, true);
  bool allCheck = false;
  List<PrefType> categories = [];
  List<String> categoriesData = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UpdateEventDetailCubit(getIt.get<EventDetailRepository>()),
      child: BlocBuilder<UpdateEventDetailCubit, UpdateEventDetailState>(
        builder: (blocContext, state) {
          return Container(
            padding: const EdgeInsets.only(
                right: CustomPadding.xxl,
                left: CustomPadding.xxl,
                top: CustomPadding.xl),
            height: 600,
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomTextButton(
                    text: "Close",
                    onPressedHandler: () {
                      Navigator.pop(context);
                    },
                    fontSize: CustomFontSize.base,
                    type: TextButtonType.primary,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FilterContent(title: 'Categories', widgets: [
                  PreferenceButton(
                    type: PrefType.GM,
                    isAll: true,
                    elevation: 4.0,
                    onPressedHandler: () {
                      setState(() {
                        if (prefCheck.contains(false)) {
                          allCheck = !allCheck;
                        }
                      });
                      if (!allCheck) {
                        for (var category in categories) {
                          prefCheck[category.index] =
                              !prefCheck[category.index];
                        }
                        categories = [];
                        categoriesData = [];
                        // getPopularEvents(context, categoriesData);
                      }
                    },
                    click: allCheck,
                  ),
                  for (var pref in PrefType.values)
                    PreferenceButton(
                      type: pref,
                      elevation: 4.0,
                      onPressedHandler: () {
                        setState(() {
                          prefCheck[pref.index] = !prefCheck[pref.index];
                        });
                        if (!prefCheck[pref.index]) {
                          categories.add(pref);
                          categoriesData.add(pref.name);
                          if (!allCheck) {
                            allCheck = !allCheck;
                          }
                          // getAllPopularEvents(context, categoriesData);
                        } else if (!prefCheck.contains(false)) {
                          allCheck = false;
                          categories = [];
                          categoriesData = [];
                          // getAllPopularEvents(context, categoriesData);
                        } else {
                          categories.remove(pref);
                          categoriesData.remove(pref.name);
                          // getAllPopularEvents(context, categoriesData);
                        }
                      },
                      click: prefCheck[pref.index],
                    )
                ]),
                FilterContent(title: 'Week', widgets: [
                  FilterButton(
                      desc: 'This Week',
                      onPressedHandler: () {
                        setState(() {
                          if (weekCheck[0] && !weekCheck[1]) {
                            weekCheck[0] = !weekCheck[0];
                            weekCheck[1] = !weekCheck[1];
                          } else {
                            weekCheck[0] = !weekCheck[0];
                          }
                        });
                      },
                      click: weekCheck[0]),
                  FilterButton(
                      desc: 'Next Week',
                      onPressedHandler: () {
                        setState(() {
                          if (weekCheck[1] && !weekCheck[0]) {
                            weekCheck[1] = !weekCheck[1];
                            weekCheck[0] = !weekCheck[0];
                          } else {
                            weekCheck[1] = !weekCheck[1];
                          }
                        });
                      },
                      click: weekCheck[1])
                ]),
                FilterContent(title: 'Distance', widgets: [
                  FilterButton(
                      desc: '< 5 km>',
                      onPressedHandler: () {},
                      click: distanceCheck[0]),
                  FilterButton(
                      desc: '5 <= km < 10',
                      onPressedHandler: () {},
                      click: distanceCheck[1]),
                  FilterButton(
                      desc: '>= 10 km',
                      onPressedHandler: () {},
                      click: distanceCheck[2])
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
                        onPressedHandler: () {},
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
                        onPressedHandler: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
