import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/event/data/event_location_model.dart';
import 'package:flutter_boilerplate/preference/data/preference_model.dart';

class CustomFormInput {
  String label;
  TextFieldType type;
  DateTime firstDate;
  DateTime lastDate;
  String pattern;
  String errorMessage;
  bool confirmField;
  String initialValue;
  String initialSecondValue;
  TextEditingController controller = TextEditingController();
  TextEditingController? secondController;
  TextEditingController confirmController = TextEditingController();
  double lat;
  double lng;
  bool disable;
  List<PreferenceModel> preferences;
  bool checkbox;
  EventLocationModel location;
  ValueNotifier<bool>? switchController;
  bool? initialSwitchValue;
  int? maxLength;
  int? googleMapSuburbId;
  String? initialgoogleMapSuburb;
  File? image;
  String? initialImage;
  CustomFormInput({
    required this.label,
    required this.type,
    DateTime? firstDate,
    DateTime? lastDate,
    this.pattern = "",
    this.errorMessage = "",
    this.confirmField = false,
    String? initialValue,
    String? initialSecondValue,
    this.lat = 0,
    this.lng = 0,
    this.disable = false,
    List<PreferenceModel>? preferences,
    this.checkbox = false,
    this.location = const EventLocationModel(suburb: "", city: ""),
    this.initialSwitchValue,
    this.maxLength,
    this.googleMapSuburbId,
    this.initialgoogleMapSuburb,
    this.image,
    this.initialImage,
  })  : firstDate = firstDate ?? DateTime(1900),
        lastDate = lastDate ?? DateTime(2101),
        initialValue = initialValue ?? "",
        initialSecondValue = initialSecondValue ?? "",
        controller = TextEditingController(text: initialValue),
        secondController = (type == TextFieldType.eventTime)
            ? TextEditingController(text: initialSecondValue)
            : null,
        switchController = (type == TextFieldType.toggleSwitch)
            ? ValueNotifier<bool>(initialSwitchValue ?? false)
            : null,
        preferences = preferences ?? [];

  void initState() {
    controller.text = initialValue;
  }

  void setLatLng(double lat, double lng) {
    this.lat = lat;
    this.lng = lng;
  }

  void setPreferences(List<PreferenceModel> newPreferences) {
    preferences = newPreferences;
  }

  void removePreferences(PreferenceModel preference) {
    preferences.removeWhere((item) => item == preference);
  }

  void toggleCheckbox() {
    checkbox = !checkbox;
  }

  void setImage(File? newImage) {
    image = newImage;
  }
}
