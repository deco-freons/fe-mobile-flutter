import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/components/layout/shimmer_widget.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/data/brisbane_location_model.dart';
import 'package:flutter_boilerplate/common/utils/brisbane_location_util.dart';
import 'package:flutter_boilerplate/event/data/common/event_location_model.dart';

class CustomUserLocationDropdown extends StatefulWidget {
  final CustomFormInput input;
  final TextStyle inputStyle;
  const CustomUserLocationDropdown(
      {Key? key, required this.input, required this.inputStyle})
      : super(key: key);

  @override
  State<CustomUserLocationDropdown> createState() =>
      _CustomUserLocationDropdownState();
}

class _CustomUserLocationDropdownState
    extends State<CustomUserLocationDropdown> {
  late Future<String> _brisbaneLocationJson;
  late List<BrisbaneLocationModel> _brisbaneLocations;

  @override
  void initState() {
    super.initState();
    _brisbaneLocationJson = BrisbaneLocationUtil.getJson(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _brisbaneLocationJson,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          List<dynamic> jsonResult = jsonDecode(snapshot.data!);

          _brisbaneLocations = BrisbaneLocationUtil.createModel(jsonResult);

          BrisbaneLocationModel? initialLocation;
          if (widget.input.initialValue != "") {
            initialLocation = _brisbaneLocations
                .where((element) => element.suburb == widget.input.initialValue)
                .toList()[0];

            widget.input.controller.text =
                initialLocation.location_id.toString();
            widget.input.location = EventLocationModel(
                suburb: initialLocation.suburb, city: initialLocation.city);
          }

          return DropdownSearch<dynamic>(
            selectedItem: initialLocation,
            dropdownBuilder: (context, selectedItem) {
              return Text(
                selectedItem != null
                    ? selectedItem.suburb
                    : widget.input.initialValue,
                style: widget.inputStyle,
              );
            },
            popupProps: PopupProps.menu(
              itemBuilder: (context, item, isSelected) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: CustomPadding.body,
                  vertical: CustomPadding.base,
                ),
                child: Text(
                  item.suburb,
                  style: widget.inputStyle,
                ),
              ),
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                style: widget.inputStyle,
                decoration: const InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            filterFn: (loc, filter) => loc.locationFilterBySuburb(filter),
            items: _brisbaneLocations,
            itemAsString: (loc) {
              return loc.suburb;
            },
            dropdownDecoratorProps: DropDownDecoratorProps(
              baseStyle: widget.inputStyle,
              dropdownSearchDecoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide.none,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                      width: 1.0, color: Theme.of(context).colorScheme.error),
                ),
                filled: true,
                fillColor: primary.shade300,
                suffixIcon: const Icon(Icons.place_outlined),
              ),
            ),
            onChanged: (value) {
              if (value != null) {
                widget.input.controller.text = value.location_id.toString();
                widget.input.location =
                    EventLocationModel(suburb: value.suburb, city: value.city);
              }
            },
            validator: (value) {
              if (value == null) {
                return "Required field";
              } else {
                return null;
              }
            },
          );
        } else {
          return const ShimmerWidget.rectangular(
            height: 64.0,
            shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          );
        }
      },
    );
  }
}
