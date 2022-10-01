import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/data/search_location_response_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_location_model.dart';
import 'package:flutter_boilerplate/page/search/search_location.dart';

class CustomEventLocationField extends StatelessWidget {
  final CustomFormInput input;
  final TextStyle inputStyle;
  const CustomEventLocationField(
      {Key? key, required this.input, required this.inputStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: input.controller,
      readOnly: true,
      style: inputStyle,
      decoration: InputDecoration(
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
        fillColor: input.disable
            ? Theme.of(context).colorScheme.tertiary.withOpacity(0.41)
            : primary.shade300,
        suffixIcon: const Icon(Icons.place_outlined),
      ),
      onTap: () async {
        SearchLocationResponseModel? location = await Navigator.pushNamed(
                context, SearchLocation.routeName,
                arguments: input.initialgoogleMapSuburb)
            as SearchLocationResponseModel?;
        if (location == null) return;
        input.controller.text = location.name;
        input.lat = location.lat;
        input.lng = location.lng;
        input.googleMapSuburbId = location.suburbId;
        input.location =
            EventLocationModel(suburb: location.suburb, city: location.city);
      },
      validator: (value) {
        if (input.controller.text == "") {
          return "Required field";
        } else {
          return null;
        }
      },
    );
  }
}
