import 'package:flutter/cupertino.dart';
import 'package:flutter_boilerplate/auth/data/profile_location_model.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
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
  ProfileLocationModel suburb;
  ValueNotifier<bool>? switchController;
  bool? initialSwitchValue;

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
    this.suburb = const ProfileLocationModel(suburb: ""),
    this.initialSwitchValue,
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
}
