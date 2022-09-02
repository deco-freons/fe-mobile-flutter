import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/components/filter_button.dart';
import 'package:flutter_boilerplate/event/components/filter_content.dart';
import 'package:flutter_boilerplate/preference/components/preference_button.dart';

// ignore: must_be_immutable
class FilterModal extends StatefulWidget {
  final List<String> initialCategories;
  List<bool> prefCheck;
  bool allCheck;

  FilterModal({
    Key? key,
    required this.initialCategories,
    required this.prefCheck,
    required this.allCheck,
  }) : super(key: key);

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  List<bool> weekCheck = List.filled(2, true);
  List<bool> distanceCheck = List.filled(3, true);
  List<PrefType> categories = [];
  List<String> categoriesData = [];

  @override
  Widget build(BuildContext context) {
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
                Navigator.pop(context, widget.initialCategories);
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
              onPressedHandler: () {
                setState(() {
                  if (widget.prefCheck.contains(false)) {
                    widget.allCheck = !widget.allCheck;
                  }
                });
                if (!widget.allCheck) {
                  for (var category in categories) {
                    widget.prefCheck[category.index] =
                        !widget.prefCheck[category.index];
                  }
                  categories = [];
                  categoriesData = [];
                }
              },
              click: widget.allCheck,
            ),
            for (var pref in PrefType.values)
              PreferenceButton(
                type: pref,
                onPressedHandler: () {
                  setState(() {
                    widget.prefCheck[pref.index] =
                        !widget.prefCheck[pref.index];
                  });
                  if (!widget.prefCheck[pref.index]) {
                    categories.add(pref);
                    categoriesData.add(pref.name);
                    if (!widget.allCheck) {
                      widget.allCheck = !widget.allCheck;
                    }
                  } else if (!widget.prefCheck.contains(false)) {
                    widget.allCheck = false;
                    categories = [];
                    categoriesData = [];
                  } else {
                    categories.remove(pref);
                    categoriesData.remove(pref.name);
                  }
                },
                click: widget.prefCheck[pref.index],
              ),
          ]),
          FilterContent(title: 'Week', widgets: [
            for (var week in WeekFilter.values)
              FilterButton(
                desc: week.desc,
                onPressedHandler: () {
                  setState(() {
                    if (weekCheck.contains(false)) {
                      if (!weekCheck[week.index]) {
                        weekCheck[week.index] = !weekCheck[week.index];
                      } else {
                        weekCheck = List.filled(2, true);
                        weekCheck[week.index] = false;
                      }
                    } else {
                      weekCheck[week.index] = !weekCheck[week.index];
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
                      } else {
                        distanceCheck = List.filled(3, true);
                        distanceCheck[distance.index] = false;
                      }
                    } else {
                      distanceCheck[distance.index] =
                          !distanceCheck[distance.index];
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
                  onPressedHandler: () {
                    Navigator.pop(context, categoriesData);
                  },
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
  }
}
