import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/components/search_event/filter_button.dart';
import 'package:flutter_boilerplate/event/components/search_event/filter_content.dart';
import 'package:flutter_boilerplate/event/data/search_event/filter_event_page_model.dart';
import 'package:flutter_boilerplate/preference/components/preference_button.dart';

class SearchEventsFilter extends StatefulWidget {
  final FilterEventPageModel filter;
  final void Function(PrefType) onCategoryTap;
  final void Function(TimeFilter) onTimeTap;
  final void Function(DistanceFilter) onDistanceTap;
  final void Function(SizeFilter) onSizeTap;
  final void Function(EventSort) onSortTap;
  final void Function(int) onPriceSlider;
  final void Function(List<bool>) onPanelTap;
  final void Function(List<bool>) resetFilter;
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
    required this.onPriceSlider,
    required this.onPanelTap,
    required this.resetFilter,
    required this.onAllTap,
    required this.setState,
  }) : super(key: key);

  @override
  State<SearchEventsFilter> createState() => _SearchEventsFilterState();
}

class _SearchEventsFilterState extends State<SearchEventsFilter> {
  List<bool> isOpen = [];

  @override
  void initState() {
    super.initState();
    isOpen = widget.filter.panelIsOpen;
  }

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
                child: ListView(
                  children: [buildFilter()],
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
    return ExpansionPanelList(
      elevation: 1,
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: ((i, isExpanded) {
        setState(() {
          isOpen[i] = !isExpanded;
          widget.onPanelTap(isOpen);
        });
      }),
      children: [
        buildExpansionPanel(
          widget.filter,
          0,
          'Categories',
          FilterContent(
            widgetPadding: CustomPadding.xxl,
            widgets: [
              PreferenceButton(
                type: PrefType.GM,
                isAll: true,
                onPressedHandler: () {
                  widget.setState(() {
                    widget.onAllTap();
                  });
                },
                isActive: widget.filter.allCheck,
              ),
              ...PrefType.values
                  .map((pref) => PreferenceButton(
                        type: pref,
                        onPressedHandler: () {
                          widget.setState(() {
                            widget.onCategoryTap(pref);
                          });
                        },
                        isActive: widget.filter.allCheck
                            ? false
                            : widget.filter.isFilterPicked(pref),
                      ))
                  .toList()
            ],
          ),
        ),
        buildExpansionPanel(
          widget.filter,
          1,
          'Days to Event',
          FilterContent(
            widgets: TimeFilter.values
                .map((time) => FilterButton(
                      desc: time.desc,
                      onPressedHandler: () {
                        widget.setState(() {
                          widget.onTimeTap(time);
                        });
                      },
                      isActive: widget.filter.isFilterPicked(time),
                    ))
                .toList(),
          ),
        ),
        buildExpansionPanel(
          widget.filter,
          2,
          'Distance',
          FilterContent(
            widgets: DistanceFilter.values
                .map((distance) => FilterButton(
                      desc: distance.desc,
                      onPressedHandler: () {
                        widget.setState(() {
                          widget.onDistanceTap(distance);
                        });
                      },
                      isActive: widget.filter.isFilterPicked(distance),
                    ))
                .toList(),
          ),
        ),
        buildExpansionPanel(
          widget.filter,
          3,
          'Event Size',
          FilterContent(
            widgets: SizeFilter.values
                .map((size) => FilterButton(
                      desc: size.desc,
                      onPressedHandler: () {
                        widget.setState(() {
                          widget.onSizeTap(size);
                        });
                      },
                      isActive: widget.filter.isFilterPicked(size),
                    ))
                .toList(),
          ),
        ),
        buildExpansionPanel(
          widget.filter,
          4,
          'Event Price',
          FilterContent(
            widgetPadding: CustomPadding.xs,
            widgets: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomPadding.xxl),
                child: Row(
                  mainAxisAlignment: widget.filter.chosenPrice.round() == 0 ||
                          widget.filter.chosenPrice.round() == 501
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceBetween,
                  children: (widget.filter.chosenPrice == 0)
                      ? [const Text('Free')]
                      : (widget.filter.chosenPrice == 501)
                          ? [const Text('Any price')]
                          : [
                              const Text('\$ 0'),
                              Text('\$ ${widget.filter.chosenPrice.round()}')
                            ],
                ),
              ),
              Slider(
                value: widget.filter.chosenPrice.toDouble(),
                onChanged: (chosenPrice) {
                  widget.setState(() {
                    widget.onPriceSlider(chosenPrice.round());
                  });
                },
                min: 0,
                max: 501.0,
                divisions: 500,
              )
            ],
          ),
        ),
        buildExpansionPanel(
          widget.filter,
          5,
          'Sort',
          FilterContent(
            widgetPadding: CustomPadding.base,
            widgets: EventSort.values
                .map((sort) => FilterButton(
                      desc: sort.desc,
                      onPressedHandler: () {
                        widget.setState(() {
                          widget.onSortTap(sort);
                        });
                      },
                      isActive: widget.filter.isFilterPicked(sort),
                    ))
                .toList(),
          ),
        ),
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
                  widget.setState(
                    () {
                      widget.resetFilter(widget.filter.panelIsOpen);
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

  ExpansionPanel buildExpansionPanel(
      FilterEventPageModel filter, int index, String title, Widget widget) {
    return ExpansionPanel(
      canTapOnHeader: true,
      isExpanded: filter.panelIsOpen[index],
      headerBuilder: (context, isExpanded) {
        return Padding(
          padding: const EdgeInsets.only(
              top: CustomPadding.base, left: CustomPadding.xxl),
          child: Text(
            title,
            style: const TextStyle(
                fontSize: CustomFontSize.md, fontWeight: FontWeight.bold),
          ),
        );
      },
      body: widget,
    );
  }
}
