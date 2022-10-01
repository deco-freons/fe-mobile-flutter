import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/components/search_event/filter_button.dart';
import 'package:flutter_boilerplate/event/components/search_event/filter_content.dart';
import 'package:flutter_boilerplate/event/data/search_event/filter_event_page_model.dart';
import 'package:flutter_boilerplate/preference/components/preference_button.dart';

class SearchEventsFilter extends StatelessWidget {
  final FilterEventPageModel filter;
  final void Function(PrefType) onCategoryTap;
  final void Function(TimeFilter) onTimeTap;
  final void Function(DistanceFilter) onDistanceTap;
  final void Function(SizeFilter) onSizeTap;
  final void Function(EventSort) onSortTap;
  final VoidCallback resetFilter;
  final VoidCallback onAllTap;
  final StateSetter setState;

  const SearchEventsFilter({
    Key? key,
    required this.filter,
    required this.onCategoryTap,
    required this.onTimeTap,
    required this.onDistanceTap,
    required this.onSortTap,
    required this.onSizeTap,
    required this.resetFilter,
    required this.onAllTap,
    required this.setState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: CustomPadding.xxl),
                  child: CustomTextButton(
                    text: "Close",
                    onPressedHandler: () {
                      Navigator.pop(context);
                    },
                    fontSize: CustomFontSize.base,
                    type: TextButtonType.primary,
                  ),
                ),
              ),
              Container(
                height: CustomPadding.sm,
                decoration: BoxDecoration(
                  color: neutral.shade100,
                  border: Border(
                    bottom: BorderSide(width: 1.5, color: neutral.shade400),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: CustomPadding.xxl),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      buildFilter()
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: neutral.shade100,
                  border: Border(
                    bottom: BorderSide(width: 1.5, color: neutral.shade400),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              buildBottomButtons(context)
            ],
          ),
        ),
      ),
    );
  }

  buildFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilterContent(
          title: 'Categories',
          widgets: [
            PreferenceButton(
              type: PrefType.GM,
              isAll: true,
              onPressedHandler: () {
                setState(() {
                  onAllTap();
                });
              },
              isActive: filter.allCheck,
            ),
            ...PrefType.values
                .map((pref) => PreferenceButton(
                      type: pref,
                      onPressedHandler: () {
                        setState(() {
                          onCategoryTap(pref);
                        });
                      },
                      isActive:
                          filter.allCheck ? false : filter.isFilterPicked(pref),
                    ))
                .toList()
          ],
        ),
        FilterContent(
          title: 'Week',
          widgets: TimeFilter.values
              .map((time) => FilterButton(
                    desc: time.desc,
                    onPressedHandler: () {
                      setState(() {
                        onTimeTap(time);
                      });
                    },
                    isActive: filter.isFilterPicked(time),
                  ))
              .toList(),
        ),
        FilterContent(
          title: 'Distance',
          widgets: DistanceFilter.values
              .map((distance) => FilterButton(
                    desc: distance.desc,
                    onPressedHandler: () {
                      setState(() {
                        onDistanceTap(distance);
                      });
                    },
                    isActive: filter.isFilterPicked(distance),
                  ))
              .toList(),
        ),
        FilterContent(
          title: 'Event Size',
          widgets: SizeFilter.values
              .map((size) => FilterButton(
                    desc: size.desc,
                    onPressedHandler: () {
                      setState(() {
                        onSizeTap(size);
                      });
                    },
                    isActive: filter.isFilterPicked(size),
                  ))
              .toList(),
        ),
        FilterContent(
            title: 'Sort',
            widgets: EventSort.values
                .map((sort) => FilterButton(
                      desc: sort.desc,
                      onPressedHandler: () {
                        setState(() {
                          onSortTap(sort);
                        });
                      },
                      isActive: filter.isFilterPicked(sort),
                    ))
                .toList()),
      ],
    );
  }

  buildBottomButtons(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: CustomPadding.xxl),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                label: "Clear filters",
                labelFontSize: CustomFontSize.sm,
                height: 40,
                width: 10,
                cornerRadius: 10.0,
                type: ButtonType.inverse,
                hasBorder: true,
                borderColor: neutral.shade400,
                elevation: 0,
                onPressedHandler: () {
                  setState(
                    () {
                      resetFilter();
                    },
                  );
                },
              ),
              CustomButton(
                label: "Show results",
                labelFontSize: CustomFontSize.sm,
                height: 40,
                width: 10,
                cornerRadius: 10.0,
                type: ButtonType.primary,
                elevation: 0,
                onPressedHandler: () {
                  Navigator.pop(context, "submit");
                },
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
