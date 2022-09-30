import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_date_picker.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_image_input.dart';
import 'package:flutter_boilerplate/common/components/layout/shimmer_widget.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/data/brisbane_location_model.dart';
import 'package:flutter_boilerplate/common/data/item_filter_model.dart';
import 'package:flutter_boilerplate/common/data/search_location_response_model.dart';
import 'package:flutter_boilerplate/common/utils/brisbane_location_util.dart';
import 'package:flutter_boilerplate/event/data/common/event_location_model.dart';
import 'package:flutter_boilerplate/page/search/search_location.dart';
import 'package:flutter_boilerplate/preference/components/preference_button.dart';
import 'package:flutter_boilerplate/preference/data/preference_model.dart';

class CustomTextField extends StatefulWidget {
  final CustomFormInput input;
  final GlobalKey<FormState> formKey;
  final Color labelColor;
  final TextStyle inputStyle;

  const CustomTextField({
    Key? key,
    required this.input,
    required this.formKey,
    required this.labelColor,
    required this.inputStyle,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _error = false;
  bool _obscured = true;
  bool _confirmObscured = true;
  late Future<String> _brisbaneLocationJson;
  late List<BrisbaneLocationModel> _brisbaneLocations;

  TextStyle customFontStyle(double size) {
    return TextStyle(fontSize: size, fontWeight: FontWeight.bold);
  }

  TextStyle labelStyle() {
    return TextStyle(
      fontSize: CustomFontSize.base,
      fontWeight: FontWeight.bold,
      color: widget.labelColor,
    );
  }

  void toggleVisibility() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  void toggleConfirmVisibility() {
    setState(() {
      _confirmObscured = !_confirmObscured;
    });
  }

  void _selectTime(TextEditingController controller) async {
    final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input,
        builder: (context, childWidget) {
          return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: primary,
                    onSurface: primary,
                  ),
                ),
                child: childWidget!,
              ));
        });
    if (newTime != null) {
      String hour = newTime.hour < 10 ? "0${newTime.hour}" : "${newTime.hour}";
      String minute =
          newTime.minute < 10 ? "0${newTime.minute}" : "${newTime.minute}";
      controller.text = "$hour:$minute";
    }
  }

  void validateField() {
    setState(() {
      _error = !RegExp(widget.input.pattern)
                  .hasMatch(widget.input.controller.text) &&
              widget.input.errorMessage != ''
          ? true
          : false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.input.type == TextFieldType.suburbDropdown) {
      _brisbaneLocationJson = BrisbaneLocationUtil.getJson(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: CustomPadding.base),
      child: widget.input.type == TextFieldType.checkbox
          ? buildCheckbox()
          : widget.input.type == TextFieldType.toggleSwitch
              ? buildSwitch()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.input.label.isNotEmpty
                        ? widget.input.type != TextFieldType.eventTime
                            ? buildLabelRow()
                            : const SizedBox.shrink()
                        : const SizedBox.shrink(),
                    Padding(
                      padding: widget.input.label.isNotEmpty
                          ? const EdgeInsets.only(top: CustomPadding.base)
                          : EdgeInsets.zero,
                      child: widget.input.type == TextFieldType.date
                          ? CustomDatePicker(
                              input: widget.input,
                              firstDate: widget.input.firstDate,
                              lastDate: widget.input.lastDate,
                              inputStyle: widget.inputStyle,
                            )
                          : widget.input.type == TextFieldType.suburbDropdown
                              ? FutureBuilder<String>(
                                  future: _brisbaneLocationJson,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<String> snapshot) {
                                    if (snapshot.hasData) {
                                      List<dynamic> jsonResult =
                                          jsonDecode(snapshot.data!);

                                      _brisbaneLocations =
                                          BrisbaneLocationUtil.createModel(
                                              jsonResult);

                                      BrisbaneLocationModel? initialLocation;
                                      if (widget.input.initialValue != "") {
                                        initialLocation = _brisbaneLocations
                                            .where((element) =>
                                                element.suburb ==
                                                widget.input.initialValue)
                                            .toList()[0];

                                        widget.input.controller.text =
                                            initialLocation.location_id
                                                .toString();
                                        widget.input.location =
                                            EventLocationModel(
                                                suburb: initialLocation.suburb,
                                                city: initialLocation.city);
                                      }

                                      return DropdownSearch<dynamic>(
                                        selectedItem: initialLocation,
                                        dropdownBuilder:
                                            (context, selectedItem) {
                                          return Text(
                                            selectedItem != null
                                                ? selectedItem.suburb
                                                : widget.input.initialValue,
                                            style: widget.inputStyle,
                                          );
                                        },
                                        popupProps: PopupProps.menu(
                                          itemBuilder:
                                              (context, item, isSelected) =>
                                                  Padding(
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
                                        filterFn: (loc, filter) =>
                                            loc.locationFilterBySuburb(filter),
                                        items: _brisbaneLocations,
                                        itemAsString: (loc) {
                                          return loc.suburb;
                                        },
                                        dropdownDecoratorProps:
                                            DropDownDecoratorProps(
                                          baseStyle: widget.inputStyle,
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                            border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                              borderSide: BorderSide.none,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10.0)),
                                              borderSide: BorderSide(
                                                  width: 1.0,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .error),
                                            ),
                                            filled: true,
                                            fillColor: primary.shade300,
                                            suffixIcon: const Icon(
                                                Icons.place_outlined),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          if (value != null) {
                                            widget.input.controller.text =
                                                value.location_id.toString();
                                            widget.input.location =
                                                EventLocationModel(
                                                    suburb: value.suburb,
                                                    city: value.city);
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
                                )
                              : widget.input.type == TextFieldType.eventTime
                                  ? Row(
                                      children: [
                                        buildtimeField("Start time",
                                            widget.input.controller),
                                        const SizedBox(
                                          width: 25.0,
                                        ),
                                        buildtimeField("End time",
                                            widget.input.secondController!),
                                      ],
                                    )
                                  : widget.input.type == TextFieldType.location
                                      ? TextFormField(
                                          controller: widget.input.controller,
                                          readOnly: true,
                                          style: widget.inputStyle,
                                          decoration: InputDecoration(
                                            border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                              borderSide: BorderSide.none,
                                            ),
                                            filled: true,
                                            fillColor: widget.input.disable
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .tertiary
                                                    .withOpacity(0.41)
                                                : primary.shade300,
                                            suffixIcon: const Icon(
                                                Icons.place_outlined),
                                          ),
                                          onTap: () async {
                                            SearchLocationResponseModel?
                                                location =
                                                await Navigator.pushNamed(
                                                        context,
                                                        SearchLocation.routeName,
                                                        arguments: widget.input
                                                            .initialgoogleMapSuburb)
                                                    as SearchLocationResponseModel?;
                                            if (location == null) return;
                                            widget.input.controller.text =
                                                location.name;
                                            widget.input.lat = location.lat;
                                            widget.input.lng = location.lng;
                                            widget.input.googleMapSuburbId =
                                                location.suburbId;
                                            widget.input.location =
                                                EventLocationModel(
                                                    suburb: location.suburb,
                                                    city: location.city);
                                          },
                                        )
                                      : widget.input.type ==
                                              TextFieldType.eventImage
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomImageInput(
                                                  customFormInput: widget.input,
                                                  icon: Icon(
                                                    Icons.add_a_photo_rounded,
                                                    color: neutral.shade200,
                                                    size: 60,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: CustomPadding.sm,
                                                ),
                                                Text(
                                                  "Image cannot exceed 3MB (jpg, jpeg, png)",
                                                  style: TextStyle(
                                                    fontSize: CustomFontSize.xs,
                                                    color: neutral.shade500,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            )
                                          : widget.input.type ==
                                                  TextFieldType.profileImage
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomImageInput(
                                                      radius: 100,
                                                      width: 125,
                                                      height: 125,
                                                      customFormInput:
                                                          widget.input,
                                                      icon: Icon(
                                                        Icons.person,
                                                        color: neutral.shade100,
                                                        size: 100,
                                                      ),
                                                      overlayWidget: Positioned(
                                                        right: CustomPadding.sm,
                                                        bottom:
                                                            CustomPadding.md,
                                                        child: Icon(
                                                          Icons
                                                              .camera_alt_rounded,
                                                          size: 32,
                                                          color:
                                                              neutral.shade200,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: CustomPadding.lg,
                                                    ),
                                                    Text(
                                                      "Image cannot exceed 3MB (jpg, jpeg, png)",
                                                      style: TextStyle(
                                                        fontSize:
                                                            CustomFontSize.xs,
                                                        color: neutral.shade500,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : widget.input.type ==
                                                      TextFieldType.interest
                                                  ? Wrap(
                                                      spacing: CustomPadding.sm,
                                                      runSpacing: 0.0,
                                                      children:
                                                          widget
                                                                  .input
                                                                  .preferences
                                                                  .isNotEmpty
                                                              ? widget.input
                                                                  .preferences
                                                                  .map(
                                                                    (pref) =>
                                                                        PreferenceButton(
                                                                      stringInput:
                                                                          pref.preferenceName,
                                                                      useStringInput:
                                                                          true,
                                                                      cancelIcon:
                                                                          true,
                                                                      onPressedHandler:
                                                                          () {
                                                                        widget
                                                                            .input
                                                                            .removePreferences(pref);
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                    ),
                                                                  )
                                                                  .toList()
                                                              : [
                                                                  Text(
                                                                    "No picked categories",
                                                                    style: customFontStyle(
                                                                        CustomFontSize
                                                                            .base),
                                                                  )
                                                                ],
                                                    )
                                                  : TextFormField(
                                                      controller: widget
                                                          .input.controller,
                                                      obscureText:
                                                          widget.input.type ==
                                                                  TextFieldType
                                                                      .password
                                                              ? _obscured
                                                              : false,
                                                      readOnly:
                                                          widget.input.disable,
                                                      keyboardType: widget
                                                                  .input.type ==
                                                              TextFieldType
                                                                  .textArea
                                                          ? TextInputType
                                                              .multiline
                                                          : TextInputType.text,
                                                      maxLines:
                                                          widget.input.type ==
                                                                  TextFieldType
                                                                      .textArea
                                                              ? 4
                                                              : 1,
                                                      maxLength: widget
                                                          .input.maxLength,
                                                      style: widget.inputStyle,
                                                      decoration:
                                                          InputDecoration(
                                                              hintText: widget
                                                                          .input
                                                                          .type ==
                                                                      TextFieldType
                                                                          .textArea
                                                                  ? 'Please enter ${widget.input.label} here...'
                                                                  : "",
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            10.0)),
                                                                borderSide: BorderSide(
                                                                    width: 1.0,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .error),
                                                              ),
                                                              border:
                                                                  const OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10.0)),
                                                                borderSide:
                                                                    BorderSide
                                                                        .none,
                                                              ),
                                                              errorText: _error
                                                                  ? widget.input
                                                                      .errorMessage
                                                                  : null,
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            10.0)),
                                                                borderSide: BorderSide(
                                                                    width: 1.0,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .error),
                                                              ),
                                                              filled: true,
                                                              fillColor: widget
                                                                      .input
                                                                      .disable
                                                                  ? Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .tertiary
                                                                      .withOpacity(
                                                                          0.41)
                                                                  : primary
                                                                      .shade300,
                                                              suffixIcon:
                                                                  widget.input.type ==
                                                                          TextFieldType
                                                                              .password
                                                                      ? _obscured
                                                                          ? IconButton(
                                                                              icon: const Icon(Icons.visibility_off),
                                                                              onPressed: () {
                                                                                toggleVisibility();
                                                                              },
                                                                            )
                                                                          : IconButton(
                                                                              icon: const Icon(Icons.visibility),
                                                                              onPressed: () {
                                                                                toggleVisibility();
                                                                              },
                                                                            )
                                                                      : null),
                                                      onChanged: (value) {
                                                        widget.input
                                                                .confirmField
                                                            ? widget.formKey
                                                                .currentState!
                                                                .validate()
                                                            : null;
                                                        validateField();
                                                      },
                                                    ),
                    ),
                    widget.input.confirmField
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                "Confirm ${widget.input.label}",
                                style: const TextStyle(
                                  fontSize: CustomFontSize.base,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 11.0,
                              ),
                              TextFormField(
                                controller: widget.input.confirmController,
                                validator: (value) {
                                  if (value != widget.input.controller.text) {
                                    return 'Have to be the same as your ${widget.input.label}';
                                  }
                                  return null;
                                },
                                obscureText:
                                    widget.input.type == TextFieldType.password
                                        ? _confirmObscured
                                        : false,
                                style: const TextStyle(
                                    fontSize: CustomFontSize.base,
                                    height: 1,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          width: 1.0,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error),
                                    ),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          width: 1.0,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error),
                                    ),
                                    filled: true,
                                    fillColor: primary.shade300,
                                    suffixIcon: widget.input.type ==
                                            TextFieldType.password
                                        ? _confirmObscured
                                            ? IconButton(
                                                icon: const Icon(
                                                    Icons.visibility_off),
                                                onPressed: () {
                                                  toggleConfirmVisibility();
                                                },
                                              )
                                            : IconButton(
                                                icon: const Icon(
                                                    Icons.visibility),
                                                onPressed: () {
                                                  toggleConfirmVisibility();
                                                },
                                              )
                                        : null),
                                onChanged: (value) {
                                  widget.formKey.currentState!.validate();
                                },
                              )
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
    );
  }

  Widget buildtimeField(String label, TextEditingController controller) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: labelStyle(),
          ),
          TextFormField(
            controller: controller,
            style: widget.inputStyle,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: primary.shade300,
              suffixIcon: const Icon(Icons.arrow_drop_down),
            ),
            readOnly: true,
            onTap: () {
              _selectTime(controller);
            },
          ),
        ],
      ),
    );
  }

  Widget buildCheckbox() {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        widget.input.label,
        style: const TextStyle(
          fontSize: CustomFontSize.sm,
          fontWeight: FontWeight.bold,
        ),
      ),
      value: widget.input.checkbox,
      onChanged: (e) {
        setState(() {
          widget.input.toggleCheckbox();
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget buildSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(widget.input.label,
                style: customFontStyle(CustomFontSize.sm))),
        AdvancedSwitch(
          controller: widget.input.switchController,
          activeColor: primary,
          inactiveColor: neutral,
          activeChild: Text(
            'ON',
            style: customFontStyle(CustomFontSize.xs),
          ),
          inactiveChild: Text(
            'OFF',
            style: customFontStyle(CustomFontSize.xs),
          ),
          borderRadius:
              const BorderRadius.all(Radius.circular(CustomRadius.xxl)),
          width: 60.0,
          height: 26.0,
          enabled: true,
        ),
      ],
    );
  }

  Widget buildLabelRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.input.label,
          style: labelStyle(),
        ),
        widget.input.type == TextFieldType.interest
            ? CustomTextButton(
                text: "Add",
                textWeight: FontWeight.normal,
                onPressedHandler: () async {
                  List<PrefType>? newPreferences =
                      await showModalBottomSheet<List<PrefType>>(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(CustomRadius.body),
                          topRight: Radius.circular(CustomRadius.body)),
                    ),
                    builder: (BuildContext context) {
                      return AddPreferenceModal(
                        initialPrefs: widget.input.preferences
                            .map((pref) => pref.preferenceID)
                            .toList(),
                      );
                    },
                  );
                  if (newPreferences != null) {
                    List<PreferenceModel> preferenceModels = newPreferences
                        .map((pref) => PreferenceModel(
                            preferenceID: pref.name, preferenceName: pref.desc))
                        .toList();
                    widget.input.setPreferences(preferenceModels);
                    setState(() {});
                  }
                })
            : const SizedBox.shrink(),
      ],
    );
  }
}

class AddPreferenceModal extends StatefulWidget {
  final List<String> initialPrefs;

  AddPreferenceModal({Key? key, List<String>? initialPrefs})
      : initialPrefs = initialPrefs ?? [],
        super(key: key);

  @override
  State<AddPreferenceModal> createState() => _AddPreferenceModalState();
}

class _AddPreferenceModalState extends State<AddPreferenceModal> {
  List<ItemFilterModel<PrefType>> prefs =
      PrefType.values.map((pref) => ItemFilterModel(data: pref)).toList();

  @override
  void initState() {
    super.initState();

    setState(() {
      prefs = prefs
          .map((pref) => widget.initialPrefs.contains(pref.data.name)
              ? pref.copyWith(isPicked: true)
              : pref)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 410,
      padding: const EdgeInsets.symmetric(horizontal: CustomPadding.lg),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(CustomRadius.body),
            topRight: Radius.circular(CustomRadius.body)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Wrap(
            spacing: CustomPadding.sm,
            runSpacing: 0.0,
            alignment: WrapAlignment.center,
            children: [
              for (var pref in PrefType.values)
                PreferenceButton(
                  type: pref,
                  onPressedHandler: () {
                    setState(() {
                      prefs = prefs
                          .map((currPref) => currPref.data == pref
                              ? currPref.copyWith(isPicked: !currPref.isPicked)
                              : currPref)
                          .toList();
                    });
                  },
                  isActive: prefs
                      .firstWhere((currPref) => currPref.data == pref)
                      .isPicked,
                ),
            ],
          ),
          const SizedBox(height: 53.0),
          CustomButton(
              label: "Add",
              type: ButtonType.primary,
              cornerRadius: CustomRadius.button,
              onPressedHandler: () {
                Navigator.pop(
                    context,
                    prefs
                        .where((pref) => pref.isPicked)
                        .map((pref) => pref.data)
                        .toList());
              }),
          const SizedBox(height: 20.0),
          CustomTextButton(
              text: "Cancel",
              type: TextButtonType.error,
              onPressedHandler: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
